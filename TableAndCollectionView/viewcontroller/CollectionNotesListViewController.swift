//
//  CollectionNotesListViewController.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class CollectionNotesListViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Collection"
        
        setUpViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(NoteCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cellHeader")
        collectionView.register(NoteCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "cellFooter")
        
        NotificationCenter.default.addObserver(self, selector: #selector(createNewNote), name: NSNotification.Name.saveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editNote), name: NSNotification.Name.editData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: NSNotification.Name.deleteData, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func createNewNote(notification: Notification){
        guard notification.object is Note else { return }
        collectionView.insertItems(at: [IndexPath(row: dataSource.notes.count - 1, section: 0)])
    }
    
    @objc func editNote(notification: Notification){
        guard let note = notification.object as? Note else { return }
        if let index = dataSource.notes.firstIndex(where: { n in
            n.id == note.id
        }){
            collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    @objc func deleteNote(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        collectionView.deleteItems(at: [indexPath])
    }
    
    private func setUpViews(){
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0)
        ])
    }
    
}

extension CollectionNotesListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NoteCollectionViewCell
        collectionViewCell.contentView.backgroundColor = .systemYellow
        let note = dataSource.notes[indexPath.row]
        collectionViewCell.titleLabel.text = note.title
        collectionViewCell.detailLabel.text = note.detail
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let noteCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellHeader", for: indexPath) as! NoteCollectionViewHeader
            noteCollectionViewHeader.titleLabel.text = "Section Header"
            return noteCollectionViewHeader
        case UICollectionView.elementKindSectionFooter:
            let noteCollectionViewFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellFooter", for: indexPath) as! NoteCollectionViewFooter
            noteCollectionViewFooter.titleLabel.text = "Section Footer"
            return noteCollectionViewFooter
        default:
            fatalError("Unexpected element kind")
        }
    }
    
}

extension CollectionNotesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellEstimatedSize = (collectionView.frame.width - 10) / 4 - 5
        return CGSize(width: collectionViewCellEstimatedSize, height: collectionViewCellEstimatedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionViewCellWidth = collectionView.frame.width
        return CGSize(width: collectionViewCellWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let collectionViewCellWidth = collectionView.frame.width
        return CGSize(width: collectionViewCellWidth, height: 100)
    }
    
}

extension CollectionNotesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.contentView.backgroundColor = .systemBackground
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                cell?.contentView.backgroundColor = .systemYellow
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let refreshAction = UIAction(title: "Refresh", image: UIImage(systemName: "arrow.clockwise.circle")) { (action) in
                collectionView.reloadItems(at: [indexPath])
            }
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { [weak self] (action) in
                guard let self = self else { return }
                let editViewController = EditNoteViewController()
                editViewController.note = dataSource.notes[indexPath.row]
                navigationController?.pushViewController(editViewController, animated: true)
            }
            let yes = UIAction(title: "Yes", image: UIImage(systemName: "checkmark.seal.fill")) { (action) in
                NotificationCenter.default.post(name: NSNotification.Name.deleteData, object: indexPath)
            }
            let no = UIAction(title: "No", image: UIImage(systemName: "xmark.app")) { _ in
                
            }
            let deleteAction = UIMenu(title: "Delete", image: UIImage(systemName: "trash.square"), options: .destructive, children: [yes, no])
            return UIMenu(title: "note", children: [refreshAction, editAction, deleteAction])
        }
    }
    
}

//
//  TableNotesListViewController.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 17/5/24.
//

import UIKit

class TableNotesListViewController: UIViewController {
    
    let tableView = UITableView();
    let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white;
        navigationItem.title = "Note List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle.on.rectangle"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .normal)
        
        setUpViews();
        
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(createNewNote), name: NSNotification.Name.saveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editNote), name: NSNotification.Name.editData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: NSNotification.Name.deleteData, object: nil)
    }
    
    @objc func rightBarButtonTapped(sender: UIBarButtonItem){
        let createNoteViewController = CreateNoteViewController()
        navigationController?.pushViewController(createNoteViewController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.layoutIfNeeded()
    }
    
    @objc func createNewNote(notification: Notification){
        guard notification.object is Note else { return }
        tableView.insertRows(at: [IndexPath(row: dataSource.notes.count - 1, section: 0)], with: .automatic)
    }
    
    @objc func editNote(notification: Notification){
        guard let note = notification.object as? Note else { return }
        if let index = dataSource.notes.firstIndex(where: { n in
            n.id == note.id
        }){
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
    
    @objc func deleteNote(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func setUpViews(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
}

extension TableNotesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        let note = dataSource.notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.detailLabel.text = note.detail
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Table Header"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Table Footer"
    }
    
}

extension TableNotesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, complete in
            guard let self = self else { return}
            let alertController = UIAlertController(title: "Confirmation", message: "Are you sure to remove?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "OK", style: .destructive) { _ in
                NotificationCenter.default.post(name: NSNotification.Name.deleteData, object: indexPath)
            }
            let noAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                complete(true)
            }
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            present(alertController, animated: true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, complete in
            guard let self = self else { return }
            let editNoteViewController = EditNoteViewController()
            editNoteViewController.note = dataSource.notes[indexPath.row]
            navigationController?.pushViewController(editNoteViewController, animated: true)
        }
        editAction.backgroundColor = .systemGreen
    
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
}

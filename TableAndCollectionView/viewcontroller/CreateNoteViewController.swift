//
//  CreateNoteViewController.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class CreateNoteViewController: NoteTemplateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create New Note"
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let note = Note(title: title, detail: detail)
        
        if NoteValidation.validate(target: self, title: title, detail: detail){
            let alertController = UIAlertController(title: "Success", message: "A new note has been added!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self = self else { return }
                titleTextField.text = ""
                detailTextView.text = ""
            }
            NotificationCenter.default.post(name: NSNotification.Name.saveData, object: note)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
    
}

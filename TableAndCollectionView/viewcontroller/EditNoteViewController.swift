//
//  EditNoteViewController.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class EditNoteViewController: NoteTemplateViewController {
    
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Note"
        
        titleTextField.text = note.title
        detailTextView.text = note.detail
    }
    
    @objc override func saveButtonTapped(sender: UIButton){
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        let note = Note(id: self.note.id, title: title, detail: detail)
        
        if NoteValidation.validate(target: self, title: title, detail: detail){
            let alertController = UIAlertController(title: "Success", message: "A new note has been edited!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) {  _ in
    
            }
            NotificationCenter.default.post(name: NSNotification.Name.editData, object: note)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
    
}

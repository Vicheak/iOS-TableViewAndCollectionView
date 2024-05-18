//
//  DataSource.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class DataSource {
    
    var notes: [Note]!
    
    init() {
        self.notes = [
            Note(title: "title", detail: "detail"),
            Note(title: "title", detail: "detail"),
            Note(title: "title", detail: "detail"),
            Note(title: "title", detail: "detail"),
            Note(title: "title", detail: "detail"),
            Note(title: "title", detail: "detail"),
            Note(title: "title", detail: "detail"),
        ]
        
        dataSourceNotification()
    }
    
    open func dataSourceNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(createNewNote), name: NSNotification.Name.saveData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editNote), name: NSNotification.Name.editData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote), name: NSNotification.Name.deleteData, object: nil)
    }
    
    @objc func createNewNote(notification: Notification){
        guard let note = notification.object as? Note else { return }
        self.notes.append(note)
    }
    
    @objc func editNote(notification: Notification){
        guard let note = notification.object as? Note else { return }
        if let index = notes.firstIndex(where: { n in
            n.id == note.id
        }){
            notes[index].title = note.title
            notes[index].detail = note.detail
        }
    }
    
    @objc func deleteNote(notification: Notification){
        guard let indexPath = notification.object as? IndexPath else { return }
        self.notes.remove(at: indexPath.row)
    }
    
}

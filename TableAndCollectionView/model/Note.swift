//
//  Note.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import Foundation

struct Note {
    
    var id: UUID
    var title: String
    var detail: String
    
    init(id: UUID, title: String, detail: String) {
        self.id = id
        self.title = title
        self.detail = detail
    }
    
    init(title: String, detail: String) {
        self.id = UUID()
        self.title = title
        self.detail = detail
    }
    
}

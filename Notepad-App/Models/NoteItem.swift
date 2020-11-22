//
//  NoteItem.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 22/11/20.
//

import Foundation
import RealmSwift

class NoteItem : Object {
    @objc dynamic var noteTitle : String = ""
    @objc dynamic var noteText : String = ""
    let noteCategory = LinkingObjects(fromType: NoteCategory.self, property: "categoryNotes")
}

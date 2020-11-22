//
//  NoteCategory.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 22/11/20.
//

import Foundation
import RealmSwift

class NoteCategory : Object {
    @objc dynamic var categoryName : String = ""
    @objc dynamic var categoryThemeColor : String = ".systemGray"
    let categoryNotes = List<NoteItem>()
}

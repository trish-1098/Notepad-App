//
//  AddNewNoteViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import RealmSwift

class AddNewNoteViewController: UIViewController {
    
    @IBOutlet weak var newNoteTitleTextField: UITextField!
    @IBOutlet weak var noteCategoryPickerView: UIPickerView!
    @IBOutlet weak var noteColorThemeSelectorScrollView: UIScrollView!
    
    let realmDB = try! Realm()
    
    var categoryArray : Results<NoteCategory>?
    var indexOfSelectedCategoryByUser : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryArray = realmDB.objects(NoteCategory.self)
        noteCategoryPickerView.dataSource = self
        noteCategoryPickerView.delegate = self
        
        
        // show  category selected if coming from noteview, othervwise make it random
    }
    
    @IBAction func saveNewNotePressed(_ sender: UIButton) {
        if let noteTitle = newNoteTitleTextField.text{
            let newNoteItem = NoteItem()
            newNoteItem.noteTitle = noteTitle
            newNoteItem.noteText = ""
//            newNoteItem.noteCategory = categoryArray[indexOfSelectedCategoryByUser]
            let noteSavedAlert = UIAlertController(title: noteTitle, message: "Note Saved", preferredStyle: .alert)
            noteSavedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.saveNewNote(newNoteItem)
                noteSavedAlert.dismiss(animated: true) {
                    self.performSegue(withIdentifier: "editNewNoteSegue", sender: nil)
                }
            }))
            self.present(noteSavedAlert, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func saveNewNote(_ newNote : NoteItem) {
        do {
            try realmDB.write {
                realmDB.add(newNote)
                print("New Notge Saved")
            }
        } catch {
            print("Error saving new note : \(error)")
        }
    }

}

extension AddNewNoteViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexOfSelectedCategoryByUser = row
    }
}
extension AddNewNoteViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray?[row].categoryName ?? "No Categories Yet"
    }
    
}

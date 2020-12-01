//
//  NoteEditViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import RealmSwift

class NoteEditViewController: UIViewController {

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var lastEditDateDetailsLabel: UILabel!
    @IBOutlet weak var actualNoteTextField: UITextField!
    
    let realmDB = try! Realm()
    
    var selectedNoteItem : NoteItem? {
        didSet {
//            print(selectedNoteItem?.noteTitle)
//            loadNoteItemDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if came from direct selection of note then keep back button active
        /*
         Code for that logic here
         */
        // otherwise
        navigationController?.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let _ = navigationController else { // _ for now
            fatalError()
        }
        if let selectedNote = selectedNoteItem {
            title = selectedNote.noteTitle
            loadNoteItemDetails()
        }
    }
    
    @IBAction func optionsButtonPressed(_ sender: UIBarButtonItem) {
        // present options in an alert (or find a new way) to save, edit, cancel, delete
        let noteOptionsAlert = UIAlertController(title: "Options", message: "", preferredStyle: .alert)
        
        let alertActionsArray : [UIAlertAction] = [
            UIAlertAction(title: "Save", style: .default, handler: { (_) in
                do {
                    try self.realmDB.write {
                        self.selectedNoteItem?.noteText = self.actualNoteTextField?.text ?? ""
                        self.selectedNoteItem?.dateLastEdited = Date()
                    }
                } catch {
                    print("Error saving note details")
                }
                let saveConfirmationAlert = UIAlertController(title: "Note Saved", message: "", preferredStyle: .alert)
                saveConfirmationAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (_) in
                    saveConfirmationAlert.dismiss(animated: true, completion: nil)
                }))
                self.present(saveConfirmationAlert, animated: true) {
                    self.actualNoteTextField?.text = self.selectedNoteItem?.noteText
                    self.lastEditDateDetailsLabel?.text = "\(String(describing: self.selectedNoteItem?.dateLastEdited))"
                }
            }),
            UIAlertAction(title: "Add Image", style: .default, handler: { (_) in
                // Adding image from Photos Code
            }),
            UIAlertAction(title: "Share", style: .default, handler: { (_) in
                // Sharing Code
            }),
            UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                noteOptionsAlert.dismiss(animated: true, completion: nil)
            })
        ]
        
        for alertAction in alertActionsArray {
            noteOptionsAlert.addAction(alertAction)
        }
        
        noteOptionsAlert.preferredAction = noteOptionsAlert.actions[0]
        
        self.present(noteOptionsAlert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func loadNoteItemDetails() {
        noteTitleTextField?.text = selectedNoteItem?.noteTitle
        lastEditDateDetailsLabel.text = "\(DateFormatter.localizedString(from: (selectedNoteItem?.dateLastEdited)!, dateStyle: .medium, timeStyle: .short))"
        actualNoteTextField?.text = selectedNoteItem?.noteText
    }
}

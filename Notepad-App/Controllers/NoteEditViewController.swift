//
//  NoteEditViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit

class NoteEditViewController: UIViewController {

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteEditTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func optionsButtonPressed(_ sender: UIBarButtonItem) {
        // present options in an alert (or find a new way) to save, edit, cancel, delete
        let noteOptionsAlert = UIAlertController(title: "Options", message: "", preferredStyle: .alert)
        
        let alertActionsArray : [UIAlertAction] = [
            UIAlertAction(title: "Save", style: .default, handler: { (_) in
                // Save notes to persistant storage Code
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
}

//
//  AddNewNoteViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit

class AddNewNoteViewController: UIViewController {
    
    @IBOutlet weak var newNoteTitleTextField: UITextField!
    @IBOutlet weak var noteCategoryPickerView: UIPickerView!
    @IBOutlet weak var noteColorThemeSelectorScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNewNotePressed(_ sender: UIButton) {
        // Code to save the note to persistant storage and redirect the user to NoteEditViewController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

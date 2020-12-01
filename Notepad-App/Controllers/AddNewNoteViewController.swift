//
//  AddNewNoteViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import RealmSwift
import ChameleonFramework

class AddNewNoteViewController: UIViewController {
    
    @IBOutlet weak var newNoteTitleTextField: UITextField!
    @IBOutlet weak var noteCategoryPickerView: UIPickerView!
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var addNoteStackView: UIStackView!
    @IBOutlet weak var saveNoteButtonOutlet: UIButton!
    
    let realmDB = try! Realm()
    var categoryArray : Results<NoteCategory>?
    var isCategorySelected : Bool = false
    
    var currentCategory : NoteCategory? {
        didSet {
            print("<-- Inside didSet Category -->")
            print(categoryArray?.index(of: currentCategory!))
            print(currentCategory?.categoryName)
            if let preSelectedCategoryIndex = categoryArray?.firstIndex(of: (currentCategory)!) {
                print(preSelectedCategoryIndex)
                noteCategoryPickerView.selectRow(preSelectedCategoryIndex, inComponent: 0, animated: true)
                noteCategoryPickerView.isUserInteractionEnabled = false
            }
//            if let currentCat = currentCategory {
//                print("<-- Current Category Block -->")
//                
//                print(themeColorOfThisView)
//                buttonBackgroundView.backgroundColor = themeColorOfThisView
//                noteCategoryPickerView.backgroundColor = GradientColor(.topToBottom, frame: view.bounds, colors: [
//                    themeColorOfThisView!,
//                    .systemBackground
//                ])
//            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryArray = realmDB.objects(NoteCategory.self)
        noteCategoryPickerView.dataSource = self
        noteCategoryPickerView.delegate = self
        noteCategoryPickerView.isUserInteractionEnabled = false
        
        
//        if !self.isCategorySelected {
//            currentCategory = categoryArray?[0]
//        }
        
        
        // show  category selected if coming from noteview, othervwise make it random
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navController = navigationController else {
            fatalError()
        }
        let themeColorOfThisView = UIColor(hexString: currentCategory?.categoryThemeColor ?? "#FFFFFF")
        navController.navigationBar.backgroundColor = themeColorOfThisView?.lighten(byPercentage: 0.9)
        navController.navigationBar.tintColor = .label
        
        addNoteStackView.backgroundColor = themeColorOfThisView
        buttonBackgroundView.backgroundColor = themeColorOfThisView?.lighten(byPercentage: 0.9)
        saveNoteButtonOutlet.tintColor =
            ContrastColorOf((buttonBackgroundView.backgroundColor)!, returnFlat: true).lighten(byPercentage: 50)
        let categoryNameArray = categoryArray // Start here
        noteCategoryPickerView.selectRow(0, inComponent: 0, animated: true)
        noteCategoryPickerView.isUserInteractionEnabled = false
        
    }
    @IBAction func saveNewNotePressed(_ sender: UIButton) {
        
        let noteSavedAlert = UIAlertController(title: newNoteTitleTextField.text, message: "Note Saved", preferredStyle: .alert)
            noteSavedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                
                if self.isCategorySelected {
                    if let noteTitle = self.newNoteTitleTextField.text {
                        let newNoteItem = NoteItem()
                        newNoteItem.noteTitle = noteTitle
                        newNoteItem.noteText = ""
                        newNoteItem.dateCreated = Date()
                        newNoteItem.dateLastEdited = Date()
                        do {
                            try self.realmDB.write {
                                self.currentCategory?.categoryNotes.append(newNoteItem)
                                self.navigationController?.popViewController(animated: true)
                            }
                        } catch {
                            print("Error saving New Note: \(error)")
                        }
                        print(newNoteItem.noteCategory)
                        noteSavedAlert.dismiss(animated: true, completion: nil)
                    }
                }
            }))
            self.present(noteSavedAlert, animated: true, completion: nil)
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

extension AddNewNoteViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        isCategorySelected = true
        currentCategory = categoryArray?[row]
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

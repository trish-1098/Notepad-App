//
//  NoteCategoryViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import RealmSwift
import ChameleonFramework

class NoteCategoryViewController: UITableViewController {
    
    let realmDB = try! Realm()
    
    var noteCategoryArray : Results<NoteCategory>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        print(realmDB.configuration.fileURL)
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteCategoryArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCategoryCell", for: indexPath)
        
        if let noteCategory = noteCategoryArray?[indexPath.row] {
            cell.textLabel?.text = noteCategory.categoryName
            let cellRect = tableView.convert(tableView.rectForRow(at: indexPath), to: tableView.superview)
            // Find a way to change it according to appearance
            cell.backgroundColor = GradientColor(.leftToRight, frame: cellRect, colors: [
                UIColor(hexString: noteCategory.categoryThemeColor)!,
//                UIColor(hexString: (noteCategoryArray?[0].categoryThemeColor)!)!,
                .label,
            ])
            cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
            // In SHredPreferences for user choice of theme just set in the database the color Value of first category in the list
//            cell.backgroundColor = UIColor(hexString: noteCategory.categoryThemeColor)
        } else {
            cell.textLabel?.text = "No Categories Added Yet"
        }
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openNoteListSegue", sender: self)
    }
    
    
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        let newCategoryAlert = UIAlertController(title: "Add New Category", message: "Give it a name and choose it's theme", preferredStyle: .alert)
        newCategoryAlert.addTextField { (categoryNameTextField) in
            categoryNameTextField.placeholder = "Enter Name"
        }
        newCategoryAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            let newCategoryName = newCategoryAlert.textFields?[0].text
            let newCategory = NoteCategory()
            newCategory.categoryName = newCategoryName!
            newCategory.categoryThemeColor = UIColor.randomFlat().hexValue()
//            if let numOfCategories = self.noteCategoryArray?.count {
//                if numOfCategories > 1 {
//                    let newCategoryColor = ComplementaryFlatColorOf(UIColor(hexString: self.noteCategoryArray![(numOfCategories - 1)].categoryThemeColor)!)
//                    newCategory.categoryThemeColor = newCategoryColor.hexValue()
//                } else {
//                    // Later add Shared Preferences in the top for choosing theme and a new button to add categories
//                     // FOR NOW
//                }
//            }
            
            self.saveNewNoteCategory(newCategory)
        }))
        newCategoryAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            newCategoryAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(newCategoryAlert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "openNoteListSegue" {
            let destinationVC = segue.destination as! NoteViewController
            if let indexForCategoryPressed = tableView.indexPathForSelectedRow?.row {
                if let noteCategorySelected = noteCategoryArray?[indexForCategoryPressed] {
                    destinationVC.notesCategory = noteCategorySelected
                }
            }
        }
    }

    func loadCategories() {
        do {
            noteCategoryArray = realmDB.objects(NoteCategory.self)
            self.tableView.reloadData()
        }
    }
    
    func saveNewNoteCategory(_ newCategory : NoteCategory) {
        do {
            try realmDB.write {
                realmDB.add(newCategory)
            }
            self.tableView.reloadData()
        } catch {
            print("Error saving Category: \(error)")
        }
    }
}

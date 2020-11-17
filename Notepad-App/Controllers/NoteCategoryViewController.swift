//
//  NoteCategoryViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import CoreData

class NoteCategoryViewController: UITableViewController {
    
    var noteCategoryArray = [NoteCategory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteCategoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCategoryCell", for: indexPath)

        cell.textLabel?.text = noteCategoryArray[indexPath.row].categoryName
        if let cellBackgroundTheme = noteCategoryArray[indexPath.row].categoryThemeColor {
            if cellBackgroundTheme == ".red" {
                cell.backgroundColor = .systemRed
            } else if cellBackgroundTheme == ".purple" {
                cell.backgroundColor = .systemPurple
            }
        }
        cell.alpha = 0.8

        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        let newCategoryAlert = UIAlertController(title: "Add New Category", message: "Give it a name and choose it's theme", preferredStyle: .alert)
        newCategoryAlert.addTextField { (categoryNameTextField) in
            categoryNameTextField.placeholder = "Enter Name"
        }
        newCategoryAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            let newCategoryName = newCategoryAlert.textFields?[0].text
            let newCategory = NoteCategory(context: self.context)
            newCategory.categoryName = newCategoryName
            newCategory.categoryThemeColor = ".purple"
            self.noteCategoryArray.append(newCategory)
            self.saveNewNoteCategory()
        }))
        newCategoryAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            newCategoryAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(newCategoryAlert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    func loadCategories() {
        let req : NSFetchRequest<NoteCategory> = NoteCategory.fetchRequest()
        do {
            noteCategoryArray = try context.fetch(req)
        } catch {
            print("Error loading categories : \(error)")
        }
    }
    
    func saveNewNoteCategory() {
        do {
            try context.save()
            tableView.reloadData()
        } catch {
            print("Error saving category : \(error)")
        }
    }
}

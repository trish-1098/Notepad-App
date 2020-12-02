//
//  NoteViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import RealmSwift
import ChameleonFramework

class NoteViewController: UITableViewController {
    
    var notesArray : Results<NoteItem>?
    
    var notesCategory : NoteCategory? {
        didSet {
            print("<-- didSet Notes Category -->")
            loadNotes()
        }
    }
    
    let realmDB = try! Realm()
    
//    override func viewWillAppear(_ animated: Bool) {
//        loadNotes()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        let notesArrayObserver = notesArray?.observe(on: DispatchQueue.main, { (_) in
            self.tableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navController = navigationController else {
            fatalError()
        }
        print("<-- viewWillAppear Called -->")
        title = notesCategory?.categoryName
        navController.navigationBar.backgroundColor = ToolFunctionsAndConstants.convertToUIColor(from: (notesCategory?.categoryThemeColor)!)
        tableView.backgroundColor = GradientColor(.diagonal,
                                                  frame: tableView.bounds,
                                                  colors: [
                                                    UIColor(hexString: notesCategory?.categoryThemeColor ?? "#000000")!,
                                                    .systemBackground
                                                  ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("<-- viewDidAppear Called -->")
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificNoteCell", for: indexPath)

        if let noteItem = notesArray?[indexPath.row] {
            cell.textLabel?.text = noteItem.noteTitle
            cell.detailTextLabel?.text = "Last Edited : \(DateFormatter.localizedString(from: noteItem.dateLastEdited!, dateStyle: .short, timeStyle: .short))"
        }
        
        
        cell.backgroundColor = .clear
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editNoteSegue", sender: self)
    }
    
    @IBAction func addNotePressed(_ sender: UIBarButtonItem) {
//        ToolFunctionsAndConstants.noteViewSegueIdentifyingConstant = true
        performSegue(withIdentifier: "addNewNoteSegue", sender: self)
    }
    
    func loadNotes() {
        notesArray = notesCategory?.categoryNotes.sorted(byKeyPath: "noteTitle") // For Now (later by date created or last edited
//        print(notesArray)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewNoteSegue" {
            let desVC = segue.destination as! AddNewNoteViewController
            print("<-- Category Set -->")
            desVC.currentCategory = notesCategory
            desVC.isCategorySelected = true
        } else if segue.identifier == "editNoteSegue" {
            let desVC = segue.destination as! NoteEditViewController
            if let selectedNoteIndex = tableView.indexPathForSelectedRow {
                desVC.selectedNoteItem = notesArray?[selectedNoteIndex.row]
            }
            
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
        tableView.backgroundColor = GradientColor(.diagonal,
                                                  frame: tableView.bounds,
                                                  colors: [
                                                    UIColor(hexString: notesCategory?.categoryThemeColor ?? "#000000")!,
                                                    .systemBackground
                                                  ])
    }

}

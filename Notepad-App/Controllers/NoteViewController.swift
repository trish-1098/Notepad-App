//
//  NoteViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit
import RealmSwift

class NoteViewController: UITableViewController {
    
    var notesArray : Results<NoteItem>?
    var notesCategory : NoteCategory?
    
    let realmDB = try! Realm()
    
//    override func viewWillAppear(_ animated: Bool) {
//        loadNotes()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        if let noteCategory = notesCategory {
            tableView.backgroundColor = UIColor(named: noteCategory.categoryThemeColor)
            navigationController?.title = noteCategory.categoryName
        } else {
            tableView.backgroundColor = .black
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesArray?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specificNoteCell", for: indexPath)

        cell.textLabel?.text = notesArray?[indexPath.row].noteTitle
        cell.detailTextLabel?.text = notesArray?[indexPath.row].noteText

        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editNoteSegue", sender: self)
    }
    
    @IBAction func addNotePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNewNoteSegue", sender: self)
    }
    
    func loadNotes() {
        notesArray = realmDB.objects(NoteItem.self)
        self.tableView.reloadData()
    }

}

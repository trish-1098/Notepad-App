//
//  NoteEditViewController.swift
//  Notepad-App
//
//  Created by TRISHANT SHARMA on 15/11/20.
//

import UIKit

class NoteEditViewController: UITableViewController {

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteEditTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    @IBAction func optionsButtonPressed(_ sender: UIBarButtonItem) {
        // present options in an alert (or find a new way) to save, edit, cancel, delete
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

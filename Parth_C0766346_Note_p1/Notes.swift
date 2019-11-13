//
//  Notes.swift
//  Parth_C0766346_Note_p1
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class Notes: UITableViewController {

    var d_folderList: ViewController?
    
    var selectedIndexes = [Int]()
    var currNoteIndexPath: IndexPath?
    @IBOutlet weak var deleteO: UIBarButtonItem!
    @IBOutlet weak var moveO: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteO.isEnabled = false
        moveO.isEnabled = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .darkGray
        
    }
    
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        
        let delete_alert_cont = UIAlertController(title: "Delete", message: "Are you sure ?", preferredStyle: .alert)
        
        let can = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let del = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteSelectedItems()
        }
        can.setValue(UIColor.orange, forKey: "titleTextColor")
        delete_alert_cont.addAction(can)
        delete_alert_cont.addAction(del)
        self.present(delete_alert_cont, animated: true, completion: nil)


        
        
    }
    
    func deleteSelectedItems(){
        selectedIndexes.sort(by: >)
        for i in selectedIndexes{
            
            Folder_Data.foldersList[(d_folderList?.currFolderIndex)!].notes.remove(at: i )
            tableView.reloadData()
            d_folderList?.folder_tableview.reloadData()
        }
    }
    
    
    
    func moveselectedItems(to index: Int){
        
        for i in selectedIndexes{
            
          let item = Folder_Data.foldersList[(d_folderList?.currFolderIndex)!].notes[i]
            
            Folder_Data.foldersList[index].notes.append(item)
        }
        deleteSelectedItems()
    }
    
    @IBAction func moveNote(_ sender: UIBarButtonItem) {
        
    }
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Folder_Data.foldersList[(d_folderList?.currFolderIndex)!].notes.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTitle", for: indexPath)
        cell.textLabel?.text = Folder_Data.foldersList[(d_folderList?.currFolderIndex)!].notes[indexPath.row]
        // Configure the cell...
        cell.accessoryType = .detailButton
        cell.backgroundColor = .darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
        selectedIndexes.append(indexPath.row)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .detailButton
        for i in selectedIndexes.indices{
            if selectedIndexes[i] == indexPath.row {selectedIndexes.remove(at: i)
                break
            }
        }
        
        
    }
    
    
    @IBAction func togleEnable(_ sender: Any) {
        
        
        if deleteO.isEnabled == true{
            
            deleteO.isEnabled = false
            moveO.isEnabled = false
            
        }
        else{
            
           deleteO.isEnabled = true
            moveO.isEnabled = true
            
        }
    }
    func saveMyNotes(_ note: String, _ isNew: Bool){
    
        
    if isNew{
        Folder_Data.foldersList[d_folderList!.currFolderIndex].notes.append(note)
        tableView.reloadData()
    }
    else{
        
        Folder_Data.foldersList[d_folderList!.currFolderIndex].notes[currNoteIndexPath!.row] = note
        tableView.reloadRows(at: [currNoteIndexPath!], with: .none)
    
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let noteDetails = segue.destination as? NoteDetails{
            noteDetails.d_Notes = self
            
            if let noteCell = sender as? UITableViewCell{
                noteDetails.isNewNote = false
                noteDetails.noteText = noteCell.textLabel?.text
                
                currNoteIndexPath = tableView.indexPath(for: noteCell)!
                
            }
            
            if let _ = sender as? UIBarButtonItem{
                noteDetails.isNewNote = true
            }
            
        }
        
        
        if let move = segue.destination as? moveNotes{
            move.d_Notesmove = self
            
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        d_folderList?.updateCount()
    }
    
    
    

}

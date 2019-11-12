//
//  ViewController.swift
//  Parth_C0766346_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currFolderIndex = -1
    var currFolderIndexPath: IndexPath?
    
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var folder_tableview: UITableView!
    //var folderNameList : [String]?
    @IBOutlet weak var Edit_btn: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        //folderNameList = []
        folder_tableview.isEditing = false
    self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.backgroundColor = .lightGray
        folder_tableview.backgroundColor = .lightGray
        
        // Do any additional setup after loading the view.
        
        
        
        
        
    }

    @IBAction func Create_New_Folder(_ sender: UIBarButtonItem) {
       
        
        
        let makeFolderAlert = UIAlertController(title: "New Folder", message: "Enter a Name for this Folder", preferredStyle: .alert)
        
        
        makeFolderAlert.addTextField { (nameOfFolder) in
            nameOfFolder.placeholder = "Name"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
        }
        
        let addItem = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let fName = makeFolderAlert.textFields![0].text
            var nameTaken: Bool = false
            for folder in Folder_Data.foldersList{
                if folder.name == fName { nameTaken = true; break }
            }
            if nameTaken {
                let nameTakenAlert = UIAlertController(title: "Name Taken", message: "Please choose different Name", preferredStyle: .alert)
                       
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in
                    
                })
                nameTakenAlert.addAction(ok)
                self.present(nameTakenAlert, animated: true, completion: nil)
                return
                

            }
            else{
                let f = Folder_Data(name: fName ?? "", notes: [])
                Folder_Data.foldersList.append(f)
                self.folder_tableview.reloadData()
            }
            
            
        }
        
         cancel.setValue(UIColor.brown, forKey: "titleTextColor")
         addItem.setValue(UIColor.black, forKey: "titleTextColor")
        
         makeFolderAlert.addAction(cancel)
         makeFolderAlert.addAction(addItem)
         self.present(makeFolderAlert, animated: true, completion: nil)
        
        
    
    }
    
    
    @IBAction func Edit_btn_press(_ sender: UIBarButtonItem) {
        
        if sender.title == "Edit" {
            
            sender.title = "Done"
            folder_tableview.isEditing = true
            
            
        }
        else{
            sender.title = "Edit"
            folder_tableview.isEditing = false
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return folderNameList?.count ?? 0
        return Folder_Data.foldersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "fName")
        if let cell = folder_tableview.dequeueReusableCell(withIdentifier: "fName"){
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: "folder-icon.png")
        cell.backgroundColor = .lightGray
        cell.textLabel?.text = Folder_Data.foldersList[indexPath.row].name
            cell.detailTextLabel?.text = "\(Folder_Data.foldersList[indexPath.row].notes.count)"
        
        return cell}
        
        return UITableViewCell()
    }
    
    // editing function
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = Folder_Data.foldersList[sourceIndexPath.row].name
        Folder_Data.foldersList[sourceIndexPath.row].name = Folder_Data.foldersList[destinationIndexPath.row].name
        Folder_Data.foldersList[destinationIndexPath.row].name = temp
        folder_tableview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
   
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let del = UIContextualAction(style: .destructive, title: "Delete") { (act, V, _) in
            
            Folder_Data.foldersList.remove(at: indexPath.row)
            self.folder_tableview.reloadData()
            
            
        }
        return UISwipeActionsConfiguration(actions: [del])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let notes = segue.destination as? Notes{
            notes.d_folderList = self
            
            if let folderCell = sender as? UITableViewCell{
                
                let fIndexPath = folder_tableview.indexPath(for: folderCell)
                currFolderIndex = fIndexPath!.row
                currFolderIndexPath = fIndexPath
            }
        }
    }
    
    
    func updateCount(){
        
        folder_tableview.reloadRows(at: [currFolderIndexPath!], with: .none)
        
    }
    
}




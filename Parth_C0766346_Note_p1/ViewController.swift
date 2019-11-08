//
//  ViewController.swift
//  Parth_C0766346_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var fLable: UILabel!
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var folder_tableview: UITableView!
    var folderNameList : [String]?
    @IBOutlet weak var Edit_btn: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        folderNameList = []
        folder_tableview.isEditing = false
        
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
            self.folderNameList?.append(fName!)
            self.folder_tableview.reloadData()
            
            
        }
        
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
        return folderNameList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: "folder-icon.png")
        cell.textLabel?.text = folderNameList![indexPath.row]
        
        return cell
        
    }
    
    // editing function
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = folderNameList![sourceIndexPath.row]
        folderNameList![sourceIndexPath.row] = folderNameList![destinationIndexPath.row]
        folderNameList![destinationIndexPath.row] = temp
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
            
            self.folderNameList?.remove(at: indexPath.row)
            self.folder_tableview.reloadData()
            
            
        }
        return UISwipeActionsConfiguration(actions: [del])
    }
  
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        nav.title  = "Folders"
        fLable.isHidden = true
        }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        nav.title = ""
        fLable.isHidden = false
        
        
    }

    
    
}




//
//  ViewController.swift
//  Parth_C0766346_Note_p1
//
//  Created by MacStudent on 2019-11-07.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    
    @IBOutlet weak var folder_tableview: UITableView!
    var folderNameList : [String]?
    @IBOutlet weak var Edit_btn: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        folderNameList = []
        // Do any additional setup after loading the view.
        Edit_btn.rightBarButtonItem = editButtonItem
        
    }

    @IBAction func Create_New_Folder(_ sender: UIBarButtonItem) {
        
        let makeFolderAlert = UIAlertController(title: "New Folder", message: "Enter a Name for this Folder", preferredStyle: .alert)
        
        makeFolderAlert.addTextField { (nameOfFolder) in
            nameOfFolder.placeholder = "Name"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderNameList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        cell.imageView?.image = UIImage(named: "folder-icon.png")
        cell.textLabel?.text = folderNameList![indexPath.row]
        
        return cell
        
    }
    
}


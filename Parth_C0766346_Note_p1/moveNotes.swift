//
//  moveNotes.swift
//  Parth_C0766346_Note_p1
//
//  Created by Parth Dalwadi on 2019-11-12.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class moveNotes: UIViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var moveing_table: UITableView!
    
    
    var d_Notesmove: Notes?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Folder_Data.foldersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.backgroundColor = .darkGray
            cell.textLabel?.text = Folder_Data.foldersList[indexPath.row].name
                
            
            return cell }
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        moveAlert(indexPath)
        
    }
    
    
    @IBAction func cancel_btn_press(_ sender: UIButton) {
        
    self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func moveAlert(_ indexPath: IndexPath){
        
        let f_name = Folder_Data.foldersList[indexPath.row].name
        let move_Alert_controller = UIAlertController(title: "Move to \(f_name)", message: "Are you sure ?", preferredStyle: .alert)
        
        let no = UIAlertAction(title: "No", style: .cancel) { (action) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        let move = UIAlertAction(title: "Move", style: .default) { (action) in
            self.d_Notesmove?.moveselectedItems(to: indexPath.row)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        move_Alert_controller.addAction(no)
        move_Alert_controller.addAction(move)
        no.setValue(UIColor.orange, forKey: "titleTextColor")
        move.setValue(UIColor.black, forKey: "titleTextColor")

        self.present(move_Alert_controller, animated: true, completion: nil)
        
    }
        
/*
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Folder_Data.foldersList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "fName"){
        
        cell.textLabel?.text = Folder_Data.foldersList[indexPath.row].name
            
        
        return cell}
        
        return UITableViewCell()
    }
    
*/
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  NoteDetails.swift
//  Parth_C0766346_Note_p1
//
//  Created by Parth Dalwadi on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class NoteDetails: UIViewController {

    var noteText: String?
    @IBOutlet weak var noteTextArea: UITextView!
    var isNewNote: Bool?
    var d_Notes: Notes?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextArea.text = noteText

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        d_Notes?.saveMyNotes(noteTextArea.text, isNewNote!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

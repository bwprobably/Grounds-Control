//
//  EditCoffeeController.swift
//  Grounds Control
//
//  Created by Brett on 10/22/21.
//

import Foundation
import UIKit


class EditCoffeeController: UITableViewController {
    
    static let identifier = "EditCoffeeController"
    
    var drink: Coffee!
    
    
    @IBOutlet weak private var coffeeName: UITextView!
    @IBOutlet weak var gradePicker: UISegmentedControl!
    @IBOutlet weak var chocoSlider: UISlider!
    @IBOutlet weak var chocoLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func DatePickerAction(_ sender: UIDatePicker) {
    }
    @IBOutlet weak var floral_outlet: UILabel!
    @IBOutlet weak var floral_slider_outlet: UISlider!
    @IBOutlet weak var frutty_Label_Outlet: UILabel!
    @IBOutlet weak var fruity_slider_outlet: UISlider!
    @IBOutlet weak var nutty_label_outlet: UILabel!
    @IBOutlet weak var nutty_slider_outlet: UISlider!
    @IBOutlet weak var roasted_label_outlet: UILabel!
    @IBOutlet weak var roasted_slider_outlet: UISlider!
    @IBOutlet weak var spice_label_outlet: UILabel!
    @IBOutlet weak var spice_slider_outlet: UISlider!
    @IBOutlet weak var sweet_label_outlet: UILabel!
    @IBOutlet weak var sweet_slider_outlet: UISlider!
    @IBOutlet weak var veggie_label_outlet: UILabel!
    @IBOutlet weak var veggie_slider_outlet: UISlider!
    @IBOutlet weak var aged_label_outlet: UILabel!
    @IBOutlet weak var aged_slider_outlet: UISlider!
    @IBOutlet weak var decomp_label_outlet: UILabel!
    @IBOutlet weak var decomp_slider_outlet: UISlider!
    @IBOutlet weak var mold_label_outlet: UILabel!
    @IBOutlet weak var mold_slider_outlet: UISlider!
    @IBOutlet weak var muchRoast_label_outlet: UILabel!
    @IBOutlet weak var muchRoast_slider_outlet: UISlider!
    @IBOutlet weak var tainted_label_outlet: UILabel!
    @IBOutlet weak var tainted_slider_outlet: UISlider!
    @IBOutlet weak var underripe_label_outlet: UILabel!
    @IBOutlet weak var underripe_slider_outlet: UISlider!
    @IBOutlet weak var underroast_label_outlet: UILabel!
    @IBOutlet weak var underroast_slider_outlet: UISlider!
    @IBOutlet weak var other_label_Outlet: UILabel!
    @IBOutlet weak var other_slider_outlet: UISlider!
    
    @IBOutlet weak private var Other_Notes: UITextView!
    
    

    
    //var selectedJava: Coffee? = nil
    let currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coffeeName.text = drink?.name
//        datePicker.date = drink?.created ?? Date()
//
//
//        Other_Notes.text = drink?.otherNotes
//
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coffeeName.becomeFirstResponder()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
    private func updateNote() {
        // TODO update the note in database
        print("Updating note")
        drink.created = Date()
        coreDataMngr.shared.save()
    }
    
    private func deleteNote() {
        // TODO delete the note from database
        print("Deleting note")
        coreDataMngr.shared.deleteNote(drink)
    }
}

// MARK:- UITextView Delegate
extension EditCoffeeController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        drink?.name = textView.text
        if drink?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
            print("notecreated")
        }
    }
}


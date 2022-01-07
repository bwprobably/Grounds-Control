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
    
    
    @IBOutlet weak private var coffeeName: UITextField!
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
    
    
    @IBAction func floral_slider(_ sender: UISlider) {
        floral_slider_outlet.value = roundedValue(v: floral_slider_outlet.value)
        floral_outlet.text = "floral notes (1-5): \(Int(floral_slider_outlet.value))"
    }
    
    @IBAction func fruty_slider_action(_ sender: UISlider) {
        fruity_slider_outlet.value = roundedValue(v: fruity_slider_outlet.value)
        frutty_Label_Outlet.text = "fruity notes (1-5): \(Int(fruity_slider_outlet.value))"
    }
    @IBAction func nutty_slider_action(_ sender: UISlider) {
        nutty_slider_outlet.value = roundedValue(v: nutty_slider_outlet.value)
        nutty_label_outlet.text = "nutty notes (1-5): \(Int(nutty_slider_outlet.value))"
    }
    @IBAction func roasted_slider_action(_ sender: UISlider) {
        roasted_slider_outlet.value = roundedValue(v: roasted_slider_outlet.value)
        roasted_label_outlet.text = "roasted notes (1-5): \(Int(roasted_slider_outlet.value))"
    }
    
    @IBAction func choco_slider_action(_ sender: UISlider) {
        chocoSlider.value = roundedValue(v: chocoSlider.value)
        chocoLabel.text = "chocolate notes (1-5): \(Int(chocoSlider.value))"
    }
    @IBAction func spice_slider_action(_ sender: UISlider) {
        spice_slider_outlet.value = roundedValue(v: spice_slider_outlet.value)
        spice_label_outlet.text = "spice notes (1-5): \(Int(spice_slider_outlet.value))"
    }
    @IBAction func sweet_slider_action(_ sender: UISlider) {
        sweet_slider_outlet.value = roundedValue(v: sweet_slider_outlet.value)
        sweet_label_outlet.text = "sweet notes (1-5): \(Int(sweet_slider_outlet.value))"
    }
    @IBAction func veggie_slider_action(_ sender: UISlider) {
        veggie_slider_outlet.value = roundedValue(v: veggie_slider_outlet.value)
        veggie_label_outlet.text = "veggie notes (1-5): \(Int(veggie_slider_outlet.value))"
    }
    @IBAction func aged_slider_action(_ sender: UISlider) {
        aged_slider_outlet.value = roundedValue(v: aged_slider_outlet.value)
        aged_label_outlet.text = "aged notes (1-5): \(Int(aged_slider_outlet.value))"
    }
    @IBAction func decomp_slider_action(_ sender: UISlider) {
        decomp_slider_outlet.value = roundedValue(v: decomp_slider_outlet.value)
        decomp_label_outlet.text = "decomposition notes (1-5): \(Int(decomp_slider_outlet.value))"
    }
    @IBAction func mold_slider_action(_ sender: UISlider) {
        mold_slider_outlet.value = roundedValue(v:mold_slider_outlet.value)
        mold_label_outlet.text = "mold notes (1-5): \(Int(mold_slider_outlet.value))"
    }
    @IBAction func muchRoast_slider_action(_ sender: UISlider) {
        muchRoast_slider_outlet.value = roundedValue(v: muchRoast_slider_outlet.value)
        muchRoast_label_outlet.text = "overroasted notes (1-5): \(Int(muchRoast_slider_outlet.value))"
    }
    @IBAction func tainted_slider_action(_ sender: UISlider) {
        tainted_slider_outlet.value = roundedValue(v: tainted_slider_outlet.value)
        tainted_label_outlet.text = "tainted notes (1-5): \(Int(tainted_slider_outlet.value))"
    }
    @IBAction func underripe_slider_action(_ sender: UISlider) {
        underripe_slider_outlet.value = roundedValue(v: underripe_slider_outlet.value)
        underripe_label_outlet.text = "underripe notes (1-5): \(Int(underripe_slider_outlet.value))"
    }
    @IBAction func underroast_slider_action(_ sender: UISlider) {
        underroast_slider_outlet.value = roundedValue(v: underroast_slider_outlet.value)
        underroast_label_outlet.text = "underroasted notes (1-5): \(Int(underroast_slider_outlet.value))"
    }
    @IBAction func other_slider_action(_ sender: UISlider) {
        other_slider_outlet.value = roundedValue(v: other_slider_outlet.value)
        other_label_Outlet.text = "other notes (1-5): \(Int(other_slider_outlet.value))"
    }
    
    
    
    

    
    //var selectedJava: Coffee? = nil
    let currentDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Name, Date, Rating
        coffeeName.text = drink?.name
        datePicker.date = drink?.created ?? Date()
        //Other Things to Note
        Other_Notes.text = drink?.otherNotes
         //recall previous selected grade
        selectedGrade(gradePicker)
        
        self.coffeeName.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.Other_Notes.addCompleteButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    

        //Positive Notes
        chocoLabel.text = "chocolate notes (1-5): \(Int(drink!.chocolate))"
        chocoSlider.value = drink.chocolate
        floral_outlet.text = "floral notes (1-5): \(Int(drink!.floral))"
        floral_slider_outlet.value = drink.floral
        frutty_Label_Outlet.text = "fruity notes (1-5): \(Int(drink!.fruity))"
        fruity_slider_outlet.value = drink.fruity
        nutty_label_outlet.text = "nutty notes (1-5): \(Int(drink!.nutty))"
        nutty_slider_outlet.value = drink.nutty
        roasted_label_outlet.text = "roasted notes (1-5): \(Int(drink!.roasted))"
        roasted_slider_outlet.value = drink.roasted
        spice_label_outlet.text = "spice notes (1-5): \(Int(drink!.spice))"
        spice_slider_outlet.value = drink.spice
        sweet_label_outlet.text = "sweet notes (1-5): \(Int(drink!.sweet))"
        sweet_slider_outlet.value = drink.sweet
        veggie_label_outlet.text = "veggie notes (1-5): \(Int(drink!.veggie))"
        veggie_slider_outlet.value = drink.veggie
        other_label_Outlet.text = "other notes (1-5): \(Int(drink!.other))"
        other_slider_outlet.value = drink.other

        //Negative Notes
        aged_label_outlet.text = "aged notes (1-5): \(Int(drink!.aged))"
        aged_slider_outlet.value = drink.aged
        decomp_label_outlet.text = "decomposition notes (1-5): \(Int(drink!.decomp))"
        decomp_slider_outlet.value = drink.decomp
        mold_label_outlet.text = "mold notes (1-5): \(Int(drink!.mold))"
        mold_slider_outlet.value = drink.mold
        muchRoast_label_outlet.text = "overroasted notes (1-5): \(Int(drink!.overroast))"
        muchRoast_slider_outlet.value = drink.overroast
        tainted_label_outlet.text = "tainted notes (1-5): \(Int(drink!.tainted))"
        tainted_slider_outlet.value = drink.tainted
        underripe_label_outlet.text = "underripe notes (1-5): \(Int(drink!.underripe))"
        underripe_slider_outlet.value = drink.underripe
        underroast_label_outlet.text = "underroasted notes (1-5): \(Int(drink!.underroast))"
        underroast_slider_outlet.value = drink.underroast
        
  

        
    }
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    func roundedValue (v: Float) -> Float{
        let slider_step: Float = 1
        let noInt = round(v / slider_step) * slider_step
        return noInt
    }
    
    
    @IBAction func didChangeGrade(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            drink?.grade = "Garbage"
            print("Garbage")
        case 1:
            drink?.grade = "Just \"Ok\""
            print("Just ok")
        case 2:
            drink?.grade = "Outstanding"
            print("Oustanding")
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        coffeeName.becomeFirstResponder()
        didChangeGrade(gradePicker)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if drink?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
           
        }
    }
    
    func selectedGrade(_ sender: UISegmentedControl){
        switch drink?.grade {
        case "Garbage":
            gradePicker.selectedSegmentIndex = 0
        case "Just \"Ok\"":
            gradePicker.selectedSegmentIndex = 1
        case "Outstanding":
            gradePicker.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func updateNote() {
        drink.created = Date()
        drink.chocolate = chocoSlider.value
        drink.floral = floral_slider_outlet.value
        drink.fruity = fruity_slider_outlet.value
        drink.nutty = nutty_slider_outlet.value
        drink.roasted = roasted_slider_outlet.value
        drink.spice = spice_slider_outlet.value
        drink.sweet = sweet_slider_outlet.value
        drink.veggie = veggie_slider_outlet.value
        drink.other = other_slider_outlet.value
        drink.aged = aged_slider_outlet.value
        drink.decomp = decomp_slider_outlet.value
        drink.mold = mold_slider_outlet.value
        drink.overroast = muchRoast_slider_outlet.value
        drink.tainted = tainted_slider_outlet.value
        drink.underripe = underripe_slider_outlet.value
        drink.underroast = underroast_slider_outlet.value
        
        
        coreDataMngr.shared.save()
    }
    
    private func deleteNote() {
        
        coreDataMngr.shared.deleteNote(drink)
    }
}

// MARK:- UITextView Delegate
extension EditCoffeeController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textView: UITextField) {
        drink?.name = textView.text
        if drink?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
           
        }
    }
}


extension EditCoffeeController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        drink?.otherNotes = Other_Notes.text
    }
}



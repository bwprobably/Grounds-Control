//
//  CalculatorView.swift
//  Grounds Control
//
//  Created by Brett on 10/21/21.
//

import UIKit


class CalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    
    @IBOutlet weak var DesiredOutputInput: UITextField!
    @IBOutlet weak var MethodPicker: UIPickerView!
    @IBOutlet weak var OutputLabel: UILabel!
    
    @IBOutlet weak var RatioInput: UITextField!
    @IBOutlet weak var CalculateOutlet: UIButton!
    
    
    
    let pickerChoices = ["Japanese Iced Coffee", "Pour Over", "Toddy Cold Brew", "Filtron Cold Brew", "Moka Pot", "French Press", "Aeropress"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerChoices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerChoices[row] as String?
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerChoices[row])
        RatioInput.text?.removeAll()
        suggestedRatio()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = pickerChoices[row]
        pickerLabel.font = UIFont(name: "SF Pro Text Regular", size: 20)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func japanesecoldBrew() {
        
        let input = Double(DesiredOutputInput.text!)
        let ratio = Double(RatioInput.text!)
        let iceAmount = round((input! / 3)*10)/10
        let waterAmount = round((iceAmount * 2)*10)/10
        let coffeeAmount = round((input! / ratio!)*10)/10
        let finalOutput : String = "For your drink you need \(coffeeAmount)gm coffee with \(iceAmount)gm ice and \(waterAmount)mL of water. Enjoy"
        OutputLabel.text = finalOutput
    }
    
    func pourOver() {
        let input = Double(DesiredOutputInput.text!)
        let ratio = Double(RatioInput.text!)
        let coffeeAmount = round((input! / ratio!)*10)/10
        let waterAmount = input!
        let finalOutput : String = "For your drink you need \(coffeeAmount)gm coffee with \(waterAmount)mL of water. Enjoy"
        //let finalOutput : String = "Pour Over Test"
        OutputLabel.text = finalOutput
    }
    
    func toddyBrew() {
        let input = Double(DesiredOutputInput.text!)
        let ratio = Double(RatioInput.text!)
        let waterAmount = input! * 1.4746
        let coffeeAmount = round((waterAmount / ratio!)*10)/10
        let finalOutput : String = "For your drink you need \(coffeeAmount)gm coffee with \(waterAmount)mL of water. Enjoy"
        //let finalOutput : String = "Toddy Test"
        OutputLabel.text = finalOutput
    }
    
    func filteronBrew() {
        let input = Double(DesiredOutputInput.text!)
        let ratio = Double(RatioInput.text!)
        let waterAmount = input! * 1.3633
        let coffeeAmount = round((waterAmount / ratio!)*10)/10
        let finalOutput : String = "For your drink you need \(coffeeAmount)gm coffee with \(waterAmount)mL of water. Enjoy"
        //let finalOutput : String = "Toddy Test"
        OutputLabel.text = finalOutput
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MethodPicker.dataSource = self
        MethodPicker.delegate = self
        self.DesiredOutputInput.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.RatioInput.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func CalculateActcion(_ sender: UIButton) {
        if DesiredOutputInput.text!.isEmpty || RatioInput.text!.isEmpty {
            displayAlert(title: "Whoops", message: "You're missing some numbers")
        } else {
            switch MethodPicker.selectedRow(inComponent: 0) {
            case 0:
                japanesecoldBrew()
            case 1:
                pourOver()
            case 2:
                toddyBrew()
            case 3:
                filteronBrew()
            case 4:
                pourOver()
            case 5:
                pourOver()
            case 6:
                pourOver()
            default:
                break
            }
        }
    }
    
    func suggestedRatio(){
        switch MethodPicker.selectedRow(inComponent: 0) {
        case 0:
            //cb
            RatioInput.placeholder = "Try: 16.7"
        case 1:
            //po
            RatioInput.placeholder = "Try: 16.7"
        case 2:
            //toddy
            RatioInput.placeholder = "Try: 4.87"
        case 3:
            //filteron
            RatioInput.placeholder = "Try: 4.4"
        case 4:
            //moka
            RatioInput.placeholder = "Try: 13.3"
        case 5:
            //fp
            RatioInput.placeholder = "Try: 12"
        case 6:
            //aero
            RatioInput.placeholder = "Try: 6.67"
        default:
            break
        }
    }
    
  
   
}


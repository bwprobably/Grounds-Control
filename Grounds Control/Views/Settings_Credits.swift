//
//  Settings_Credits.swift
//  Grounds Control
//
//  Created by Brett on 10/21/21.
//

import UIKit
import Foundation




extension NSMutableAttributedString {
    class func getAttributedString(fromString string: String) -> NSMutableAttributedString {
           return NSMutableAttributedString(string: string)
       }
    
        func apply(attribute: [NSAttributedString.Key: Any], subString: String)  {
            if let range = self.string.range(of: subString) {
                self.apply(attribute: attribute, onRange: NSRange(range, in: self.string))
            }
        }
        
        func apply(attribute: [NSAttributedString.Key: Any], onRange range: NSRange) {
            if range.location != NSNotFound {
                self.setAttributes(attribute, range: range)
            }
        }
        //apply link to range
        func applylink(value: String, onRange: String) {
            if let range = self.string.range(of: onRange){
            self.addAttributes([NSAttributedString.Key.link : value],
                               range: NSRange(range, in:self.string))
            }
        }
            
        func apply(color: UIColor, subString: String) {
            if let range = self.string.range(of: subString) {
              self.apply(color: color, onRange: NSRange(range, in:self.string))
            }
      }
    
      // Apply color on given range
      func apply(color: UIColor, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                           range: onRange)
      }
    
    
}

    
class SettingsAndCredits: UIViewController {
    


    
//    @IBOutlet weak var darkModeSwitch: UISwitch!
//
//
//
//    @IBAction func all_dark(_ sender: UISwitch) {
//        //darkModeSwitch.isOn = overrideUserInterfaceStyle == .dark
//        if #available(iOS 13.0, *) {
//             let appDelegate = UIApplication.shared.windows.first
//                 if sender.isOn {
//                    appDelegate?.overrideUserInterfaceStyle = .dark
//                      return
//                 }
//             appDelegate?.overrideUserInterfaceStyle = .light
//             return
//        }
//    }
    
    

    @IBOutlet weak var Credits_Outlet: UITextView!
    @IBOutlet weak var Credits_By_Outlet: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let creditText = """
Hello! Thanks for downloading and using my app. This took me by far way to long to make.

This couldn't have been possible without:
• Charts for iOS
• YouTube: Coding with Chris specifically
• Hacking with Swift
• Professor Stack Overflow
• My Wife
• My Children
• My Dog
• Not my cat though she's a complete asshole although very fluffy.
• Lots of coffee

The icon was created with Affinity Designer.
It as well as the entire app and the education to program it were done on a 13" 2015 MacBook Pro.

Thanks: Brett Wolf
"""
        
        let salutation = """
            created in sunny and hot Seattle, WA
            PLDS Inc.
            """
        
        let attributedbyMeText = NSMutableAttributedString.getAttributedString(fromString: salutation)
        attributedbyMeText.apply(color: .darkGray, subString: "PLDS Inc.")
        attributedbyMeText.applylink(value: "https://youtu.be/tneigbeGhjQ", onRange: "Seattle, WA")
        attributedbyMeText.apply(color: .darkGray, subString: "created in sunny and hot ")
        
        
       
        self.Credits_By_Outlet.attributedText = attributedbyMeText
        self.Credits_By_Outlet.textAlignment = .center
        
        
        self.Credits_Outlet.text = creditText
        
        // Do any additional setup after loading the view.
        
       
    }
    
   
    

}

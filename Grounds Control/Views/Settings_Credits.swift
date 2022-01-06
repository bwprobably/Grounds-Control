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
    

    @IBOutlet weak var dModeView: UISwitch!
    

//MARK: Fix user defaults to save to coredata
    @IBAction func DarkModeSwitch(_ sender: UISwitch) {
        updateDarkMode(isOn: sender.isOn)
        UserDefaults.standard.setValue(sender.isOn, forKey: "darkModeOn")
    }
    

    @IBOutlet weak var Credits_Outlet: UITextView!
    @IBOutlet weak var Credits_By_Outlet: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dMode = UserDefaults.standard.bool(forKey: "darkModeOn")
        updateDarkMode(isOn: dMode)
        
        let creditText = """
Hello! Thanks for downloading and using my app. This took me by far way to long to make.

This couldn't have been possible without:
• Charts for iOS
• YouTube:
   • CodeWithChris
   • Emmanuel Okwara
   • Code With Cal
   • tom cardy
• Hacking with Swift
• Professor Stack Overflow
• My Wife
• My Children
• My Dog
• Not my cat. She's a complete asshole although very fluffy.
• Lots of coffee, obviously.

The icon was created with Affinity Designer.
The icon as well as the entire app and the education to program it were done on a 13" 2015 MacBook Pro.

Thanks: Brett Wolf
"""
        
        let salutation = """
            created in sunny and hot Seattle, WA
            PLDS Inc.
            """
        
        let attributedbyMeText = NSMutableAttributedString.getAttributedString(fromString: salutation)
        attributedbyMeText.apply(color: .secondaryLabel, subString: salutation)
        attributedbyMeText.applylink(value: "https://youtu.be/8NUzNtqu3zQ", onRange: "Seattle, WA")
        
        let formattedCreditText = NSMutableAttributedString.getAttributedString(fromString: creditText)
        formattedCreditText.applylink(value: "https://github.com/danielgindi/Charts", onRange: "Charts for iOS")
        formattedCreditText.applylink(value: "https://www.youtube.com/c/EmmanuelOkwara", onRange: "Emmanuel Okwara")
        formattedCreditText.applylink(value: "https://www.youtube.com/c/CodeWithChris", onRange: "CodeWithChris")
        formattedCreditText.applylink(value: "https://www.youtube.com/channel/UCDTKfxFIFmMnR-u_HodZGjA", onRange: "Code With Cal")
        formattedCreditText.applylink(value: "https://www.youtube.com/channel/UCW7AGm8JSBEEew61dJIgl_A", onRange: "tom cardy")
        formattedCreditText.apply(color: .label, subString: creditText)
        
        
        
       
        self.Credits_By_Outlet.attributedText = attributedbyMeText
        self.Credits_By_Outlet.textAlignment = .center
        
        
        self.Credits_Outlet.attributedText = formattedCreditText
        
        
       
    }
    
   
    func updateDarkMode(isOn: Bool){
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
             let appDelegate = window
                 if isOn {
                    appDelegate?.overrideUserInterfaceStyle = .dark
                    dModeView.isOn = isOn
                      return
                 }
             appDelegate?.overrideUserInterfaceStyle = .light
    }
        
    }
    
}

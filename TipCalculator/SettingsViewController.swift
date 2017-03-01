//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Abhinay Balusu on 2/19/17.
//  Copyright © 2017 abhinay. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var defaultTipValue: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        toolbar.barStyle = .blackTranslucent
        
        let cancelBarItem = UIBarButtonItem(title: "Cancel", style: .bordered, target: self, action: #selector(SettingsViewController.cancelNumberPad))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBarItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(SettingsViewController.doneWithNumberPad))
        
        toolbar.items = [cancelBarItem,flexibleSpace,doneBarItem]
        toolbar.sizeToFit()
        
        defaultTipValue.inputAccessoryView = toolbar
        
        
    }
    
    func cancelNumberPad()
    {
        defaultTipValue.resignFirstResponder()
    }
    
    func doneWithNumberPad()
    {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(defaultTipValue.text, forKey: "defaultTipValue")
        userDefaults.synchronize()
        
        defaultTipValue.resignFirstResponder()
        
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

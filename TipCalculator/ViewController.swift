//
//  ViewController.swift
//  TipCalculator
//
//  Created by Abhinay Balusu on 2/19/17.
//  Copyright © 2017 abhinay. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var tip: UILabel!
    
    @IBOutlet weak var onePersonShareLabel: UILabel!
    
    @IBOutlet weak var twoPersonShareLabel: UILabel!
    
    @IBOutlet weak var threePersonShareLabel: UILabel!
    
    @IBOutlet weak var fourPersonShareLabel: UILabel!
    
    var inputAmount: Double!
    var tipPercentageValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        amount.delegate = self
        
        amount.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        toolbar.barStyle = .blackTranslucent
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneBarItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(SettingsViewController.doneWithNumberPad))
        
        toolbar.items = [flexibleSpace,doneBarItem]
        toolbar.sizeToFit()
        
        amount.inputAccessoryView = toolbar
        
        
    }
    
    func doneWithNumberPad()
    {
        amount.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inputAmount = 0.0
        
        tipSegment.selectedSegmentIndex = 0
        
        if(UserDefaults.standard.object(forKey: "defaultTipValue") != nil)
        {
            let defaultTipValue = Int(UserDefaults.standard.object(forKey: "defaultTipValue") as! String)
            tipPercentageValue = defaultTipValue!
            
            
        }
        else
        {
            tipPercentageValue = 10
            
        }
        tipSegment.setTitle("\(tipPercentageValue)%", forSegmentAt: 0)
        
        if(amount.text != "")
        {
            inputAmount = Double(amount.text!)
            setTipValueAndPersonShares()
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        print(textField.text!)
        
        if(textField.text! != "")
        {
            inputAmount = Double(textField.text!)
            setTipValueAndPersonShares()
        }
        else
        {
            inputAmount = 0.0
            clearLabels()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        
    }
    @IBAction func setTipPercentage(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            
            var tempValue = sender.titleForSegment(at: 0)! as String
            tempValue.remove(at: tempValue.index(before: tempValue.endIndex))
            tipPercentageValue = Int(tempValue)!
            setTipValueAndPersonShares()
        case 1:
            tipPercentageValue = 15
            setTipValueAndPersonShares()
        case 2:
            tipPercentageValue = 20
            setTipValueAndPersonShares()
        default:
            break;
        }
        
    }

    func setTipValueAndPersonShares()
    {
        let tipFormat = ((inputAmount * Double(tipPercentageValue))/100)
        tip.text = "\(tipFormat)"
        
        onePersonShareLabel.text = "$\(Double(round(100 * (inputAmount+tipFormat))/100))"
        
        twoPersonShareLabel.text = "$\(Double(round(100 * (inputAmount+tipFormat)/2)/100))"
        
        threePersonShareLabel.text = "$\(Double(round(100 * (inputAmount+tipFormat)/3)/100))"
        
        fourPersonShareLabel.text = "$\(Double(round(100 * (inputAmount+tipFormat)/4)/100))"
    }
    
    func clearLabels()
    {
        tip.text = "0.00%"
        
        onePersonShareLabel.text = "$0.00"
        
        twoPersonShareLabel.text = "$0.00"
        
        threePersonShareLabel.text = "$0.00"
        
        fourPersonShareLabel.text = "$0.00"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


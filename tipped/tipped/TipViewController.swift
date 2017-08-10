//
//  TipViewController.swift
//  tipped
//
//  Created by Braden Casperson on 8/6/17.
//  Copyright © 2017 Braden Casperson. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, SettingsDelegate {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var totalBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var percentageSymbolLabel: UILabel!
    
    var maximum: Int = 0
    var minimum: Int = 0
    let defaults = UserDefaults.standard
    var bill = 0.0
    var tip = 0.0
    var total = 0.0
    var tipPercentage = 0.0
    let formatter = NumberFormatter()
    
    let colors = [UIColor(red: 246/255, green: 136/255, blue: 151/255, alpha: 1),
                  UIColor(red: 246/255, green: 190/255, blue: 152/255, alpha: 1),
                  UIColor(red: 240/255, green: 255/255, blue: 152/255, alpha: 1),
                  UIColor(red: 24/255, green: 255/255, blue: 157/255, alpha: 1)]

    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        
        formatter.numberStyle = .currency
        
        maximum = defaults.integer(forKey: "maximum")
        minimum = defaults.integer(forKey: "minimum")
        percentageLabel.text = String(defaults.integer(forKey: "default"))
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TipViewController.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(bill, forKey: "bill")
        defaults.set(tipPercentage * 100, forKey: "percentage")
        defaults.set(tip, forKey: "tip")
        defaults.set(total, forKey: "total")
        defaults.synchronize()
    }

    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    func configureView() {
        if defaults.bool(forKey: "dark") {
            billField.keyboardAppearance = UIKeyboardAppearance.dark
            tipView.backgroundColor = UIColor.black
            tipLabel.textColor = UIColor.white
            percentageLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
            tipLabel.textColor = UIColor.white
            percentageSymbolLabel.textColor = UIColor.white
        } else {
            billField.keyboardAppearance = UIKeyboardAppearance.default
            tipView.backgroundColor = UIColor.white
            tipLabel.textColor = UIColor.lightGray
            percentageLabel.textColor = UIColor.lightGray
            totalLabel.textColor = UIColor.lightGray
            tipLabel.textColor = UIColor.lightGray
            percentageSymbolLabel.textColor = UIColor.lightGray
        }
        
        if let endTime = defaults.object(forKey: "endTime") {
            print((endTime as! Date).timeIntervalSinceNow)
            
            if (endTime as! Date).timeIntervalSinceNow > -600 {
                tipLabel.text = formatter.string(from: defaults.double(forKey: "tip") as NSNumber)
                totalLabel.text = formatter.string(from: defaults.double(forKey: "total") as NSNumber)
                billField.text = defaults.integer(forKey: "bill") == 0 ? "" : String(defaults.integer(forKey: "bill"))
                percentageLabel.text = defaults.integer(forKey: "percentage") <= minimum ? String(minimum) : String(describing: defaults.integer(forKey: "percentage"))
            }
        }
        
        getColor(Int(percentageLabel.text!)!)
    }
  
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            totalBottomContraint.constant = keyboardHeight + 18
        }
    }
   
    func checkPercentage(current: Int, velocity: CGFloat) -> Bool {
        if velocity > 0 && current >= maximum {
            return false
        } else if velocity < 0 && current <= minimum {
            return false
        }
        
        return true
    }
    
    func getColor(_ percent: Int) {
        switch percent {
        case 0...16:
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.billField.backgroundColor = self.colors[0]
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.barTintColor = self.colors[0]
            }, completion:nil)
        case 17...21:
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.billField.backgroundColor = self.colors[1]
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.barTintColor = self.colors[1]
            }, completion:nil)
        case 22...24:
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.billField.backgroundColor = self.colors[2]
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.barTintColor = self.colors[2]
            }, completion:nil)
        case 25...defaults.integer(forKey: "maximum"):
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.billField.backgroundColor = self.colors[3]
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.barTintColor = self.colors[3]
            }, completion:nil)
        default:
            print("No change")
        }
        
    }
    
    func calcTip() {
        bill = Double(billField.text!) ?? 0
        tipPercentage = Double(percentageLabel.text!)! / 100
        tip = bill * tipPercentage
        total = bill + tip
        
        tipLabel.text = formatter.string(from: tip as NSNumber)
        totalLabel.text = formatter.string(from: total as NSNumber)
    }
    
    func updatedMinMaxValues(min: Int, max: Int) {
        minimum = min
        maximum = max
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SettingsViewController {
            destinationViewController.delegate = self
        }
    }
    
    // MARK: IBActions
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveValues(_ sender: Any) {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let rightNow = dateFormatter.string(from: date)
        
        let savedValues = ["bill": bill, "percentage": tipPercentage, "tip": tip, "total": total, "date": rightNow] as [String : Any]
        var history = defaults.array(forKey: "history")
        history?.append(savedValues)
        defaults.set(history, forKey: "history")
        defaults.synchronize()
    }
    
    @IBAction func onSwipe(_ sender: UIPanGestureRecognizer) {
        let piece = sender.view
        
        if sender.state == .began || sender.state == .changed {
            var currentPercent = Int(percentageLabel.text!)
        
            if checkPercentage(current: currentPercent!, velocity: sender.velocity(in: piece).x) {
                if sender.velocity(in: piece).x > 0 {
                    currentPercent = currentPercent! + 1
                    percentageLabel.text = String(describing: currentPercent!)
                } else if sender.velocity(in: piece).x < 0 {
                    currentPercent = currentPercent! - 1
                    percentageLabel.text = String(describing: currentPercent!)
                }
            }
            calcTip()
            getColor(currentPercent!)
        }
        
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calcTip()
    }
}


//
//  TipViewController.swift
//  tipped
//
//  Created by Braden Casperson on 8/6/17.
//  Copyright © 2017 Braden Casperson. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipView: UIView!
    
    var newTranslation = CGPoint(x: 0.0, y: 0.0)
    var previousTranslation = CGPoint(x: 0.0, y: 0.0)
    var maximum: Int = 0
    var minimum: Int = 0
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        
        percentageLabel.text = String(defaults.integer(forKey: "default"))
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }

    override func viewWillAppear(_ animated: Bool) {
        maximum = defaults.integer(forKey: "maximum")
        minimum = defaults.integer(forKey: "minimum")
        
        NotificationCenter.default.addObserver(self, selector: #selector(TipViewController.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
  
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let screenSize: CGRect = UIScreen.main.bounds
            let height = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height
            tipView.frame = CGRect(x: 0, y: height, width: screenSize.width, height: screenSize.height - height - keyboardHeight)
        }
    }
   
    func checkPercentage(current: Int, velocity: CGFloat) -> Bool {
        if velocity > 0 && current == maximum {
            return false
        } else if velocity < 0 && current == minimum {
            return false
        }
        
        return true
    }
    
    // MARK: IBActions
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
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
        }
    }
    
    func calcTip() {
        let bill = Double(billField.text!) ?? 0
        let tipPercentage = Double(percentageLabel.text!)! / 100
        let tip = bill * tipPercentage
        let total = bill + tip
        
        tipLabel.text = String.init(format: "$%.2f", tip)
        totalLabel.text = String.init(format: "$%.2f", total)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calcTip()
    }
}


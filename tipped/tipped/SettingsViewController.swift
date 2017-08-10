//
//  SettingsViewController.swift
//  tipped
//
//  Created by Braden Casperson on 8/6/17.
//  Copyright © 2017 Braden Casperson. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func updatedMinMaxValues(min: Int, max: Int)
}

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var defaultTextField: UITextField!
    @IBOutlet weak var minimumTextField: UITextField!
    @IBOutlet weak var maximumTextField: UITextField!
    @IBOutlet weak var darkSwitch: UISwitch!
    
    weak var delegate: SettingsDelegate?
    var defaultSettings = ["Default", "Minimum", "Maxiumum"]
    var otherSettings = ["Dark Mode", "History"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        defaultTextField.text = String(defaults.integer(forKey: "default"))
        maximumTextField.text = String(defaults.integer(forKey: "maximum"))
        minimumTextField.text = String(defaults.integer(forKey: "minimum"))
        darkSwitch.isOn = defaults.bool(forKey: "dark")
        
        defaultTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        minimumTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        maximumTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.updatedMinMaxValues(min: Int(minimumTextField.text!)!, max: Int(maximumTextField.text!)!)
    }

    @IBAction func darkModeSwitch(_ sender: Any) {
        defaults.set(darkSwitch.isOn, forKey: "dark")
        defaults.synchronize()
    }
    
    func textFieldDidChange() {
        defaults.set(Int(defaultTextField.text!), forKey: "default")
        defaults.set(Int(minimumTextField.text!), forKey: "minimum")
        defaults.set(Int(maximumTextField.text!), forKey: "maximum")
        defaults.synchronize()
    }

}

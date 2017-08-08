//
//  SettingsViewController.swift
//  tipped
//
//  Created by Braden Casperson on 8/6/17.
//  Copyright © 2017 Braden Casperson. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var defaultTextField: UITextField!
    @IBOutlet weak var minimumTextField: UITextField!
    @IBOutlet weak var maximumTextField: UITextField!
    
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
        
        defaultTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        minimumTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        maximumTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }

    @IBAction func darkModeSwitch(_ sender: Any) {
    
    }
    
    func textFieldDidChange() {
        defaults.set(Int(defaultTextField.text!), forKey: "default")
        defaults.set(Int(minimumTextField.text!), forKey: "minimum")
        defaults.set(Int(maximumTextField.text!), forKey: "maximum")
        defaults.synchronize()
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return defaultSettings.count
//        } else {
//            return otherSettings.count
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Tip Percentage"
//        } else {
//            return "Other"
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as UITableViewCell!
//            cell?.textLabel?.text = self.defaultSettings[indexPath.row]
//            return cell!
//        } else if indexPath.row == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "DarkModeCell") as UITableViewCell!
//            cell?.textLabel?.text = self.otherSettings[indexPath.row]
//            return cell!
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as UITableViewCell!
//            cell?.textLabel?.text = "History"
//            return cell!
//        }
//    }

}

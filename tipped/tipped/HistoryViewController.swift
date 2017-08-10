//
//  HistoryViewController.swift
//  tipped
//
//  Created by Braden Casperson on 8/9/17.
//  Copyright © 2017 Braden Casperson. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var history = [[String: Any]]()
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        history = defaults.array(forKey: "history") as! [[String: Any]]
        formatter.numberStyle = .currency
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return history.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        let row = indexPath.row
        
        cell.bill.text = formatter.string(from: history[row]["bill"]! as! NSNumber)
        cell.tip.text = formatter.string(from: history[row]["tip"]! as! NSNumber)
        cell.total.text = formatter.string(from: history[row]["total"]! as! NSNumber)
        cell.percentage.text = String(describing: (history[row]["percentage"]! as! Double) * 100)
        
//        cell.bill.text = String(describing: history[row]["bill"]!)
//        cell.tip.text = String(describing: history[row]["tip"]!)
//        cell.total.text = String(describing: history[row]["total"]!)
        cell.date.text = String(describing: history[row]["date"]!)
        
        return cell
    }
}

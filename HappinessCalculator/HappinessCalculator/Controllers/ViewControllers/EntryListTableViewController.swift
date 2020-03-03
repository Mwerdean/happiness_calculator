//
//  EntryListTableViewController.swift
//  NotificationPatternsJournal
//
//  Created by Matthew Werdean on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

/// Creating a notification key that we can call from anywhere, also known as a Global Property
let notificationKey = Notification.Name(rawValue: "didChangeHappiness")

class EntryListTableViewController: UITableViewController {
    
    var averageHappiness: Int = 0 {
        // Property observer. Will fire when the property changes.
        didSet {
            /// Shouting out that we are just updatre our average happiness. Specificallly to the createObserver function
            NotificationCenter.default.post(name: notificationKey, object: self.averageHappiness)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryCellTableViewCell else {return UITableViewCell()}
        let entry = EntryController.entries[indexPath.row]
        cell.setEntry(entry: entry, averageHappiness: 0)
   // step 4
        /// set the gd delegate
        cell.delegate = self
        return cell
    }
    
    func updateAverageHappiness(){
        var totalHappiness = 0
        for entry in EntryController.entries {
            if entry.isIncluded {
                totalHappiness += entry.happiness
            }
        }
        averageHappiness = totalHappiness / EntryController.entries.count
    }
} // End of class

// Step 3
/// Creating our intern who will do stuff
extension EntryListTableViewController: EntryCellTableViewCellDelegate {
    /// Creating a list of instructions for when our intern is told do something
    func switchToggledOn(cell: EntryCellTableViewCell) {
        // entry = cell.entry is being passed in from the prev function.
        guard let entry = cell.entry else {return}
        // now set the specific cell to a constant
        EntryController.updateEntry(entry: entry)
        updateAverageHappiness()
        cell.updateUI(averageHappiness: averageHappiness)
    }
}

//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Matthew Werdean on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

/// Declaring a protocol and allowing it to use class level objects
protocol EntryCellTableViewCellDelegate: class {
    /// Creating a job that the boss, or tableViewCell, can tell our intern. or tableViewController, to do
    func switchToggledOn(cell: EntryCellTableViewCell)
}

class EntryCellTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
    
    /// Creating our intern
    weak var delegate: EntryCellTableViewCellDelegate?
    
    // MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
    }
    
    @objc func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabled.isOn = entry.isIncluded
    
        //Update highOrLowerLabel after notifications
        higherOrLowerLabel.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver() {
        /// Creating our person who will listen for our notification, then call recalculate Happiness
        // Default if the singleton of Notification center. Use it to make sure you are using the same instance
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: notificationKey, object: nil)
    }
    
    @objc func recalculateHappiness(notification: NSNotification) {
        guard let averageHappiness = notification.object as? Int else {return}
        updateUI(averageHappiness: averageHappiness)
    }
    
    // MARK: - Actions
    @IBAction func toggledIsIncluded(_ sender: Any) {
        /// Telling our runner to go tell our intern to do something
        delegate?.switchToggledOn(cell: self)
    }
}

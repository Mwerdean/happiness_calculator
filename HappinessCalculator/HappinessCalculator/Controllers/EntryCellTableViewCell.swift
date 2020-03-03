//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Matthew Werdean on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

protocol EntryCellTableViewCellDelegate: class {
    func switchToggledOn(cell: EntryCellTableViewCell)
}

class EntryCellTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
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
        // Default if the singleton of Notificaiton center. Use it to make sure you are using the same instance
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: notificationKey, object: nil)
    }
    
    // MARK: - Actions
    @IBAction func toggledIsIncluded(_ sender: Any) {
        delegate?.switchToggledOn(cell: self)
    }
}

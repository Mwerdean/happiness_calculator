//
//  EntryCellTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Matthew Werdean on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryCellTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLowerLabel: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!
    
    // MARK: - Properties
    var entry: Entry?
    
    // MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabled.isOn = entry.isIncluded
    
        //Update highOrLowerLabel after notifications
    }
}

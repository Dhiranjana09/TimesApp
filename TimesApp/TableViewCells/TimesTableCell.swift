//
//  TimesTableCell.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import UIKit

class TimesTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    static let reuseIdentifier  = "TimesTableCell"
}

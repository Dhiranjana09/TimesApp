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
    var section: Section? {
        didSet{
            titleLabel.text = section?.title
            byLineLabel.text = section?.byline
            createdDateLabel.text = section?.created_date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

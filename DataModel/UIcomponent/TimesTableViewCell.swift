//
//  TimesTableViewCell.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 3/11/21.
//

import UIKit

class TimesTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    var section = [Section]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

    func configCell(with section:Section) -> Void {
        titleLabel.text = section.title
        byLineLabel.text = section.byline
        createdDateLabel.text = section.created_date
    }
}

//
//  NewsTableViewDataSource.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 24/11/21.
//

import Foundation
import UIKit
import SafariServices

class NewsTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    private var newsdataModel: NewsViewModel!
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  items.count > 0 ? items.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        if cellIdentifier != NoDataTableViewCell.reuseIdentifier {
            let item = self.items[indexPath.row]
            self.configureCell(cell, item)
        }
        return cell
    }
}

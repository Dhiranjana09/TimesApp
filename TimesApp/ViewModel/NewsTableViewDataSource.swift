//
//  NewsTableViewDataSource.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 24/11/21.
//

import Foundation
import UIKit
import SafariServices

class NewsTableViewDataSource<CELL : UITableViewCell> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String
    var configureCell : (CELL, Story) -> () = {_,_ in }
    
    //MARK:VM should encapsulates the model data, not the DataSource
    private var newsViewModel: NewsViewModel
    
    init(newsViewModel: NewsViewModel, cellIdentifier : String, configureCell : @escaping (CELL, Story) -> ()) {
        self.newsViewModel = newsViewModel
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfStories(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL else { fatalError("Failed to deque Cell with id: \(String(describing: cellIdentifier))")}
        
        if let item = newsViewModel.story(atIndexPath: indexPath) {
            self.configureCell(cell, item)
        }
        return cell
    }
}

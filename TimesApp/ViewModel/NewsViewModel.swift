//
//  NewsViewModel.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 24/11/21.
//

import UIKit

class NewsViewModel {
    
    private var requestManager : NetworkRequestable
    private(set) var resultData : Results? {
        didSet {
            self.bindNewsViewModelToController()
        }
    }
    var bindNewsViewModelToController : (() -> ()) = {}
    
    init(_ requestManager: NetworkRequestable) {
        self.requestManager =  requestManager
    }
    
    func updateData(completionHandler: () -> Void) {
        self.requestManager.getSectionData { (results, error) in
            self.resultData =  results
        }
        completionHandler()
    }
    
    public var numberOfSections: Int {
        return (resultData?.results) != nil ? 1 : 0
    }
    
    func numberOfStories(inSection section: Int) -> Int {
        if section >= 0 && section < numberOfSections {
            return resultData?.results.count ?? 0
        } else {
            return 0
        }
    }
    
    func story(atIndexPath indexPath: IndexPath) -> Story? {
        if indexPath.row >= 0 && indexPath.row < numberOfStories(inSection: indexPath.section) {
            return resultData?.results[indexPath.row] ?? nil
        } else {
            return nil
        }
        
    }
}



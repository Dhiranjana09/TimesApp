//
//  NewsViewModel.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 24/11/21.
//

import UIKit

class NewsViewModel: NSObject {
    
    private var networkRequest : NetworkRequestManager!
    private(set) var resultData : Results! {
        didSet {
            self.bindNewsViewModelToController()
        }
    }
    var bindNewsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.networkRequest =  NetworkRequestManager()
        callFuncToGetSectionData()
    }
    
    func callFuncToGetSectionData() {
        self.networkRequest.getSectionData { (results, error) in
            self.resultData =  results
        }
       
    }
}



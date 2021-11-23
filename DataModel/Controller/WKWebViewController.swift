//
//  WKWebViewController.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    var url:URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWebView()
    }
    
    private func loadWebView() {
        guard let webviewUrl = self.url else {
           return
        }
        let urlRequest = URLRequest.init(url: webviewUrl)
        wkWebView.load(urlRequest)
    }
}

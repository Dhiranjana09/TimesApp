//
//  ViewController.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 3/11/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var timesTableView: UITableView!
    var networkRequest = NetworkRequestManager()
    var sectionList: [Section] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkmanager:NetworkRequestManager = NetworkRequestManager()
        networkmanager.getSectionData{ (results, error) in
            self.sectionList = results?.results ?? []
            DispatchQueue.main.async {
                self.timesTableView.reloadData()
            }
        }
    }
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = timesTableView.dequeueReusableCell(withIdentifier:"timesCell") as? TimesTableViewCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = sectionList[indexPath.row].title
            return cell
        }
        cell.configCell(with: sectionList[indexPath.row])
  
       return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let wkwebviewcontroller = storyboard.instantiateViewController(withIdentifier: "wkWebViewController") as!WKWebViewController
//        wkwebviewcontroller.url = sectionList[indexPath.row].url
//        navigationController?.pushViewController(wkwebviewcontroller, animated: true)
        
        let sf = SFSafariViewController(url:sectionList[indexPath.row].url)
            // sf.modalPresentationStyle
//        sf.modalPresentationStyle = .formSheet
        self.navigationController?.present(sf, animated: true, completion: nil)
    }
}




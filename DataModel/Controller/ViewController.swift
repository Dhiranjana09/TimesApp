//
//  ViewController.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    //MARK: Outlet set variable declration
    @IBOutlet weak var timesTableView: UITableView!
    var sectionList: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpTableView()
        self.loadDataFromApi()
    }
    
    
    func SetUpTableView() {
        timesTableView.register(UINib(nibName: TimesTableCell.reuseIdentifier, bundle:nil ), forCellReuseIdentifier: TimesTableCell.reuseIdentifier)
    }
    
    
    //MARK: LoadData From Api
    func loadDataFromApi() {
        NetworkRequestManager.shared.getSectionData{ (results, error) in
            if error != nil {
                return
            }
            self.sectionList = results?.results ?? []
            DispatchQueue.main.async {
                self.timesTableView.reloadData()
            }
        }
    }
}

//MARK: UITableview Delegate and Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = timesTableView.dequeueReusableCell(withIdentifier:TimesTableCell.reuseIdentifier) as? TimesTableCell else {
            let cell = UITableViewCell()
            cell.textLabel?.text = sectionList[indexPath.row].title
            return cell
        }
        cell.configCell(with: sectionList[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sf = SFSafariViewController(url:sectionList[indexPath.row].url)
        self.navigationController?.present(sf, animated: true, completion: nil)
    }
}




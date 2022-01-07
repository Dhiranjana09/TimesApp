//
//  ViewController.swift
//  TimesApp
//
//  Created by Dhiranjana Yadav on 22/11/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate {
    //MARK: Outlet set variable declration
    @IBOutlet weak var timesTableView: UITableView!
    private var newsdataModel: NewsViewModel!
    private var newsDataSource: NewsTableViewDataSource<TimesTableCell, Section>!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpTableView()
        self.timesTableView.reloadData()
        callToViewModelForUIUpdate()
       
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.callToViewModelForUIUpdate()
        refreshControl.endRefreshing()
    }
    
    //MARK:Update UI
    func SetUpTableView() {
        timesTableView.tableFooterView = UIView()
        timesTableView.addSubview(refreshControl)
        timesTableView.register(UINib(nibName: TimesTableCell.reuseIdentifier, bundle:nil ), forCellReuseIdentifier: TimesTableCell.reuseIdentifier)
        timesTableView.register(UINib(nibName: NoDataTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
    }
    
    //MARK:Api call and Data binding
    func callToViewModelForUIUpdate(){
        self.newsdataModel =  NewsViewModel()
        self.newsdataModel.bindNewsViewModelToController = {
            self.updateDataSource()
        }
    }
    //MARK:Update Datasource of TableView
    func updateDataSource(){
        self.newsDataSource = NewsTableViewDataSource(cellIdentifier: TimesTableCell.reuseIdentifier, items: self.newsdataModel.resultData.results, configureCell: { (cell, sec) in
            cell.titleLabel.text = sec.title
            cell.byLineLabel.text = sec.byline
            cell.createdDateLabel.text = sec.created_date.dateFormater(format:"yyyy-MM-dd")
        })
        
        DispatchQueue.main.async {
            self.timesTableView.dataSource = self.newsDataSource
            self.timesTableView.delegate = self
            self.timesTableView.reloadData()
        }
    }
}
//MARK: TableView Delegate Method
extension ViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sf = SFSafariViewController(url:newsdataModel.resultData.results[indexPath.row].url)
        self.navigationController?.present(sf, animated: true, completion: nil)
    }
}



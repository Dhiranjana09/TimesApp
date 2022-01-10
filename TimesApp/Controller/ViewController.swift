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
    private var newsViewModel: NewsViewModel!
    private var newsDataSource: NewsTableViewDataSource<TimesTableCell>!
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
        title = "NY Times News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpTableView()
        callToViewModelForUIUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadingIndicator.showUniversalLoadingView(true, loadingText: "Loading Data..")
        newsViewModel.updateData {
            LoadingIndicator.showUniversalLoadingView(false)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        LoadingIndicator.showUniversalLoadingView(true, loadingText: "Loading Data..")
        newsViewModel.updateData {
            LoadingIndicator.showUniversalLoadingView(false)
        }
        refreshControl.endRefreshing()
    }
    
    //MARK:Update UI
    
    func setUpTableView() {
        timesTableView.addSubview(refreshControl)
        timesTableView.register(UINib(nibName: TimesTableCell.reuseIdentifier, bundle:nil ), forCellReuseIdentifier: TimesTableCell.reuseIdentifier)
    }
    
    //MARK:Api call and Data binding
    func callToViewModelForUIUpdate(){
        newsViewModel =  NewsViewModel(NetworkRequestManager())
        newsViewModel.bindNewsViewModelToController = {
            self.didUpdateViewModel()
        }
        newsDataSource = NewsTableViewDataSource(newsViewModel: newsViewModel, cellIdentifier: TimesTableCell.reuseIdentifier, configureCell: { (cell, sec) in
            cell.titleLabel.text = sec.title
            cell.byLineLabel.text = sec.byline
            cell.createdDateLabel.text = sec.createdDate.relativeDateTime
        })
    }
    //MARK:Update Datasource of TableView
    func didUpdateViewModel(){
        
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
        guard let story = newsViewModel.story(atIndexPath: indexPath) else { return }
        let sf = SFSafariViewController(url: story.url)
        navigationController?.present(sf, animated: true, completion: nil)
    }
}



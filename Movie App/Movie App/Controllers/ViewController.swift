//
//  ViewController.swift
//  Movie App
//
//  Created by Mili on 03/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var networkView: UIView!

    var unfilteredDataSource: [Movie] = [] {
        didSet {
            dataSource = unfilteredDataSource
//            filterDataSource(with: searchTerm)
        }
    }
    var dataSource: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkView.alpha = 0.0
        self.initialSetup()
    }
    // MARK: - Initial setup
    func initialSetup(){
        if Reachability.isConnectedToNetwork(){
            networkView.alpha = 0.0
            loadingView.alpha = 1.0
            unfilteredDataSource = []
            fetchData(with: pageNumber)
        }else{
            unfilteredDataSource = OfflineData.getData()
            if unfilteredDataSource.count == 0{
                networkView.alpha = 1.0
                Constants.normalDisplayAert(msg_title: "Error", msg_desc: "Check your Internet and Retry", action_title: "Ok", myVC: self)
            }else{
                networkView.alpha = 0.0
                loadingView.alpha = 0.0
            }
        }
    }
    // MARK: - fetching Data
    func fetchData(with page: Int){
        MoviesData.getData(with: page) { (error, movies) -> (Void) in
            self.hideLoading()
            if let error = error{
                Constants.normalDisplayAert(msg_title: "Error", msg_desc: error, action_title: "Ok", myVC: self)
            }else{
                for item in movies{
                    self.unfilteredDataSource.append(item)
                }
            }
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
            self.loadingView.alpha = 0.0
        }
    }
    @IBAction func tapOnRetry(_ sender: Any) {
        initialSetup()
    }
}


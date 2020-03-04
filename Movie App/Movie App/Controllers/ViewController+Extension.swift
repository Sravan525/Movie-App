//
//  ViewController+Extension.swift
//  Movie App
//
//  Created by Mili on 03/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//


import UIKit

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count == 0{
            tableView.alpha = 0.0
        }else{
            tableView.alpha = 1.0
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as! MovieCell
        let data = dataSource[indexPath.row]
        if data.fileExists() == false{
            cell.loading.startAnimating()
            cell.imageRef.image = UIImage(named: "movie")
        }
        cell.loadImage(with: data)
        cell.lblTitle.text = data.original_title
        if indexPath.row == dataSource.count - 1 { // last cell
            if Reachability.isConnectedToNetwork(){
                pageNumber = pageNumber + 1
                fetchData(with: pageNumber)
            }else{
                Constants.normalDisplayAert(msg_title: "Error", msg_desc: "Check your Internet and Retry", action_title: "Ok", myVC: self)
            }
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSource[indexPath.row]
        let dvc = storyboard?.instantiateViewController(identifier: String(describing: DetailsViewController.self)) as! DetailsViewController
        dvc.movie = data
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
}

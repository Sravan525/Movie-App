//
//  Constants.swift
//  Movie App
//
//  Created by Mili on 03/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import UIKit

class Constants: NSObject{
    // MARK: - Constants
    static let apiKey = "a05011b6426510dae33def6de78a29a3"
    static let Content_Type = "application/json"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    static let get = "GET"
    // MARK: - Get API with page
    static func getApi(with page: Int) -> String{
        return "https://api.themoviedb.org/4/list/\(page)?api_key=\(Constants.apiKey)"
    }
    // MARK: - Alert
    static func normalDisplayAert(msg_title : String , msg_desc : String ,action_title : String, myVC : UIViewController){
        DispatchQueue.main.async {
            let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: action_title, style: .default){
                (result : UIAlertAction) -> Void in
            })
            myVC.present(ac, animated: true)
        }
    }

    static func moveFile(from path: URL, toPath: URL){
        if FileManager.default.fileExists(atPath: path.path){
            if FileManager.default.fileExists(atPath: toPath.path){
                removeFile(with: toPath)
            }
            do{
                try FileManager.default.moveItem(at: path, to: toPath)
            }
            catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    static func removeFile(with url: URL){
        do{
            try FileManager.default.removeItem(at: url)
        }catch {
            
        }
    }
    
}

//
//  MoviesData.swift
//  Movie App
//
//  Created by Mili on 03/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import UIKit

class MoviesData :NSObject{
    
    // MARK: - Get Data from API
    static func getData(with page: Int, completion: @escaping (String?,[Movie]) -> (Void)){
        var arrMovies = [Movie]()
        let url = URL(string: Constants.getApi(with: page))
        var request = URLRequest(url:url!)
        request.httpMethod = Constants.get
        request.setValue(Constants.Content_Type, forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let errorDescription = error?.localizedDescription {
                completion(errorDescription, arrMovies)
                print("Error ", errorDescription)
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                if let results = jsonData["results"] as? [[String: Any]]{
                    print("resilts",results)
                    for item in results{
                        let movie = Movie(with: item)
                        arrMovies.append(movie)
                        DispatchQueue.main.async {
                            OfflineData.saveData(with: movie)
                        }
                    }
                }
                completion(nil, arrMovies)
            }catch let error {
                print("ERROR")
                completion(error.localizedDescription, arrMovies)
            }
        }
        task.resume()
    }
    // MARK: - Get Image from server
    static func getImage(with fileName: String, completion: @escaping (UIImage?) -> (Void)){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("Downloads")
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error {
            print(error.localizedDescription)
        }
        let imagePath = dataPath.appendingPathComponent(fileName)
        let url = URL(string: Constants.imageUrl+fileName)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                do {
                    try data.write(to: imagePath, options: .atomic)
                    completion(UIImage(contentsOfFile: imagePath.path))
                } catch {
                    completion(nil)
                }
            }
        }.resume()
    }

}

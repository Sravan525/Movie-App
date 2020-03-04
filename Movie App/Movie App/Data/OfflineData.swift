//
//  OfflineData.swift
//  Movie App
//
//  Created by Mili on 04/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import UIKit
import CoreData

class OfflineData{
    // MARK: - Save in CoreDatta
    static func saveData(with movie:  Movie){
        if isExists(with: movie) == false{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "MovieData", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(movie.overview, forKey: "about")
            newUser.setValue(movie.poster_path, forKey: "imageUrl")
            newUser.setValue(movie.original_language, forKey: "language")
            newUser.setValue(movie.release_date, forKey: "releaseDate")
            newUser.setValue(movie.vote_average, forKey: "rating")
            newUser.setValue(movie.original_title, forKey: "title")
            do {
               try context.save()
              } catch {
               print("Failed saving")
            }
        }else{
            print("Exists")
        }
    }
    // MARK: - Get Data from CoreDatta
    static func getData() -> [Movie]{
        var datasource = [Movie]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return datasource }
        let context = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        do{
            let result = try context.fetch(fetch)
            for data in result as! [NSManagedObject]{
                datasource.append(Movie(with: data))
            }
        }catch{
        }
        return datasource
    }
    // MARK: - Check Data alraedy exists or not
    static func isExists(with movie:  Movie) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        fetch.predicate = NSPredicate(format: "imageUrl = %@", movie.poster_path)
        do{
            let result = try context.fetch(fetch)
            return result.count != 0
        }catch{
        }
        return false
    }

}

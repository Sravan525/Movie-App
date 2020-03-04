//
//  Movie.swift
//  Movie App
//
//  Created by Mili on 03/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import Foundation
import AVFoundation
import CoreData

class Movie : NSObject{
    
    var poster_path : String = ""
    var popularity : Double = 0.0
    var vote_count : Int64 = 0
    var video : Bool = false
    var media_type : String?
    var id : Int64 = 0
    var adult : Bool = false
    var backdrop_path : String = ""
    var original_language : String = "en"
    var original_title : String = ""
    var genre_ids : [Int] = []
    var title : String = ""
    var vote_average : Double = 0.0
    var overview : String = ""
    var release_date : String = ""
    
    
    init(with dict: [String: Any]){
        if let poster_path = dict["poster_path"] as? String{
            self.poster_path = poster_path
        }
        if let popularity = dict["popularity"] as? Double{
            self.popularity = popularity
        }
        if let vote_count = dict["vote_count"] as? Int64{
            self.vote_count = vote_count
        }
        if let video = dict["video"] as? Bool{
            self.video = video
        }
        if let media_type = dict["media_type"] as? String{
            self.media_type = media_type
        }
        if let id = dict["id"] as? Int64{
            self.id = id
        }
        if let adult = dict["adult"] as? Bool{
            self.adult = adult
        }
        if let backdrop_path = dict["backdrop_path"] as? String{
            self.backdrop_path = backdrop_path
        }
        if let original_language = dict["original_language"] as? String{
            self.original_language = original_language
        }
        if let original_title = dict["original_title"] as? String{
            self.original_title = original_title
        }
        if let genre_ids = dict["genre_ids"] as? [Int]{
            self.genre_ids = genre_ids
        }
        if let title = dict["title"] as? String{
            self.title = title
        }
        if let vote_average = dict["vote_average"] as? Double	{
            self.vote_average = vote_average
        }
        if let overview = dict["overview"] as? String{
            self.overview = overview
        }
        if let release_date = dict["release_date"] as? String{
            self.release_date = release_date
        }
    }
    
    init(with dict: NSManagedObject){
        if let poster_path = dict.value(forKey: "imageUrl") as? String{
            self.poster_path = poster_path
        }
        if let original_language = dict.value(forKey: "language") as? String{
            self.original_language = original_language
        }
        if let original_title = dict.value(forKey: "title") as? String{
            self.original_title = original_title
        }
        if let vote_average = dict.value(forKey: "rating") as? Double    {
            self.vote_average = vote_average
        }
        if let overview = dict.value(forKey: "about") as? String{
            self.overview = overview
        }
        if let release_date = dict.value(forKey: "releaseDate") as? String{
            self.release_date = release_date
        }
    }
    
    func fileExists() -> Bool{
        if poster_path != ""{
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let imagePath = documentsDirectory.appendingPathComponent("Downloads\(poster_path)")
            if FileManager.default.fileExists(atPath: imagePath.path){
                return true
            }
        }
        return false
    }
    
    func getFile() -> String{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = documentsDirectory.appendingPathComponent("Downloads\(poster_path)")
        return imagePath.path
    }
    
}

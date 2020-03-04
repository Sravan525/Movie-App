//
//  DetailsViewController.swift
//  Movie App
//
//  Created by Mili on 04/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageRef: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var movie : Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        // Do any additional setup after loading the view.
    }
    //MAR
    func initialSetUp(){
        imageRef.layer.masksToBounds = true
        imageRef.layer.cornerRadius = 5.0
        if let data = movie{
            textView.attributedText = getDetails(with: data)
            textView.textAlignment = .center
            if data.fileExists(){
                imageRef.image = UIImage(contentsOfFile: data.getFile())
            }else if data.poster_path == ""{
                imageRef.image = UIImage(named: "movie")
            }else{
                MoviesData.getImage(with: data.poster_path) { (img) -> (Void) in
                    if let image = img{
                        DispatchQueue.main.async {
                            self.imageRef.image = image
                        }
                    }
                }
            }
        }
    }
    
    func getDetails(with movie: Movie) -> NSMutableAttributedString{

        let title = "Title : \(movie.original_title == "" ? "-" : movie.original_title)\n\n"
        let rating = "Rating : \(movie.vote_average == 0.0 ? "-" : String(movie.vote_average) + "/10")\n\n"
        let releaseDate = "Release Date : \(movie.release_date)\n\n"
        let language = "Language : \(movie.original_language)\n\n"
        let about = "About :\n\(movie.overview)"
        let attributedString = NSMutableAttributedString(string: title + rating + releaseDate + language + about)
        let totleAtt = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!] as! [NSAttributedString.Key : Any]
        attributedString.addAttributes(totleAtt, range: NSRange(location: 0, length: 5))
        
        let ratingAtt = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!] as! [NSAttributedString.Key : Any]
        attributedString.addAttributes(ratingAtt, range: NSRange(location: (title).count, length: 6))
               
        let releaseAtt = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!] as! [NSAttributedString.Key : Any]
               attributedString.addAttributes(releaseAtt, range: NSRange(location: (title+rating).count, length: 12))
               
        let languageAtt = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!] as! [NSAttributedString.Key : Any]
               attributedString.addAttributes(languageAtt, range: NSRange(location: (title+rating+releaseDate).count, length: 8))
               
        let aboutAtt = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!] as! [NSAttributedString.Key : Any]
               attributedString.addAttributes(aboutAtt, range: NSRange(location: (title+rating+releaseDate+language).count, length: 5))
               
        return attributedString
    }
    
}

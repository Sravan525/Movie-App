//
//  MovieCell.swift
//  Movie App
//
//  Created by Mili on 03/03/20.
//  Copyright © 2020 sravan. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var imageRef: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func loadImage(with movie: Movie){
        startAnimating()
        if movie.fileExists(){
            imageRef.image = UIImage(contentsOfFile: movie.getFile())
            stopAnimating()
        }else if movie.poster_path == ""{
            imageRef.image = UIImage(named: "movie")
            stopAnimating()
        }else{
            if Reachability.isConnectedToNetwork(){
                MoviesData.getImage(with: movie.poster_path) { (img) -> (Void) in
                    if let image = img{
                        DispatchQueue.main.async {
                            self.imageRef.image = image
                        }
                    }
                    self.stopAnimating()
                }
            }else{
                self.stopAnimating()
            }
        }
    }
    
    func startAnimating(){
        DispatchQueue.main.async {
            self.loading.alpha = 1.0
            self.loading.startAnimating()
        }
    }
    
    func stopAnimating(){
        DispatchQueue.main.async {
            self.loading.alpha = 0.0
            self.loading.stopAnimating()
        }
    }

}

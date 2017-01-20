//
//  SerieCollectionViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit
import Kingfisher

class SerieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(serie: SerieModel){
        
        label.text = serie.title
        
        if let imdb = serie.imdb {
            configureImage(imdb: imdb)
        }
        
    }
    
    private func configureImage(imdb: String){
        
        ImageSerieRepository.getImageSerie(imdb: imdb, completionHandler: {[weak self] result in
            
            self?.activityIndicator.stopAnimating()
            self?.imageView.kf.setImage(with: URL(string: result?.imageUrl ?? ""))
        })
    }

    
}

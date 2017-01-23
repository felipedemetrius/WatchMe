//
//  ImageTableViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/20/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageSerie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureImage(imdb: String?){
        
        ImageRepository.getImage(imdb: imdb ?? "", completionHandler: {[weak self] result in
            
            self?.imageSerie.kf.setImage(with: URL(string: result?.imageUrl ?? ""), placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
            
        })

    }
    
}

//
//  NextEpisodeTableViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/20/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit
import Kingfisher

class NextEpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageEpisode: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblEpisode: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(episode: EpisodeModel?){
        
        guard let episode = episode else {
            lblTitle.text = "Unavailable"
            return
        }
        
        lblTitle.text = episode.title
        
        if let season = episode.season, let number = episode.number {
            lblEpisode.text = "S" + season.description + "E" + number.description
        }
    
        lblDate.text = episode.first_aired
        
        ImageSerieRepository.getImageSerie(imdb: episode.imdb ?? "") {[weak self] result in
            
            self?.imageEpisode.kf.setImage(with: URL(string: result?.imageUrl ?? ""))
        }
    }
    
}

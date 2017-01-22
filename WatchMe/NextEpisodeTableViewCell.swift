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

    @IBOutlet weak var btnWatch: UIButton!
    
    @IBOutlet weak var imageEpisode: UIImageView!
    
    @IBOutlet weak var lblNextEpisode: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEpisode: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var episode : EpisodeModel!
    var serie: SerieModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureNextEpisode(episode: EpisodeModel?){
        
        lblNextEpisode.text = "Next Episode"
        
        guard let episode = episode else {
            lblTitle.text = "Unavailable"
            return
        }
        
        lblTitle.text = episode.title
        
        lblEpisode.text = episode.target
        
        lblDate.text = episode.first_aired
        
        btnWatch.isHidden = true
        
        ImageSerieRepository.getImageSerie(imdb: episode.imdb ?? "") {[weak self] result in
            
            self?.imageEpisode.kf.setImage(with: URL(string: result?.imageUrl ?? ""))
        }
    }
    
    func configureEpisode(episode: EpisodeModel, serie: SerieModel){
        
        self.episode = episode
        self.serie = serie
        
        lblTitle.text = episode.title
        
        lblEpisode.text = episode.target
        
        btnWatch.isHidden = false
        
        ImageSerieRepository.getImageSerie(imdb: episode.imdb ?? "") {[weak self] result in
            
            self?.imageEpisode.kf.setImage(with: URL(string: result?.imageUrl ?? ""))
        }

        if SerieRepository.getEpisodeWatched(slug: serie.slug ?? "", target: episode.target ?? "") != nil {
            btnWatch.setImage(UIImage(named: "nowatching_icon"), for: UIControlState.normal)
        } else {
            btnWatch.setImage(UIImage(named: "watching_icon"), for: UIControlState.normal)
        }

    }
    
    @IBAction func watch(_ sender: UIButton) {
        
        if SerieRepository.getEpisodeWatched(slug: serie.slug ?? "", target: episode.target ?? "") == nil {
            
            serie.addEpisode(episode: episode)
            btnWatch.setImage(UIImage(named: "nowatching_icon"), for: UIControlState.normal)
        } else {
            serie.removeEpisode(episode: episode)
            btnWatch.setImage(UIImage(named: "watching_icon"), for: UIControlState.normal)
        }
        
    }
}

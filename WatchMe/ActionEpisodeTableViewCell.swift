//
//  ActionEpisodeTableViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/22/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class ActionEpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnWatch: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var serie : SerieModel!
    var episode : EpisodeModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(serie: SerieModel, episode : EpisodeModel){
        
        self.serie = serie
        self.episode = episode
        
        lblTitle.text = episode.title
        
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

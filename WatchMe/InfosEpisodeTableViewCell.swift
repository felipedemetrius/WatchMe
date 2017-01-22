//
//  InfosEpisodeTableViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/22/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class InfosEpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSeason: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(episode: EpisodeModel){
        lblSeason.text = "Season " + episode.season.description
        lblNumber.text = "Episode " + episode.number.description
        lblDate.text = episode.first_aired
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

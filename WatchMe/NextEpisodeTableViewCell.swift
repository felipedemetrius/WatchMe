//
//  NextEpisodeTableViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/20/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

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
    
    func configureCell(serie: SerieModel){
        
    }
    
}

//
//  ActionsSerieTableViewCell.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/20/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import UIKit

class ActionsSerieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnWatch: UIButton!
    
    @IBOutlet weak var btnWishlist: UIButton!
    
    @IBOutlet weak var lblPercent: UILabel!
    
    @IBOutlet weak var lblProgress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(serie: SerieModel){
        
        lblPercent.text = "0%"
        lblProgress.text = "0/" + serie.aired_episodes.description
    }

    @IBAction func wishlist(_ sender: UIButton) {
    }
    
    @IBAction func watch(_ sender: UIButton) {
    }
}

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
    
    var serie : SerieModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(serie: SerieModel){
        
        self.serie = serie
        
        lblPercent.text = progress().description + "%"
        lblProgress.text = serie.watchedEpisodes.count.description + "/" + serie.aired_episodes.description
        
        if serie.watching {
            btnWatch.setImage(UIImage(named: "nowatching_icon"), for: UIControlState.normal)
        } else {
            btnWatch.setImage(UIImage(named: "watching_icon"), for: UIControlState.normal)
        }

        if serie.wishlist {
            btnWishlist.setImage(UIImage(named: "wishlist_remove"), for: UIControlState.normal)
        } else {
            btnWishlist.setImage(UIImage(named: "wishlist_add"), for: UIControlState.normal)
        }

    }
    
    private func progress()-> Int{
        return serie.watchedEpisodes.count * 100 / serie.aired_episodes
    }

    @IBAction func wishlist(_ sender: UIButton) {
        
        if serie.wishlist {
            serie.update(value: false, key: "wishlist")
            btnWishlist.setImage(UIImage(named: "wishlist_add"), for: UIControlState.normal)
            
        } else {
            serie.update(value: true, key: "wishlist")
            btnWishlist.setImage(UIImage(named: "wishlist_remove"), for: UIControlState.normal)
        }

    }
    
    @IBAction func watch(_ sender: UIButton) {
        
        if serie.watching {
            serie.update(value: false, key: "watching")
            serie.removeAllEpisodes()
            configureCell(serie: serie)
            btnWatch.setImage(UIImage(named: "watching_icon"), for: UIControlState.normal)
            
        } else {
            serie.remove()
            btnWatch.setImage(UIImage(named: "nowatching_icon"), for: UIControlState.normal)
        }
        
    }
    
    
    
}

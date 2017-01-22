//
//  SeasonModel.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/22/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper

class SeasonModel: Mappable {
    
    var number : Int?
    var imdb : String?
    var tvdb : Int = 0
    var episodes : [EpisodeModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        number <- map["number"]
        imdb <- map["ids.imdb"]
        tvdb <- map["ids.tvdb"]
        episodes <- map["episodes"]
    }
    
}

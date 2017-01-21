//
//  EpisodeModel.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/21/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper

class EpisodeModel: Mappable {
    
    var season: Int?
    var number : Int?
    var title : String?
    var imdb : String?
    var overview : String?
    var first_aired : String?
    var updated_at : String?
    var tvdb : Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        season <- map["season"]
        number <- map["number"]
        title <- map["title"]
        imdb <- map["ids.imdb"]
        tvdb <- map["ids.tvdb"]
        overview <- map["overview"]
        first_aired <- map["first_aired"]
        updated_at <- map["updated_at"]
    }
    
}

//
//  EpisodeModel.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/21/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class EpisodeModel: Object, Mappable {
    
    dynamic var season: Int = -1
    dynamic var number : Int = -1
    dynamic var title : String?
    dynamic var imdb : String?
    dynamic var overview : String?
    dynamic var first_aired : String?
    dynamic var trakt : String?
    dynamic var updated_at : String?
    dynamic var tvdb : Int = 0
    
    var target : String? {
        return "S" + season.description + "E" + number.description
    }
    
    override class func primaryKey() -> String? {
        return "tvdb"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        season <- map["season"]
        number <- map["number"]
        title <- map["title"]
        imdb <- map["ids.imdb"]
        trakt <- map["ids.trakt"]
        tvdb <- map["ids.tvdb"]
        overview <- map["overview"]
        first_aired <- map["first_aired"]
        updated_at <- map["updated_at"]
    }
    
}

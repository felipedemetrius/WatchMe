//
//  SerieModel.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm


class SerieModel: Object, Mappable {
    
    dynamic var title: String?
    dynamic var slug : String?
    dynamic var imdb : String?
    dynamic var overview : String?
    dynamic var first_aired : String?
    dynamic var country : String?
    dynamic var updated_at : String?
    dynamic var tvdb : Int = 0
    dynamic var year: Int = 0
    dynamic var aired_episodes : Int = 0

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override class func primaryKey() -> String? {
        return "slug"
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        year <- map["year"]
        slug <- map["ids.slug"]
        imdb <- map["ids.imdb"]
        tvdb <- map["ids.tvdb"]
        overview <- map["overview"]
        first_aired <- map["first_aired"]
        country <- map["country"]
        updated_at <- map["updated_at"]
        aired_episodes <- map["aired_episodes"]
    }
    
}

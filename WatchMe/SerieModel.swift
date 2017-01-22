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

    dynamic var watching = false
    dynamic var wishlist = false
    var watchedEpisodes = List<EpisodeModel>()
    
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

extension SerieModel {
    
    func update(value: Any?, key: String){
        
        let realm = try! Realm()
        
        guard let slug = self.slug else {return}
        
        if SerieRepository.getLocal(slug: slug) == nil {
            
            try! realm.write {
                realm.add(self)
                self.setValue(value, forKey: key)
            }
            
        } else {
            try! realm.write {
                self.setValue(value, forKey: key)
            }
        }

    }
    
    func addEpisode(episode: EpisodeModel){
        
        let realm = try! Realm()
        
        if SerieRepository.getLocal(slug: self.slug ?? "") == nil {
            
            try! realm.write {
                realm.add(self)
                realm.add(episode)
                self.watchedEpisodes.append(episode)
                self.watching = true
            }
            
        } else {
            try! realm.write {
                realm.add(episode)
                self.watchedEpisodes.append(episode)
                self.watching = true
            }
        }
    }
    
    func removeEpisode(episode: EpisodeModel){
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(episode)
        }
        
    }
    
    func removeAllEpisodes(){
        
        let realm = try! Realm()
        try! realm.write {
            self.watchedEpisodes.removeAll()
        }
            
    }

    func remove(){
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
        
    }


}

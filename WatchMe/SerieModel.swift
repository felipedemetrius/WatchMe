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
    var watchedEpisodes = List<EpisodeModel>()
    var nextEpisode : EpisodeModel?
    
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
        
        guard let slug = self.slug else {return}
        
        guard let realm = Realm.safe() else {return}
        
        if SerieRepository.getLocal(slug: slug) == nil {
            
            do {
                try realm.write {
                    realm.add(self)
                    self.setValue(value, forKey: key)
                }
            }catch{ }
            
        } else {
            
            do {
                try realm.write {
                    self.setValue(value, forKey: key)
                }
            }catch{ }
            
            
        }

    }
    
    private func getCorrectEpisode(episode : EpisodeModel)-> EpisodeModel{
        
        if let episodeLocal = EpisodeRepository.getLocal(tvdb: episode.tvdb) {
            return episodeLocal
        } else {
            return episode
        }

    }
    
    func addEpisode(episode: EpisodeModel){
        
        let correctEpisode = getCorrectEpisode(episode: episode)
        
        guard let realm = Realm.safe() else {return}
        
        if SerieRepository.getLocal(slug: self.slug ?? "") == nil {
            
            do {
                try realm.write {
                    
                    realm.add(self)
                    
                    self.watchedEpisodes.append(correctEpisode)
                    self.watching = true
                }
            }catch{}
            
        } else {
            
            do {
                try realm.write {
                    
                    self.watchedEpisodes.append(correctEpisode)
                    self.watching = true
                }
            }catch{ }
            
            
        }
    }
    
    func removeEpisode(episode: EpisodeModel){
        
        if let episode = EpisodeRepository.getLocal(tvdb: episode.tvdb) {
            
            guard let realm = Realm.safe() else {return}
            
            do {
                try realm.write {
                    guard let index = self.watchedEpisodes.index(of: episode) else {return}
                    self.watchedEpisodes.remove(objectAtIndex: index)
                }
            }catch{}
            
            
        }
        
    }
    
    func removeAllEpisodes(){
        
        guard let realm = Realm.safe() else {return}
        
        do {
            try realm.write {
                self.watchedEpisodes.removeAll()
            }
        }catch{}
        
    }
    
    func remove(){
        
        guard let realm = Realm.safe() else {return}
        
        do {
            try realm.write {
                realm.delete(self)
            }
        }catch{}
        
    }


}

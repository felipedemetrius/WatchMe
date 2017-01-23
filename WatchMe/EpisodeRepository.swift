//
//  EpisodeRepository.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/21/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class EpisodeRepository{
    
    class func getNextEpisode(slug: String, encoding: ParameterEncoding = URLEncoding.queryString, completionHandler: @escaping (EpisodeModel?) -> ()){
        
        let url = TraktUrl.Shows.description + slug + "/" + TraktUrl.NextEpisode.rawValue
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: encoding, headers: TraktCredentials.header).responseObject { (response: DataResponse<EpisodeModel>) in
            
            completionHandler(response.result.value)
        }
    }
    
    class func getEpisodeDetail(slug: String, season: Int, episode: Int, completionHandler: @escaping (EpisodeModel?) -> ()){
        
        let url = TraktUrl.Shows.description + slug + "/" + TraktUrl.Seasons.rawValue + season.description + "/" + TraktUrl.Episodes.rawValue + episode.description + TraktUrl.Full.rawValue
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseObject { (response: DataResponse<EpisodeModel>) in
            
            completionHandler(response.result.value)
        }
        
    }

    class func getLocal(tvdb : Int) -> EpisodeModel? {
        
        guard let realm = Realm.safe() else {return nil}
        return realm.objects(EpisodeModel.self).filter("tvdb == \(tvdb)").first
    }
    
}

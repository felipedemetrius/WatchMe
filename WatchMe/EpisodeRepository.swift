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

    
}

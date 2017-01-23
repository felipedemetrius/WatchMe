//
//  SeasonRepository.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/22/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class SeasonRepository{
    
    class func getSeasons(slug: String, completionHandler: @escaping ([SeasonModel]?) -> ()){
        
        let url = TraktUrl.Shows.description + slug + "/" + TraktUrl.SeasonsFull.rawValue
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseArray { (response: DataResponse<[SeasonModel]>) in
            
            completionHandler(response.result.value)
        }
        
    }
    
    
}

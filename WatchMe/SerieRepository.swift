//
//  SerieRepository.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

enum TraktUrl: String{
    
    case Base                = "https://api.trakt.tv/shows/"
    case Trending            = "trending/"
    case Popular             = "popular?extended=full"
    
    
    var description: String{
        switch self{
        case .Base:
            return rawValue
        default:
            return TraktUrl.Base.description + rawValue
        }
    }
}

struct TraktCredentials{
    
    static var key:String{
        return "63b91d36f0e1ca57e602f791cc912a972ff3e6d93a96d43b135457adcd1cc04f"
    }
    
    static var header:[String:String]{
        
        let headers = [
            "Content-Type"  : "application/json",
            "trakt-api-key" : "\(key)",
            "trakt-api-version": "2"
        ]
        
        return headers
    }
    
}

class SerieRepository{
    
    class func getSeriesPopular(parameters: [String:AnyObject]? = nil, encoding: ParameterEncoding = URLEncoding.httpBody, completionHandler: @escaping ([SerieModel]?) -> ()){
        
        Alamofire.request(TraktUrl.Popular.description, method: .get, parameters: parameters, encoding: encoding, headers: TraktCredentials.header).responseArray { (response: DataResponse<[SerieModel]>) in

            completionHandler(response.result.value)
        }
        
    }
        
}


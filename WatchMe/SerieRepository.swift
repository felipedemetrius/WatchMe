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
    
    case Base        = "https://api.trakt.tv/"
    case Shows       = "shows/"
    case Trending    = "shows/trending/?extended=full"
    case Search      = "search/show?extended=full"
    case NextEpisode = "next_episode?extended=full"
    
    
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

class WrapperShow<T: Mappable>: Mappable {
    
    var result: T?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        result <- map["show"]
    }
}

class SerieRepository{
    
    private static var page = 1
    private static var lastUrl: String!
    
    class func getSeriesTrending(parameters: [String:AnyObject]? = nil, encoding: ParameterEncoding = JSONEncoding.prettyPrinted, completionHandler: @escaping ([SerieModel]?) -> ()){
        
        Alamofire.request(TraktUrl.Trending.description, method: .get, parameters: parameters, encoding: encoding, headers: TraktCredentials.header).responseJSON { response in
            
            self.lastUrl = TraktUrl.Trending.description
            self.page = 1
            
            completionHandler(wrapperTrendingSerie(value: response.result.value))
        }
        
    }
    
    class func searchSeries(parameters: Parameters? = nil, query : String, completionHandler: @escaping ([SerieModel]?) -> ()){
        
        Alamofire.request(TraktUrl.Search.description, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseJSON { response in
            
            self.lastUrl = TraktUrl.Search.description
            self.page = 1
            
            completionHandler(wrapperTrendingSerie(value: response.result.value))
        }
        
    }
    
    
    class func wrapperTrendingSerie(value: Any?) -> [SerieModel]?{
        
        guard let series = Mapper<WrapperShow<SerieModel>>().mapArray(JSONObject: value)
            else { return nil}
        
        let result = series.flatMap({ serie in
            return serie.result
        })
        
        return result
    }

    
    class func nextSeries(parameters: Parameters? = nil, completionHandler: @escaping ([SerieModel]?) -> ()){
        
        page += 1
        
        var parameters = Parameters()
        parameters["page"] = page

        Alamofire.request(lastUrl, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseJSON { response in
            
            completionHandler(wrapperTrendingSerie(value: response.result.value))
        }
        
    }
    
    class func getLocal(slug : String) -> SerieModel? {
        let realm = try! Realm()
        return realm.objects(SerieModel.self).filter("slug == '\(slug)'").first
    }
    
    class func getWatching() -> [SerieModel]? {
        let realm = try! Realm()
        
        let series = realm.objects(SerieModel.self).filter("watching == true")
        return series.reversed()
    }
    
    class func getWishlist() -> [SerieModel]? {
        let realm = try! Realm()
        
        let series = realm.objects(SerieModel.self).filter("wishlist == true")
        return series.reversed()
    }

}


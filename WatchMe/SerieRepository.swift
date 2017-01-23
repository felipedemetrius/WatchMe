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
    case Seasons     = "seasons/"
    case Episodes    = "episodes/"
    case Full        = "?extended=full"
    case Trending    = "shows/trending/?extended=full"
    case Search      = "search/show?extended=full"
    case NextEpisode = "next_episode?extended=full"
    case SeasonsFull = "seasons?extended=episodes"
        
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
    
    private static var pageTrending = 1
    private static var pageSearch = 1
    
    class func getSeriesTrending(completionHandler: @escaping ([SerieModel]?) -> ()){
        
        Alamofire.request(TraktUrl.Trending.description, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: TraktCredentials.header).responseJSON { response in
            
            self.pageTrending = 1
            
            completionHandler(wrapperTrendingSerie(value: response.result.value))
        }
        
    }
    
    class func searchSeries(text : String, completionHandler: @escaping ([SerieModel]?) -> ()){
        
        var parameters = Parameters()
        parameters["query"] = text
        
        Alamofire.request(TraktUrl.Search.description, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseJSON { response in
            
            self.pageSearch = 1
            
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

    
    class func nextTrending(completionHandler: @escaping ([SerieModel]?) -> ()){
        
        pageTrending += 1
        
        var parameters = Parameters()
        parameters["page"] = pageTrending

        Alamofire.request(TraktUrl.Trending.description, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseJSON { response in
            
            completionHandler(wrapperTrendingSerie(value: response.result.value))
        }
    }
    
    class func nextSearch(text: String, completionHandler: @escaping ([SerieModel]?) -> ()){
        
        pageSearch += 1
        
        var parameters = Parameters()
        parameters["query"] = text
        parameters["page"] = pageSearch
        
        Alamofire.request(TraktUrl.Search.description, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: TraktCredentials.header).responseJSON { response in
            
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
    
    class func getSlugsLocal()-> [String]?{
        
        let realm = try! Realm()
        let series = realm.objects(SerieModel.self).filter("watching == true")
        
        var slugs : [String] = []
        
        for serie in series {
            slugs.append(serie.slug ?? "")
        }
        
        return slugs.count > 0 ? slugs : nil
    }
    
    class func getSeriesWithEpisodes() -> [SerieModel]? {
        let realm = try! Realm()
        let series = realm.objects(SerieModel.self).filter("watching == true").filter { serie -> Bool in
            return serie.watchedEpisodes.count > 0
        }
        
        return series.reversed()
    }
    
    class func getEpisodeWatched(slug : String, target: String) -> EpisodeModel? {
        let realm = try! Realm()
        return realm.objects(SerieModel.self).filter("slug == '\(slug)'").first?.watchedEpisodes.first(where: { episode -> Bool in
            return episode.target == target
        })
    }
        
}


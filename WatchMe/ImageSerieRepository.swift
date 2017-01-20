//
//  ImageSerieRepository.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class ImageSerieRepository{

    class func getImageSerie(imdb: String, completionHandler: @escaping (ImageSerieModel?) -> ()){
        
        let url = "http://www.omdbapi.com/?i=\(imdb)&plot=short&r=json"
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.httpBody).responseObject { (response: DataResponse<ImageSerieModel>) in
            
            completionHandler(response.result.value)
        }
        
    }

}

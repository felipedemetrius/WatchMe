//
//  Credentials.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation

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

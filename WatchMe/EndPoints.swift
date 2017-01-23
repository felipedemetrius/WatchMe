//
//  EndPoints.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation

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

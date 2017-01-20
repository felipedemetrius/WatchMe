//
//  ImageSerieModel.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import Foundation
import ObjectMapper


class ImageSerieModel: Mappable {

    var imageUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        imageUrl <- map["Poster"]
    }
}

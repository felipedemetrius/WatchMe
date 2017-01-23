//
//  RealmExtension.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import RealmSwift
import ObjectMapper_Realm

extension Realm {
    
    class func safe()->Realm?{
        
        do {
            let realm =  try Realm()
            return realm
        } catch{
            return nil
        }
    }
            
}

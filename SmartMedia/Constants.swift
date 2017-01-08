//
//  Constants.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 07/01/2017.
//  Copyright © 2017 antoine.soulier. All rights reserved.
//

import Foundation

class Constants {
    static let APP_NAME:String = "SmartMedia"
    static let DEFAULT_PORT:String = "8080"
    static let DEFAULT_HOST:String = "http://localhost:" + DEFAULT_PORT
    
    class Operation {
        static let GET_SONG:String = "/api/audio/list"
        static let UPLOAD_SONG:String  = "/api/audio/upload"
        static let COUNT_SONG:String = "/api/audio/count"
    }
}

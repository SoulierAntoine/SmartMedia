//
//  Sound.swift
//  SmartMedia
//
//  Created by Soulier Antoine on 25/11/2016.
//  Copyright © 2016 antoine.soulier. All rights reserved.
//

import Foundation

class Sound:NSObject {
    var title:String;
    var ext:String;
    var isPlaying:Bool
    
    init(title:String, ext:String, isPlaying:Bool) {
        self.title = title;
        self.ext = ext;
        self.isPlaying = isPlaying
    }
    
    override var description: String {
        return ("\(title).\(ext)");
    }
}

//
//  LevelData.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/26.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import Foundation

struct LevelData {
    
    let birds: [String]
    
    init?(level: Int) {
        guard let levelDictionary = LevelsData.levelsDictionary["Level_\(level)"] as? [String:Any] else { return nil }
        guard let birdsData = levelDictionary["Birds"] as? [String] else { return nil }
        birds = birdsData
    }
    
}

//
//  AnimationHelper.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/20.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

class AnimationHelper {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture] {
        var textures = [SKTexture]()
        
        for index in 0..<atlas.textureNames.count {
            let textureName = name + String(index + 1)
            textures.append(atlas.textureNamed(textureName))
        }
        
        return textures
    }
    
}

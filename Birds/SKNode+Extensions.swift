//
//  SKNode+Extensions.swift
//  Birds
//
//  Created by 胡洞明 on 2018/6/19.
//  Copyright © 2018年 胡洞明. All rights reserved.
//

import SpriteKit

extension SKNode {
    
    func aspectScaleToSize(_ size: CGSize, width: Bool, multiplier: CGFloat) {
        let scale = width ? (size.width * multiplier) / frame.width : (size.height * multiplier) / frame.height
        setScale(scale)
    }
    
}

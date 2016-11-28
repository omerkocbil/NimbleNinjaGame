//
//  Constants.swift
//  Nimble Ninja
//
//  Created by Ömer Koçbil on 9.11.2016.
//  Copyright © 2016 Ömer Koçbil. All rights reserved.
//

import Foundation
import UIKit

let kMLGroundHeight: CGFloat = 10.0

let kDefaultXToMovePerSecond: CGFloat = 320.0

let heroCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1

let kNumberOfPointsPerLevel = 15
let kLevelGenerationTimes: [TimeInterval] = [1.0, 0.9, 0.8, 0.7, 0.6, 0.6, 0.5, 0.5, 0.4, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2,]

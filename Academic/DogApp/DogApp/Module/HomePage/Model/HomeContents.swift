//
//  HomeContents.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import Foundation
import UIKit

// Model for Home screen statistics
struct Home: Codable {
    var statsType, statsPercent, statsColor: String
    var statsProg: CGFloat
}


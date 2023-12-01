//
//  HomeEnum.swift
//  C
//
//  Created by Joseph William Santoso on 01/12/23.
//

import Foundation

enum FilmType: Int, CaseIterable {
    case recomendation
    case trending
    case topRated
    case upcoming
}

enum ParchmentTabs: Int, CaseIterable{
    case Suggest
    case Comments
}

enum DataType {
    case trending
    case topRated
    case upcoming
}

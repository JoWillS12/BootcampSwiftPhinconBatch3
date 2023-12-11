//
//  HomeProtocols.swift
//  C
//
//  Created by Joseph William Santoso on 01/12/23.
//

import Foundation

protocol MovieCellDelegate: AnyObject {
    func didSelectItem<T: Codable>(data: T)
    func seeDescTapped(dataType: DataType)
}

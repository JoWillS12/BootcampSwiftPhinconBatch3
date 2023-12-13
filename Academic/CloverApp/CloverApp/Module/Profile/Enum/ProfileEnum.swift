//
//  ProfileEnum.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import Foundation

enum ProfileTableViewSection: Int, CaseIterable {
    case editProfile = 0
    case notification
    case download
    case community
    case scan
    case game
    
    var title: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .notification: return "Notification"
        case .download: return "Download"
        case .community: return "Community"
        case .scan: return "Scan QR"
        case .game: return "GAME"
        }
    }
    
    var imageName: String {
        switch self {
        case .editProfile: return "person"
        case .notification: return "bell"
        case .download: return "square.and.arrow.down"
        case .community: return "person.3"
        case .scan: return "qrcode.viewfinder"
        case .game: return "gamecontroller"
        }
    }
}


enum NotifTableViewSection: Int, CaseIterable {
    case general = 0
    case arrival
    case service
    case release
    case update
    
    var title: String {
        switch self {
        case .general: return "General Notification"
        case .arrival: return "New Arrival"
        case .service: return "New Sevices Available"
        case .release: return "New Releases Movie"
        case .update: return "App Updates"
        }
    }
}

enum SectionIdentifier: String, CaseIterable {
    case notification
    case downloadQuality
    case audioQuality
    case delete
}

enum RowIdentifier: String {
    case notification
    case downloadOption
    case audioOption
    case delete
}

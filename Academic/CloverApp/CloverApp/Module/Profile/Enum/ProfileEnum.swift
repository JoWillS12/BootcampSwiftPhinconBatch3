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

    var title: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .notification: return "Notification"
        case .download: return "Download"
        }
    }

    var imageName: String {
        switch self {
        case .editProfile: return "person"
        case .notification: return "bell"
        case .download: return "square.and.arrow.down"
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

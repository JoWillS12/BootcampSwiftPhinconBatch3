//
//  BookmarkContents.swift
//  C
//
//  Created by Joseph William Santoso on 06/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

// MARK: - Bookmark
struct Bookmark {
    let movieId: Int
    let movieName: String
    let moviePic: String

    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as? [String: Any] ?? [:]
        movieId = snapshotValue["movieId"] as? Int ?? 0
        movieName = snapshotValue["movieName"] as? String ?? ""
        moviePic = snapshotValue["moviePic"] as? String ?? ""
    }
}


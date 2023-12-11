//
//  DownloadContent.swift
//  C
//
//  Created by Joseph William Santoso on 07/12/23.
//

import Foundation
import FirebaseDatabase

// MARK: - Download
struct Download {
    let movieId: Int
    let movieName: String
    let moviePic: String
    let movieGenre: String
    let movieDate: String

    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as? [String: Any] ?? [:]
        movieId = snapshotValue["movieId"] as? Int ?? 0
        movieName = snapshotValue["movieName"] as? String ?? ""
        moviePic = snapshotValue["moviePic"] as? String ?? ""
        movieGenre = snapshotValue["movieGenre"] as? String ?? ""
        movieDate = snapshotValue["movieDate"] as? String ?? ""
    }
}

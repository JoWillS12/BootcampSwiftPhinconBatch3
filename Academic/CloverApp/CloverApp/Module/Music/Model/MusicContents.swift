//
//  MusicContents.swift
//  C
//
//  Created by Joseph William Santoso on 15/12/23.
//

import Foundation

// MARK: - Tracks
struct Tracks: Codable {
    let data: [Datum]
    let total: Int
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let readable: Bool
    let title, titleShort, titleVersion, isrc: String
    let link: String
    let duration, trackPosition, diskNumber, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let md5Image: Md5Image
    let artist: Artist
    let type: DatumType

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case isrc, link, duration
        case trackPosition = "track_position"
        case diskNumber = "disk_number"
        case rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case md5Image = "md5_image"
        case artist, type
    }
}

// MARK: - Artist
struct Artist: Codable {
    let id: Int
    let name: Name
    let tracklist: String
    let type: ArtistType
}

enum Name: String, Codable {
    case ludwigVanBeethoven = "Ludwig van Beethoven"
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

enum Md5Image: String, Codable {
    case f7B774A90778E1E7915Dd012Cda5D7E0 = "f7b774a90778e1e7915dd012cda5d7e0"
}

enum DatumType: String, Codable {
    case track = "track"
}

//
//  CommunityContents.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import Foundation

struct ChatMessage: Codable {
    var userName: String
    var userPicture: String
    var contentType: ContentType
    var content: Content
    var timestamp: TimeInterval
    
    enum ContentType: String, Codable {
        case text
        case image
        case audio
    }
    
    struct Content: Codable {
        var text: String?
        var imageURL: String?
        var audioURL: String?
    }
    
    init(userName: String, userPicture: String, contentType: ContentType, content: Content, timestamp: TimeInterval) {
        self.userName = userName
        self.userPicture = userPicture
        self.contentType = contentType
        self.content = content
        self.timestamp = timestamp
    }
    
    func toJSON() -> [String: Any] {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return [:]
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]) ?? [:]
    }
    
    static func fromJSON(_ json: [String: Any]) -> ChatMessage? {
        guard let data = try? JSONSerialization.data(withJSONObject: json),
              let message = try? JSONDecoder().decode(ChatMessage.self, from: data) else {
            return nil
        }
        return message
    }
}

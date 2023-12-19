//
//  MusicViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 15/12/23.
//

import Foundation
import Alamofire
import AVFoundation

class MusicViewModel{
    var tracks: [Datum] = []
    var onDataUpdate: (() -> Void)?
    var players: [AVPlayer?] = []
    var currentlyPlayingIndex: Int?
    
    func fetchData() {
        MusicNetworkManager.shared.fetchTracks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tracks):
                self.tracks = tracks
                self.onDataUpdate?()
            case .failure(let error):
                print("Error fetching tracks: \(error)")
            }
        }
    }
    
    func playPreview(at index: Int) {
        // Check if the index is within the bounds of the tracks array
        guard index >= 0 && index < tracks.count else { return }
        guard let previewURL = URL(string: tracks[index].preview) else { return }
        
        // Pause the currently playing player
        if let currentIndex = currentlyPlayingIndex, currentIndex != index {
            players[currentIndex]?.pause()
        }
        
        // Play the audio preview for the selected track
        let playerItem = AVPlayerItem(url: previewURL)
        let player = AVPlayer(playerItem: playerItem)
        player.play()
        
        // Store the currently playing index and player
        currentlyPlayingIndex = index
        
        // Make sure the players array has enough elements to store the player
        while players.count <= index {
            players.append(nil)
        }
        
        players[index] = player
        onDataUpdate?()
    }
    
    
    func pausePreview(at index: Int) {
        players[index]?.pause()
        currentlyPlayingIndex = nil
        onDataUpdate?()
    }
    
    func playAllTracks() {
        // Pause the current track if playing
        if let playingIndex = currentlyPlayingIndex {
            pausePreview(at: playingIndex)
        }

        // Play all tracks sequentially
        var currentTimeOffset: Double = 0.0
        for index in 0..<tracks.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + currentTimeOffset) {
                self.playPreview(at: index)
            }
            currentTimeOffset += Double(tracks[index].duration)
        }

        // Schedule the next track to play after the total duration of all tracks
        let totalDuration = currentTimeOffset
        let delayInSeconds = DispatchTimeInterval.seconds(2)
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            // All tracks have been played
            self.currentlyPlayingIndex = nil
        }
    }
}

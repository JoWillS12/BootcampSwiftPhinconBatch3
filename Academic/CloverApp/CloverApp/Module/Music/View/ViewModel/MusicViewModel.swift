//
//  MusicViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 15/12/23.
//

import Foundation
import Alamofire
import AVFoundation

class MusicViewModel {
    var tracks: [MusicResult] = []
    var onDataUpdate: (() -> Void)?
    var players: [AVPlayer?] = []
    var currentlyPlayingIndex: Int?
    var isPlaying: Bool = false
    
    // Function to fetch tracks from the network
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
    
    // Function to play an audio preview at a specific index
    func playPreview(at index: Int) {
        guard index >= 0 && index < tracks.count else { return }
        guard let previewURL = URL(string: tracks[index].preview) else { return }
        
        if let currentIndex = currentlyPlayingIndex, currentIndex != index {
            players[currentIndex]?.pause()
        }
        
        let playerItem = AVPlayerItem(url: previewURL)
        let player = AVPlayer(playerItem: playerItem)
        player.play()
        
        currentlyPlayingIndex = index
        
        while players.count <= index {
            players.append(nil)
        }
        
        players[index] = player
        isPlaying = true
        onDataUpdate?()
    }
    
    // Function to pause the currently playing audio preview
    func pausePreview(at index: Int) {
        players[index]?.pause()
        currentlyPlayingIndex = nil
        isPlaying = false
        onDataUpdate?()
    }
    
    // Function to save the currently playing track index
    func saveState() {
        UserDefaults.standard.set(currentlyPlayingIndex, forKey: "currentlyPlayingIndex")
    }
    
    // Function to restore the previously playing track index
    func restoreState() {
        if let index = UserDefaults.standard.value(forKey: "currentlyPlayingIndex") as? Int {
            currentlyPlayingIndex = index
        }
    }
    
    // Function to play the next audio preview
    func playNextTrack() {
        guard let currentIndex = currentlyPlayingIndex else { return }
        let nextIndex = currentIndex + 1
        
        // Check if there is a next track
        guard nextIndex < tracks.count else {
            // If there is no next track, you can choose to loop back to the first track or stop playback.
            // For simplicity, let's stop playback if there is no next track.
            players[currentIndex]?.pause()
            currentlyPlayingIndex = nil
            isPlaying = false
            onDataUpdate?()
            return
        }
        
        // Play the audio preview of the next track
        playPreview(at: nextIndex)
    }
}

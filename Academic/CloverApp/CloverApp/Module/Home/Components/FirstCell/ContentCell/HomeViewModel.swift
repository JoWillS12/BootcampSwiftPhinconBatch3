//
//  HomeViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import Foundation

class HomeViewModel {
    
    var nowPlayingData: [NowPlaying] = []
    var genreData: [Genre] = []
    var trendingData: [Trending] = []
    var topData: [TopRated] = []
    var upcomingData: [Upcoming] = []
    
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .upcoming) { [weak self] (response: Result<(Upcoming), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let upcome):
                self.upcomingData = [upcome]
            case .failure(let error):
                self.onError?(error)
            }
        }
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .nowPlaying) { [weak self] (response: Result<(NowPlaying), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let nowPlaying):
                self.nowPlayingData = [nowPlaying]
            case .failure(let error):
                self.onError?(error)
            }
        }
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .genre) { [weak self] (response: Result<(Genre), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let genre):
                self.genreData = [genre]
            case .failure(let error):
                self.onError?(error)
            }
        }
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .trending) { [weak self] (response: Result<(Trending), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let trending):
                self.trendingData = [trending]
            case .failure(let error):
                self.onError?(error)
            }
        }
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .topRated) { [weak self] (response: Result<(TopRated), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let rated):
                self.topData = [rated]
            case .failure(let error):
                self.onError?(error)
            }
        }
        
        group.notify(queue: .main) {
            self.onDataUpdate?()
        }
    }
}

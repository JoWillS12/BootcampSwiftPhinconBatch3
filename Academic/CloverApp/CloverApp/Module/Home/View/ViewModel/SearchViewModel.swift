//
//  SearchViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import Foundation

class SearchViewModel {
    var movieData: [Movie] = []
    var genre: [Genre] = []
    var onDataUpdate: (() -> Void)?
    var isFetchingData = false
    var currentPage = 1
    
    func fetchData(completion: @escaping () -> Void) {
        fetchMovieData {
            self.fetchGenreData {
                self.onDataUpdate?()
                completion()
            }
        }
    }
    
    func fetchMovieData(completion: @escaping () -> Void) {
        guard !isFetchingData else { return }
        isFetchingData = true
        
        fetchPage(page: currentPage) { [weak self] in
            self?.onDataUpdate?()
            completion()
            self?.isFetchingData = false
        }
    }
    
    func fetchPage(page: Int, completion: @escaping () -> Void) {
        NetworkManager.shared.makeAPICall(endpoint: .movieList(page: page)) { [weak self] (response: Result<(Movie), Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let movie):
                print("Movie API Response: \(movie)")
                self.movieData.append(movie)
                self.currentPage += 1
                completion()
            case .failure(let error):
                print("Movie API Request Error: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func fetchGenreData(completion: @escaping () -> Void) {
        NetworkManager.shared.makeAPICall(endpoint: .genre) { [weak self] (response: Result<(Genre), Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let genre):
                self.genre = [genre]
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
            }
            completion()
        }
    }
}

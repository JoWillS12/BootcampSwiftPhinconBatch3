//
//  SearchViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import Foundation

class SearchViewModel {
    var genre: [Genre] = []
    var movies: [MovieResult] = []
    var currentPage = 1
    var totalPages = 1
    var isFetching = false
    
    // Callbacks for UI updates
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchMovies() {
        guard currentPage <= totalPages else { return }

        NetworkManager.shared.makeAPICall(endpoint: .movieList(page: currentPage)) { [weak self] (result: Result<Movie, Error>) in
            guard let self = self else { return }

            self.isFetching = false
            switch result {
            case .success(let movieResponse):
                self.movies.append(contentsOf: movieResponse.results)
                self.currentPage += 1

                // Check if there are more pages to fetch
                if self.currentPage <= self.totalPages {
                    // Fetch movies for the next page
                    self.fetchMovies()
                } else {
                    // Notify UI that all movies are fetched
                    self.onDataUpdate?()
                }
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }
    
    func movie(at index: Int) -> MovieResult {
        return movies[index]
    }
    
    func fetchNextPage() {
        guard !isFetching else { return }
        
        isFetching = true
        NetworkManager.shared.makeAPICall(endpoint: .movieList(page: currentPage)) { [weak self] (result: Result<Movie, Error>) in
            guard let self = self else { return }

            self.isFetching = false
            switch result {
            case .success(let movieResponse):
                self.movies.append(contentsOf: movieResponse.results)
                self.currentPage += 1
                self.onDataUpdate?()
            case .failure(let error):
                self.onError?(error)
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

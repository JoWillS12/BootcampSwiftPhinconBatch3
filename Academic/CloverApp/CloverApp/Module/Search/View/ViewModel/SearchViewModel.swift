//
//  SearchViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import Foundation

class SearchViewModel{
    
    var movieData: [Movie] = []
    var genre: [Genre] = []
    var onDataUpdate: (() -> Void)?
    
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.makeAPICall(endpoint: .movieList) { [weak self] (response: Result<(Movie), Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let list):
                self.movieData = [list]
                self.onDataUpdate?()
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .genre) { [weak self] (response: Result<(Genre), Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let genre):
                self.genre = [genre]
                self.onDataUpdate?()
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

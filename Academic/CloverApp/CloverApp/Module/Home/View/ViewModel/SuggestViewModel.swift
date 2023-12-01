//
//  DescViewModel.swift
//  C
//
//  Created by Joseph William Santoso on 01/12/23.
//

import Foundation

class SuggestViewModel{
    
    var popularData: [Popular] = []
    var onDataUpdate: (() -> Void)?
    
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.makeAPICall(endpoint: .popular) { [weak self] (response: Result<(Popular), Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let pop):
                self.popularData = [pop]
                self.onDataUpdate?()
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

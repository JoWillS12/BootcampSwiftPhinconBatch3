//
//  SuggestViewController.swift
//  C
//
//  Created by Joseph William Santoso on 29/11/23.
//

import UIKit

class SuggestViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var topData: [TopRated] = []
    var tvTopData: [TvTopRated] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        registerCollectionCell()
        fetchData()
    }
        
    
    func registerCollectionCell(){
        collectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .tvTopRated) { [weak self] (response: Result<(TvTopRated), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let tvTop):
                self.tvTopData = [tvTop]
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
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
                print("Genre API Request Error: \(error.localizedDescription)")
            }
        }
        
        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
}

extension SuggestViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topData.count + tvTopData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        guard topData.count > 0, tvTopData.count > 0  else {
            return cell
        }
        let datas = topData[0].results[indexPath.row]
        let data = tvTopData[0].results[indexPath.row]
        // Check if the current cell is at an even or odd index
        if indexPath.item % 2 == 0 {
            // Even index, display data from tvTopData
            let tvTopIndex = indexPath.item / 2
            if tvTopIndex < tvTopData.count {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                    cell.movieImage.kf.setImage(with: imageURL)
                }
            }
        } else {
            // Odd index, display data from topData
            let topIndex = (indexPath.item - 1) / 2
            if topIndex < topData.count {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (data.posterPath)) {
                    cell.movieImage.kf.setImage(with: imageURL)
                }
            }
        }
        return cell
    }
}

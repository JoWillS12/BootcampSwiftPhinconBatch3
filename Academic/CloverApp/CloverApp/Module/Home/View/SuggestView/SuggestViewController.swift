//
//  SuggestViewController.swift
//  C
//
//  Created by Joseph William Santoso on 29/11/23.
//

import UIKit
import Parchment

class SuggestViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var popularData: [Popular] = []
    let index: Int
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        NetworkManager.shared.makeAPICall(endpoint: .popular) { [weak self] (response: Result<(Popular), Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let pop):
                self.popularData = [pop]
                self.collectionView.reloadData()
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

extension SuggestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularData.count > 0 ? popularData[0].results.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        guard popularData.count > 0 else {
            return cell
        }
        let datas = popularData[0].results[indexPath.row]
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
            cell.movieImage.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Set the section inset (adjust as needed)
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}

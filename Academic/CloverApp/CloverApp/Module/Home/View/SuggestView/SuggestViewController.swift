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
    
    var vm = SuggestViewModel()
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
        vm.onDataUpdate = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        vm.fetchData { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

extension SuggestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.popularData.count > 0 ? vm.popularData[0].results.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        guard vm.popularData.count > 0 else {
            return cell
        }
        let datas = vm.popularData[0].results[indexPath.row]
        if let imageURL = URLstore.imagesURL?.appendingPathComponent(datas.posterPath ?? "") {
            cell.movieImage.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Set the section inset (adjust as needed)
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
}

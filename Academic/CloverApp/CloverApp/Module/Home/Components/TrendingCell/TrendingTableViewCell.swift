//
//  TrendingTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit
import SkeletonView

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var seeDesc: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: MovieCellDelegate?
    var trendingData: [Trending] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var topData: [TopRated] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var upData: [Upcoming] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var currentDataType: DataType = .trending {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
        let padding: CGFloat = 10.0
        contentView.frame = bounds.inset(by: UIEdgeInsets(top: 20, left: 0, bottom: padding, right: 0))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(seeDescTapped))
        seeDesc.isUserInteractionEnabled = true
        seeDesc.addGestureRecognizer(tapGesture)
        sectionTitle.showAnimatedGradientSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func seeDescTapped() {
        // Handle tap on seeDesc label
        delegate?.seeDescTapped(dataType: currentDataType)
    }
    
    func registerCollectionCell(){
        collectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showAnimatedGradientSkeleton()
    }
}
extension TrendingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentDataType {
        case .trending:
            return trendingData.count > 0 ? trendingData[0].results.count : 0
        case .topRated:
            return topData.count > 0 ? topData[0].results.count : 0
        case .upcoming:
            return upData.count > 0 ? upData[0].results.count : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath)as! MovieCollectionViewCell
        switch currentDataType {
        case .trending:
            guard trendingData.count > 0 else {
                return cell
            }
            let datas = trendingData[0].results[indexPath.row]
            if let imageURL = URLstore.imagesURL?.appendingPathComponent(datas.posterPath ?? "") {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            sectionTitle.text = "Trending"
            break
        case .topRated:
            guard topData.count > 0 else {
                return cell
            }
            let datas = topData[0].results[indexPath.row]
            if let imageURL = URLstore.imagesURL?.appendingPathComponent(datas.posterPath ?? "") {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            sectionTitle.text = "Top Rated"
            break
        case .upcoming:
            guard upData.count > 0 else {
                return cell
            }
            let datas = upData[0].results[indexPath.row]
            if let imageURL = URLstore.imagesURL?.appendingPathComponent(datas.posterPath ?? "") {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            sectionTitle.text = "Upcoming"
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentDataType {
        case .trending:
            guard let data = trendingData.first?.results[indexPath.row] as? TrendingResult else { return }
            delegate?.didSelectItem(data: data)
        case .topRated:
            guard let data = topData.first?.results[indexPath.row] as? TopResult else { return }
            delegate?.didSelectItem(data: data)
        case .upcoming:
            guard let data = upData.first?.results[indexPath.row] as? UpcomingResult else { return }
            delegate?.didSelectItem(data: data)
        }
    }
}



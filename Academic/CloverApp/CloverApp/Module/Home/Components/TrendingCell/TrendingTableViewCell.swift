//
//  TrendingTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit

protocol TrendingCellDelegate: AnyObject {
    func didSelectItem<T: Codable>(data: T)
}

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var seeDesc: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: TrendingCellDelegate?
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
    var nowData: [NowPlaying] = [] {
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
        // Initialization code
        registerCollectionCell()
        let padding: CGFloat = 10.0
        contentView.frame = bounds.inset(by: UIEdgeInsets(top: 20, left: 0, bottom: padding, right: 0))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func registerCollectionCell(){
        collectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
extension TrendingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentDataType {
        case .trending:
            return trendingData.count > 0 ? trendingData[0].results.count : 0
        case .topRated:
            return topData.count > 0 ? topData[0].results.count : 0
        case .nowPlaying:
            return nowData.count > 0 ? nowData[0].results.count : 0
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
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            sectionTitle.text = "Trending"
            break
        case .topRated:
            guard topData.count > 0 else {
                return cell
            }
            let datas = topData[0].results[indexPath.row]
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            sectionTitle.text = "Top Rated"
            break
        case .nowPlaying:
            guard nowData.count > 0 else {
                return cell
            }
            let datas = nowData[0].results[indexPath.row]
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            sectionTitle.text = "Now Playing"
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
        case .nowPlaying:
            guard let data = nowData.first?.results[indexPath.row] as? PlayingResult else { return }
            delegate?.didSelectItem(data: data)
        }
    }
}

enum DataType {
    case trending
    case topRated
    case nowPlaying
}

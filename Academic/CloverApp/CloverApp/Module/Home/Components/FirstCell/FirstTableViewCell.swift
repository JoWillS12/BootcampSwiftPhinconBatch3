//
//  FirstTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 28/11/23.
//

import UIKit
import Kingfisher

class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonAddList: RoundView!
    @IBOutlet weak var buttonPlay: RoundView!
    @IBOutlet weak var filmGenre: UILabel!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descBox: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var nowPlayingData: [NowPlaying] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var genreData: [Genre] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUp()
        registerCollectionCell()
        startTimer()
        configurePageControl()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Make contentView fill the cell's bounds
        contentView.frame = bounds
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func pageClicked(_ sender: Any) {
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    func setUp(){
        buttonPlay.borderColor = UIColor.black
        buttonPlay.backgroundColorOverride = UIColor.clear
        buttonPlay.textColor = UIColor.black
        buttonPlay.buttonImage.image = UIImage(systemName: "play.fill")
        buttonPlay.tintColor = UIColor.black
        buttonPlay.buttonName.text = "Play"
        
        buttonAddList.borderColor = UIColor.black
        buttonAddList.backgroundColorOverride = UIColor.clear
        buttonAddList.textColor = UIColor.black
        buttonAddList.buttonImage.image = UIImage(systemName: "plus")
        buttonAddList.tintColor = UIColor.black
        buttonAddList.buttonName.text = "My List"
        
        descBox.setDiagonalLinearGradientWithCornerRadius(colors: [UIColor.white, UIColor.gray, UIColor.black], startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0), cornerRadius: 20)
        descBox.layer.opacity = 0.9
        
        if let firstData = nowPlayingData.first?.results.first {
            filmName.text = firstData.originalTitle
            let movieGenres = mapGenreIDsToNames(genreIDs: firstData.genreIDS, genreData: genreData.first?.genres ?? [])
            filmGenre.text = movieGenres.joined(separator: ", ")
        }
        
        filmName.numberOfLines = 0
        filmName.lineBreakMode = .byWordWrapping
        filmGenre.numberOfLines = 0
        filmGenre.lineBreakMode = .byWordWrapping
    }
    
    func registerCollectionCell(){
        collectionView.register(UINib.init(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func mapGenreIDsToNames(genreIDs: [Int], genreData: [GenreElement]) -> [String] {
        var genreNames: [String] = []
        
        for genreID in genreIDs {
            if let genre = genreData.first(where: { $0.id == genreID }) {
                genreNames.append(genre.name)
            }
        }
        return genreNames
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    func configurePageControl() {
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.sizeToFit()
    }
    
    @objc func timerFired() {
        guard nowPlayingData.count > 0 else {
            // Handle the case where mapData is empty
            return
        }
        
        let nextPage = (pageControl.currentPage + 1) % nowPlayingData[0].results.count
        let indexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = nextPage
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension FirstTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = nowPlayingData.count > 0 ? nowPlayingData[0].results.count : 0
        return nowPlayingData.count > 0 ? nowPlayingData[0].results.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        guard nowPlayingData.count > 0 ,
              genreData.count > 0 else {
            return cell
        }
        let datas = nowPlayingData[0].results[indexPath.row]
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
            cell.filmImage.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
        // Stop the timer to prevent interference with manual scrolling
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visibleCells = collectionView.visibleCells
        for cell in visibleCells {
            if let indexPath = collectionView.indexPath(for: cell) {
                let data = nowPlayingData[0].results[indexPath.row]
                filmName.text = data.originalTitle
                let movieGenres = mapGenreIDsToNames(genreIDs: data.genreIDS, genreData: genreData[0].genres)
                filmGenre.text = movieGenres.joined(separator: ", ")
            }
        }
        
        timer?.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView.scrollToNearestVisibleCollectionViewCell()
            // Restart the timer after manual scrolling ends
            startTimer()
        }
    }
}





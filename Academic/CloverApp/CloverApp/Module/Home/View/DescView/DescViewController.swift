//
//  DescViewController.swift
//  C
//
//  Created by Joseph William Santoso on 29/11/23.
//

import UIKit

class DescViewController: UIViewController {
    
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmGenre: UILabel!
    @IBOutlet weak var downloadButton: RoundView!
    @IBOutlet weak var playButton: RoundView!
    @IBOutlet weak var filmAge: UILabel!
    @IBOutlet weak var filmRating: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var parchmentView: UIView!
    @IBOutlet weak var filmSynopsis: UILabel!
    
    var selectedTrending: TrendingResult?
    var selectedTopRated: TopResult?
    var selectedTvTopRated: TvResult?
    var selectedNowPlaying: PlayingResult?
    var selectedGenre: Genre?
    var typeData: DataType = .trending
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        filmAge.layer.borderWidth = 1
        filmAge.layer.borderColor = UIColor.gray.cgColor
        filmAge.layer.cornerRadius = 10
        subLabel.layer.borderWidth = 1
        subLabel.layer.borderColor = UIColor.gray.cgColor
        subLabel.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        switch typeData {
        case .trending:
            if let item = selectedTrending {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (item.posterPath)) {
                    filmImage.kf.setImage(with: imageURL)
                }
                filmName.text = item.title
                filmRating.text = "\(item.popularity) > \(getYear(from: item.releaseDate))"
                filmSynopsis.text = item.overview
            }
            break
        case .topRated:
            if let item = selectedTopRated {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (item.posterPath)) {
                    filmImage.kf.setImage(with: imageURL)
                }
                filmName.text = item.title
                filmRating.text = "\(item.popularity) > \(getYear(from: item.releaseDate))"
                filmSynopsis.text = item.overview
            }
        case .nowPlaying:
            if let item = selectedNowPlaying {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (item.posterPath)) {
                    filmImage.kf.setImage(with: imageURL)
                }
                filmName.text = item.title
                filmRating.text = "\(item.popularity) > \(getYear(from: item.releaseDate))"
                filmSynopsis.text = item.overview
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func getYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the format based on your API response date format

        if let date = dateFormatter.date(from: dateString) {
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            return yearFormatter.string(from: date)
        }

        return ""
    }
}

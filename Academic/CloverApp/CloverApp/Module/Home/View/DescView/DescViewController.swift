//
//  DescViewController.swift
//  C
//
//  Created by Joseph William Santoso on 29/11/23.
//

import UIKit
import Parchment
import Firebase
import AVKit

class DescViewController: UIViewController {
    
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmGenre: UILabel!
    @IBOutlet weak var downloadButton: BigRoundedView!
    @IBOutlet weak var playButton: BigRoundedView!
    @IBOutlet weak var filmAge: UILabel!
    @IBOutlet weak var filmRating: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var parchmentView: UIView!
    @IBOutlet weak var filmSynopsis: UILabel!
    
    var selectedTrending: TrendingResult?
    var selectedTopRated: TopResult?
    var selectedUpcoming: UpcomingResult?
    var selectedGenre: [Genre] = []
    var typeData: DataType = .trending
    let maximumNumberOfLines: Int = 3
    var isExpanded: Bool = false
    var selectedMovieId: Int = 0
    var selectedDate: String = ""
    var selectedPosterPath: String = ""
    var vm = HalfViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setUpPagingVC()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch typeData {
        case .trending:
            if let item = selectedTrending {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (item.posterPath)) {
                    filmImage.kf.setImage(with: imageURL)
                    selectedPosterPath = "\(imageURL)"
                }
                selectedMovieId = item.id
                selectedDate = getYear(from: item.releaseDate)
                filmName.text = item.title
                filmRating.text = "\(item.popularity) > \(getYear(from: item.releaseDate))"
                filmSynopsis.text = item.overview
                let movieGenres = mapGenreIDsToNames(genreIDs: item.genreIDS, genreData: selectedGenre.first?.genres ?? [])
                filmGenre.text = "Genre : \(movieGenres.joined(separator: ", "))"
            }
            break
        case .topRated:
            if let item = selectedTopRated {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (item.posterPath)) {
                    filmImage.kf.setImage(with: imageURL)
                    selectedPosterPath = "\(imageURL)"
                }
                selectedMovieId = item.id
                selectedDate = getYear(from: item.releaseDate)
                filmName.text = item.title
                filmRating.text = "\(item.popularity) > \(getYear(from: item.releaseDate))"
                filmSynopsis.text = item.overview
                let movieGenres = mapGenreIDsToNames(genreIDs: item.genreIDS, genreData: selectedGenre.first?.genres ?? [])
                filmGenre.text = "Genre : \(movieGenres.joined(separator: ", "))"
            }
        case .upcoming:
            if let item = selectedUpcoming {
                if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (item.posterPath)) {
                    filmImage.kf.setImage(with: imageURL)
                    selectedPosterPath = "\(imageURL)"
                }
                selectedMovieId = item.id
                selectedDate = "\(getYear(from: item.releaseDate))"
                filmName.text = item.title
                filmRating.text = "\(item.popularity) > \(getYear(from: item.releaseDate))"
                filmSynopsis.text = item.overview
                let movieGenres = mapGenreIDsToNames(genreIDs: item.genreIDS, genreData: selectedGenre.first?.genres ?? [])
                filmGenre.text = "Genre : \(movieGenres.joined(separator: ", "))"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listenedNotification()
    }
    
    func listenedNotification(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDataNotification(_:)),
            name: NSNotification.Name("DataNotification"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDownloadNotification(_:)),
            name: NSNotification.Name("DownloadNotification"),
            object: nil
        )
    }
    
    @objc func handleDataNotification(_ notification: Notification) {
        // Retrieve data from the notification
        if let data = notification.userInfo?["data"] as? Bool, data {
            print("Received data: \(data)")
            
            navigationController?.dismiss(animated: true, completion: {
                let vc = PopUpViewController()
                self.navigationController?.present(vc, animated: true)
            })
        }
    }
    
    @objc func handleDownloadNotification(_ notification: Notification) {
        // Retrieve data from the notification
        if let data = notification.userInfo?["data"] as? Bool, data {
            print("Received data: \(data)")
            vm.downloadMovie(movieId: selectedMovieId, movieName: filmName.text ?? "", moviePic: selectedPosterPath, movieGenre: filmGenre.text ?? "", movieYear: selectedDate) { error in
                if let error = error {
                    print("Error download movie: \(error.localizedDescription)")
                } else {
                    print("Movie download successfully!")
                    self.showAlert(message: "Movie Downloaded.")
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.setViewControllers([TabBarViewController()], animated: false)
    }
    
    func setUp(){
        // Add tap gesture to the label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        filmSynopsis.addGestureRecognizer(tapGesture)
        filmSynopsis.isUserInteractionEnabled = true
        
        // Add "Read More" link to the label
        addReadMoreLink()
        
        filmAge.layer.borderWidth = 1
        filmAge.layer.borderColor = UIColor.gray.cgColor
        filmAge.layer.cornerRadius = 10
        subLabel.layer.borderWidth = 1
        subLabel.layer.borderColor = UIColor.gray.cgColor
        subLabel.layer.cornerRadius = 10
        
        playButton.borderColor = UIColor.gray
        playButton.backgroundColor = UIColor.gray
        playButton.textColor = UIColor.white
        playButton.buttonImage.image = UIImage(systemName: "play.fill")
        playButton.tintColor = UIColor.white
        playButton.buttonName.text = "Play"
        playButton.tapAction = {[weak self] in
            self?.showVideo()
            print("tapped!")
        }
        
        downloadButton.borderColor = UIColor.gray
        downloadButton.backgroundColor = UIColor.clear
        downloadButton.textColor = UIColor.gray
        downloadButton.buttonImage.image = UIImage(systemName: "square.and.arrow.down")
        downloadButton.tintColor = UIColor.gray
        downloadButton.buttonName.text = "Download"
        downloadButton.tapAction = {[weak self] in
            let contentVc = HalfViewController()
            // Pass data to HalfViewController
            contentVc.movieNameText = self?.filmName.text
            contentVc.movieImagePic = self?.filmImage.image
            contentVc.modalPresentationStyle = .custom
            contentVc.transitioningDelegate = self
            self?.showHalfModal(contentVc)
        }
    }
    
    @objc func labelTapped() {
        isExpanded.toggle()
        
        if isExpanded {
            filmSynopsis.numberOfLines = 0 // Show all lines
        } else {
            filmSynopsis.numberOfLines = maximumNumberOfLines
        }
    }
    
    func showHalfModal(_ contentVc: UIViewController) {
        
        present(contentVc, animated: true, completion: nil)
        
        // Add swipe down gesture for dismissal
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissHalfModal))
        swipeDown.direction = .down
        contentVc.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func dismissHalfModal()  {
        dismiss(animated: true, completion: nil)
    }
    
    func showVideo(){
        guard let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/movie-eead1.appspot.com/o/jump%20scare%20videos%20-%20jumpscare%20-%20scare%20videos%20%23shorts.mp4?alt=media&token=817a2ff6-7589-43fc-a462-c2340edd4a90") else {
            // Handle invalid URL
            print("Not this link!")
            return
        }
        
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    func addReadMoreLink() {
        let readMoreText = "... Read More"
        let attributedString = NSMutableAttributedString(string: filmSynopsis.text ?? "")
        let range = (filmSynopsis.text as NSString?)?.range(of: readMoreText)
        
        if let range = range {
            let readMoreLinkAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            attributedString.addAttributes(readMoreLinkAttributes, range: range)
        }
        
        filmSynopsis.attributedText = attributedString
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
    
    func mapGenreIDsToNames(genreIDs: [Int], genreData: [GenreElement]) -> [String] {
        var genreNames: [String] = []
        
        for genreID in genreIDs {
            if let genre = genreData.first(where: { $0.id == genreID }) {
                genreNames.append(genre.name)
            }
        }
        return genreNames
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func setUpPagingVC(){
        let firstVC = SuggestViewController(index: 0)
        let pagingVC = PagingViewController(viewControllers: [firstVC])
        pagingVC.dataSource = self
        pagingVC.delegate = self
        pagingVC.menuItemSize = .selfSizing(estimatedWidth: 180, height: 40)
        pagingVC.menuItemSpacing = 20
        
        addChild(pagingVC)
        parchmentView.addSubview(pagingVC.view)
        
        // Set constraints to make the pagingVC.view fill the slidingTabs view
        pagingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingVC.view.topAnchor.constraint(equalTo: parchmentView.topAnchor),
            pagingVC.view.leadingAnchor.constraint(equalTo: parchmentView.leadingAnchor),
            pagingVC.view.trailingAnchor.constraint(equalTo: parchmentView.trailingAnchor),
            pagingVC.view.bottomAnchor.constraint(equalTo: parchmentView.bottomAnchor)
        ])
        
        pagingVC.didMove(toParent: self)
        
        pagingVC.selectedTextColor = UIColor.white
        pagingVC.indicatorColor = UIColor.white
        pagingVC.textColor = UIColor.gray
        pagingVC.menuBackgroundColor = UIColor.clear
        pagingVC.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        pagingVC.selectedFont = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
    }
}

extension DescViewController: PagingViewControllerDelegate, PagingViewControllerDataSource{
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        return ParchmentTabs.allCases.count
    }
    
    func pagingViewController(_ pagingViewController: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        
        guard let tab = ParchmentTabs(rawValue: index) else {
            fatalError("Invalid index for view controller")
        }
        switch tab {
        case .Suggest:
            return SuggestViewController(index: index)
        case .Comments:
            return CommentsViewController(
                index: index,
                selectedMovieID: getSelectedMovieID())
        }
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        guard let tab = ParchmentTabs(rawValue: index) else {
            fatalError("Invalid index for paging item")
        }
        
        switch tab {
        case .Suggest:
            return PagingIndexItem(index: index, title: "Popular Now")
        case .Comments:
            return PagingIndexItem(index: index, title: "Comments")
        }
    }
    
    private func getSelectedMovieID() -> Int? {
            switch typeData {
            case .trending:
                return selectedTrending?.id
            case .topRated:
                return selectedTopRated?.id
            case .upcoming:
                return selectedUpcoming?.id
            }
        }
}

extension DescViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

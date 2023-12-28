//
//  HomeViewController.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit
import SkeletonView
import AVKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vm = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listenedNotification()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        print("tapped")
    }
    
    func setUp(){
        registerTableCell()
        fetchData()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func listenedNotification(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleButtonNotification(_:)),
            name: NSNotification.Name("ButtonNotification"),
            object: nil
        )
    }
    
    @objc func handleButtonNotification(_ notification: Notification) {
        // Retrieve data from the notification
        if let data = notification.userInfo?["data"] as? Bool, data {
            print("Received data: \(data)")
            
            self.showAlertSuccess(message: "Added to bookmark.")
        }
    }
    
    func registerTableCell(){
        tableView.showAnimatedGradientSkeleton()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: FirstTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: FirstTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: TrendingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TrendingTableViewCell.self))
    }
    
    func fetchData() {
        vm.onError = {[weak self] error in
            print("Error : \(error)")
        }
        
        vm.onDataUpdate = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        vm.fetchData { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showVideo(){
        guard let videoURL = URLstore.videosURL else {
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
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FilmType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = FilmType(rawValue: indexPath.section)
        switch section {
        case .recomendation:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            
            cell.nowPlayingData = vm.nowPlayingData
            cell.genreData = vm.genreData
            cell.contentView.clipsToBounds = false
            cell.selectionStyle = .none
            cell.buttonPlay.tapAction = {[weak self] in
                self?.showVideo()
            }
            return cell
        case .trending, .topRated, .upcoming:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            configureCellForSection(cell, section: section)
            return cell
        default:
            return UITableViewCell()
        }
        
        func configureCellForSection(_ cell: TrendingTableViewCell, section: FilmType?) {
            cell.contentView.clipsToBounds = false
            cell.selectionStyle = .none
            cell.delegate = self
            switch section {
            case .trending:
                cell.trendingData = vm.trendingData
                cell.currentDataType = .trending
            case .topRated:
                cell.topData = vm.topData
                cell.currentDataType = .topRated
            case .upcoming:
                cell.upData = vm.upcomingData
                cell.currentDataType = .upcoming
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = FilmType(rawValue: indexPath.section)
        switch section {
        case .recomendation:
            return 430
        default:
            return 300
        }
    }
}

extension HomeViewController: MovieCellDelegate{
    func didSelectItem<T>(data: T) where T : Codable {
        if data is UpcomingResult {
            let vc = DescViewController()
            vc.selectedUpcoming = data as? UpcomingResult
            vc.typeData = .upcoming
            vc.selectedGenre = vm.genreData
            navigationController?.pushViewController(vc, animated: true)
        } else if data is TopResult {
            let vc = DescViewController()
            vc.typeData = .topRated
            vc.selectedTopRated = data as? TopResult
            vc.selectedGenre = vm.genreData
            navigationController?.pushViewController(vc, animated: true)
        } else if data is TrendingResult {
            let vc = DescViewController()
            vc.typeData = .trending
            vc.selectedTrending = data as? TrendingResult
            vc.selectedGenre = vm.genreData
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func seeDescTapped(dataType: DataType) {
        let groupDescVC = GroupDescViewController()
        groupDescVC.currentDataType = dataType
        
        switch dataType {
        case .trending:
            groupDescVC.trendingData = vm.trendingData.flatMap { $0.results }
        case .topRated:
            groupDescVC.topData = vm.topData.flatMap { $0.results }
        case .upcoming:
            groupDescVC.upData = vm.upcomingData.flatMap { $0.results }
        }
        
        groupDescVC.selectedGenre = vm.genreData
        navigationController?.pushViewController(groupDescVC, animated: true)
    }
}


//
//  HomeViewController.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nowPlayingData: [NowPlaying] = []
    var genreData: [Genre] = []
    var trendingData: [Trending] = []
    var topData: [TopRated] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        fetchData()
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: FirstTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: FirstTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: TrendingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TrendingTableViewCell.self))
    }
    
    func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .nowPlaying) { [weak self] (response: Result<(NowPlaying), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let nowPlaying):
                self.nowPlayingData = [nowPlaying]
            case .failure(let error):
                print("Now Playing API Request Error: \(error.localizedDescription)")
            }
        }
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .genre) { [weak self] (response: Result<(Genre), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let genre):
                self.genreData = [genre]
            case .failure(let error):
                print("Genre API Request Error: \(error.localizedDescription)")
            }
        }
        
        group.enter()
        NetworkManager.shared.makeAPICall(endpoint: .trending) { [weak self] (response: Result<(Trending), Error>) in
            guard let self = self else { return }
            defer { group.leave() }
            switch response {
            case .success(let trending):
                self.trendingData = [trending]
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
            self.tableView.reloadData()
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, TrendingCellDelegate{
    
    func didSelectItem<T>(data: T) where T : Codable {
        if data is PlayingResult {
            let vc = DescViewController()
            vc.selectedNowPlaying = data as? PlayingResult
            vc.typeData = .nowPlaying
            navigationController?.pushViewController(vc, animated: true)
        } else if data is TopResult {
            let vc = DescViewController()
            vc.typeData = .topRated
            vc.selectedTopRated = data as? TopResult
            navigationController?.pushViewController(vc, animated: true)
        } else if data is TrendingResult {
            let vc = DescViewController()
            vc.typeData = .trending
            vc.selectedTrending = data as? TrendingResult
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
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
            cell.nowPlayingData = nowPlayingData
            cell.genreData = genreData
            cell.contentView.clipsToBounds = false
            cell.selectionStyle = .none
            return cell
        case .trending:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            cell.contentView.clipsToBounds = false
            cell.delegate = self
            cell.trendingData = trendingData
            cell.currentDataType = .trending
            cell.selectionStyle = .none
            return cell
        case .topRated:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            cell.contentView.clipsToBounds = false
            cell.delegate = self
            cell.topData = topData
            cell.currentDataType = .topRated
            cell.selectionStyle = .none
            return cell
        case .nowPlaying:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            cell.contentView.clipsToBounds = false
            cell.delegate = self
            cell.nowData = nowPlayingData
            cell.currentDataType = .nowPlaying
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
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

enum FilmType: Int, CaseIterable {
    case recomendation
    case trending
    case topRated
    case nowPlaying
}

//
//  HomeViewController.swift
//  C
//
//  Created by Joseph William Santoso on 27/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vm = HomeViewModel()
    
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
        
        vm.onDataUpdate = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        vm.fetchData { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, TrendingCellDelegate{
    
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
            return cell
        case .trending:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            cell.contentView.clipsToBounds = false
            cell.delegate = self
            cell.trendingData = vm.trendingData
            cell.currentDataType = .trending
            cell.selectionStyle = .none
            return cell
        case .topRated:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            cell.contentView.clipsToBounds = false
            cell.delegate = self
            cell.topData = vm.topData
            cell.currentDataType = .topRated
            cell.selectionStyle = .none
            return cell
        case .upcoming:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            cell.contentView.clipsToBounds = false
            cell.delegate = self
            cell.upData = vm.upcomingData
            cell.currentDataType = .upcoming
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



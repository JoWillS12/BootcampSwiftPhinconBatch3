//
//  GroupDescViewController.swift
//  C
//
//  Created by Joseph William Santoso on 01/12/23.
//

import UIKit

class GroupDescViewController: UIViewController {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var trendingData: [TrendingResult] = []
    var topData: [TopResult] = []
    var upData: [UpcomingResult] = []
    var selectedGenre: [Genre] = []
    var currentDataType: DataType = .trending
    
    var vm = GroupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerTableCell()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
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
}
extension GroupDescViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentDataType {
        case .trending:
            return trendingData.count > 0 ? trendingData.count : 0
        case .topRated:
            return topData.count > 0 ? topData.count : 0
        case .upcoming:
            return upData.count > 0 ? upData.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        switch currentDataType {
        case .trending:
            guard trendingData.count > 0 else {
                return cell
            }
            let datas = trendingData[indexPath.row]
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            cell.movieName.text = datas.title
            let movieGenres = mapGenreIDsToNames(genreIDs: datas.genreIDS, genreData: selectedGenre.first?.genres ?? [])
            cell.movieGenre.text = "Genre : \(movieGenres.joined(separator: ", "))"
            cell.movieDate.text = "\(getYear(from: datas.releaseDate))"
            cell.customButton.tapAction = {[weak self] in
                self?.vm.addBookmark(movieId: datas.id, movieName: datas.title, moviePic: datas.posterPath){ error in
                    if let error = error {
                        print("Error saving movie: \(error.localizedDescription)")
                    } else {
                        print("Movie saved successfully!")
                        self?.showAlert(message: "Added to bookmark.")
                    }
                }
            }
            groupTitle.text = "Trending"
            break
        case .topRated:
            guard topData.count > 0 else {
                return cell
            }
            let datas = topData[indexPath.row]
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            cell.movieName.text = datas.title
            let movieGenres = mapGenreIDsToNames(genreIDs: datas.genreIDS, genreData: selectedGenre.first?.genres ?? [])
            cell.movieGenre.text = "Genre : \(movieGenres.joined(separator: ", "))"
            cell.movieDate.text = "\(getYear(from: datas.releaseDate))"
            cell.customButton.tapAction = {[weak self] in
                self?.vm.addBookmark(movieId: datas.id, movieName: datas.title, moviePic: datas.posterPath){ error in
                    if let error = error {
                        print("Error saving movie: \(error.localizedDescription)")
                    } else {
                        print("Movie saved successfully!")
                        self?.showAlert(message: "Added to bookmark.")
                    }
                }
            }
            groupTitle.text = "Top Rated"
            break
        case .upcoming:
            guard upData.count > 0 else {
                return cell
            }
            let datas = upData[indexPath.row]
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath)) {
                cell.movieImage.kf.setImage(with: imageURL)
            }
            cell.movieName.text = datas.title
            let movieGenres = mapGenreIDsToNames(genreIDs: datas.genreIDS, genreData: selectedGenre.first?.genres ?? [])
            cell.movieGenre.text = "Genre : \(movieGenres.joined(separator: ", "))"
            cell.movieDate.text = "\(getYear(from: datas.releaseDate))"
            cell.customButton.tapAction = {[weak self] in
                self?.vm.addBookmark(movieId: datas.id, movieName: datas.title, moviePic: datas.posterPath){ error in
                    if let error = error {
                        print("Error saving movie: \(error.localizedDescription)")
                    } else {
                        print("Movie saved successfully!")
                        self?.showAlert(message: "Added to bookmark.")
                    }
                }
            }
            groupTitle.text = "Upcoming"
            break
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
}

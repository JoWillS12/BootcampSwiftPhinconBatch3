//
//  SearchViewController.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    
    var vm = SearchViewModel()
    var filteredData: [MovieResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        fetchData()
        setUp()
        searchField.addTarget(self, action: #selector(searchFieldDidChange(_:)), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        searchField.delegate = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUp(){
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.gray.cgColor
        searchView.layer.cornerRadius = 20
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: GroupTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GroupTableViewCell.self))
    }
    
    func fetchData(){
        vm.onDataUpdate = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        vm.fetchData { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
    }
    
    @objc func searchFieldDidChange(_ textField: UITextField) {
        filterContentForSearchText(textField.text)
    }
    
    func filterContentForSearchText(_ searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            filteredData = []
            tableView.reloadData()
            return
        }
        
        filteredData = vm.movieData.flatMap { $0.results.filter { $0.title.lowercased().contains(searchText.lowercased()) } }
        tableView.reloadData()
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
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchField.text?.isEmpty == false ? filteredData.count : vm.movieData.count > 0 ? vm.movieData[0].results.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        let datas: MovieResult
        if searchField.text?.isEmpty == false {
            datas = filteredData[indexPath.row]
        } else {
            guard vm.movieData.count > 0 else { return cell }
            datas = vm.movieData[0].results[indexPath.row]
        }
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + datas.posterPath) {
            cell.movieImage.kf.setImage(with: imageURL)
        }
        cell.movieName.text = datas.title
        let movieGenres = mapGenreIDsToNames(genreIDs: datas.genreIDS, genreData: vm.genre.first?.genres ?? [])
        cell.movieGenre.text = "\(movieGenres.joined(separator: ", "))"
        cell.movieDate.text = "\(getYear(from: datas.releaseDate))"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
}

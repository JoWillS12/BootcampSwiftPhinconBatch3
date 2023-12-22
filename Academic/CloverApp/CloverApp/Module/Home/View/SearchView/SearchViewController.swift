//
//  SearchViewController.swift
//  C
//
//  Created by Joseph William Santoso on 04/12/23.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var toTopButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    
    var vm = SearchViewModel()
    var filteredData: [MovieResult] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableCell()
        fetchData()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func backToTop(_ sender: Any) {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func filterButton(_ sender: Any) {
        showHalfModal()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUp(){
        searchField.addTarget(self, action: #selector(searchFieldDidChange(_:)), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        searchField.delegate = self
        toTopButton.isHidden = false
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
    
    func fetchData() {
        vm.onDataUpdate = { [weak self] in
            self?.filteredData = self?.vm.movies ?? []
            self?.filterContentForSearchText(self?.searchField.text)
            self?.tableView.reloadData()
        }
        vm.onError = { [weak self] error in
            // Handle error
            print("Error fetching movies: \(error)")
        }
        vm.fetchGenreData { [weak self] in
            // Fetch movie data after genre data is fetched
            self?.vm.fetchMovies()
        }
    }
    
    @objc func searchFieldDidChange(_ textField: UITextField) {
        filterContentForSearchText(textField.text)
    }
    
    func filterContentForSearchText(_ searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else {
            filteredData = vm.movies
            tableView.reloadData()
            return
        }
        
        filteredData = vm.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
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
    
    func showHalfModal() {
        let contentVc = FilterViewController(nibName: "FilterViewController", bundle: nil)
        contentVc.modalPresentationStyle = .custom
        contentVc.transitioningDelegate = self
        present(contentVc, animated: true, completion: nil)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissHalfModal))
        swipeDown.direction = .down
        contentVc.view.addGestureRecognizer(swipeDown)
        
        contentVc.sortAz = {[weak self] in
            self?.sortMoviesAlphabetically()
            self?.searchTitle.text = "A - Z"
            self?.dismissHalfModal()
        }
        
        contentVc.sortYear = {[weak self] in
            self?.sortMoviesByYear()
            self?.searchTitle.text = "Year"
            self?.dismissHalfModal()
        }
    }
    
    @objc func dismissHalfModal() {
        dismiss(animated: true, completion: nil)
    }
    
    func sortMoviesAlphabetically() {
        filteredData = filteredData.sorted(by: \.title)
        print(filteredData)
        tableView.reloadData()
    }
    
    func sortMoviesByYear() {
        filteredData.sort { (movie1, movie2) in
            guard let year1 = Int(getYear(from: movie1.releaseDate)),
                  let year2 = Int(getYear(from: movie2.releaseDate)) else {
                return false
            }
            return year1 < year2
        }
        print(filteredData)
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchText = searchField.text, !searchText.isEmpty {
            return filteredData.count
        } else {
            return vm.numberOfMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        
        var datas: MovieResult
        
        if searchField.text?.isEmpty == false, indexPath.row < filteredData.count {
            datas = filteredData[indexPath.row]
        } else if indexPath.row < vm.movies.count {
//            datas = vm.movies[indexPath.row]
            datas = filteredData[indexPath.row]
        } else {
            // Handle the case where both filteredData is empty and vm.movies is out of bounds
            return cell
        }
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.posterPath ?? "")) {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == vm.numberOfMovies() - 1 {
            vm.fetchNextPage()
        }
    }
}

extension SearchViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting, slashBounds: 4)
    }
}

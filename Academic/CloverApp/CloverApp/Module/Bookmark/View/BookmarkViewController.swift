//
//  BookmarkViewController.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: MovieCellDelegate?
    var book: [Bookmark] = []
    var vm = BookmarkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerCollectionCell()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        collectionView.reloadData()
    }
    
    func registerCollectionCell(){
        collectionView.register(UINib.init(nibName: "BookmarkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookmarkCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchData(){
        vm.fetchBookmarks { [weak self] error in
            if let error = error {
                print("Error fetching bookmarks: \(error.localizedDescription)")
            } else {
                self?.book = self?.vm.bookmarks ?? []
                self?.collectionView.reloadData()
            }
        }
    }
}

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmarkCollectionViewCell", for: indexPath) as! BookmarkCollectionViewCell
        let datas = book[indexPath.row]
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + (datas.moviePic)) {
            cell.movieImage.kf.setImage(with: imageURL)
        }
        return cell
    }
}

//
//  BookmarkViewController.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit

class BookmarkViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: MovieCellDelegate?
    var book: [Bookmark] = []
    var vm = BookmarkViewModel()
    var selectedIndexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionCell()
        if traitCollection.forceTouchCapability == .available {
        }
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

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookmarkCollectionViewCell", for: indexPath) as! BookmarkCollectionViewCell
        let datas = book[indexPath.row]
        if let imageURL = URLstore.imagesURL?.appendingPathComponent(datas.moviePic){
            cell.movieImage.kf.setImage(with: imageURL)
        }
        
        return cell
    }
}

extension BookmarkViewController {
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { _ in
            // Handle the delete action here
            self.deleteItemAtIndexPath(at: indexPath)
        }

        let contextMenu = UIMenu(title: "", children: [deleteAction])

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return contextMenu
        }
    }
      
    func deleteItemAtIndexPath(at indexPath: IndexPath) {
            print("Deleting item at indexPath: \(indexPath)")
            
        let movieId = book[indexPath.row].movieId
            self.vm.deleteBookmark(movieId: movieId) { error in
                if let error = error {
                    print("Error deleting bookmark: \(error.localizedDescription)")
                } else {
                    self.book.remove(at: indexPath.row)
                    
                    // Perform collection view updates on the main thread
                    DispatchQueue.main.async {
                        self.collectionView.deleteItems(at: [indexPath])
                    }
                    
                    self.showAlertSuccess(message: "Deleted Successfully")
                }
            }
            selectedIndexPath = nil // Reset selectedIndexPath after deletion
        
    }

}


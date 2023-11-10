//
//  ActivityViewController.swift
//  Bike
//
//  Created by Joseph William Santoso on 01/11/23.
//

import UIKit
import RxCocoa
import RxRelay
import RxSwift

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var feeds: [Feeds] = []
    private let disposeBag = DisposeBag()
    private let coreDataManager = CoreDataManager()
    private var feedsRelay = BehaviorRelay<[Feeds]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        loadData()
    }
    
    func registerCell() {
        collectionView.register(UINib.init(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCell")
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    @IBAction func addActivity(_ sender: Any){
        let vc = AddActivityViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ActivityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 456 )
    }
    
    func loadData() {
        feeds = coreDataManager.getAllFeed()
        feedsRelay.accept(feeds)
        // Bind the data source to the collection view
        feedsRelay
            .bind(to: collectionView.rx.items(cellIdentifier: "ActivityCollectionViewCell", cellType: ActivityCollectionViewCell.self)) { _, feed, cell in
                cell.actImage.image = self.coreDataManager.getImageForFeed(feed: feed)
                cell.actUser.text = feed.ofUser?.actUser
                cell.actCaption.text = feed.actCaption
            }
            .disposed(by: disposeBag)
    }
}


//let itemsRelay = BehaviorRelay<[Activities]>(value: [Activities(actImage: "bike1", actUser: "Arthur", actCaption: "My New RIDE BROO !!", actStatus: true)])
// Bind the data source to the collection view
//        itemsRelay
//            .bind(to: collectionView.rx.items(cellIdentifier: "ActivityCollectionViewCell", cellType: ActivityCollectionViewCell.self)) { row, item, cell in
//                cell.actImage.image = UIImage(named: item.actImage)
//                cell.actUser.text = item.actUser
//                cell.actCaption.text = item.actCaption
//            }
//            .disposed(by: disposeBag)\

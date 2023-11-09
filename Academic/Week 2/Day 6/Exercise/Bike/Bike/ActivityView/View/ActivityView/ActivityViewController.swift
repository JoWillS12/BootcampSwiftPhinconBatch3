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
    
    let itemsRelay = BehaviorRelay<[Activities]>(value: [Activities(actImage: "bike1", actUser: "Arthur", actCaption: "My New RIDE BROO !!", actStatus: true)])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.init(nibName: "ActivityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ActivityCollectionViewCell")
        
        // Bind the data source to the collection view
        itemsRelay
            .bind(to: collectionView.rx.items(cellIdentifier: "ActivityCollectionViewCell", cellType: ActivityCollectionViewCell.self)) { row, item, cell in
                cell.actImage.image = UIImage(named: item.actImage)
                cell.actUser.text = item.actUser
                cell.actCaption.text = item.actCaption
            }
            .disposed(by: disposeBag)
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
    
}

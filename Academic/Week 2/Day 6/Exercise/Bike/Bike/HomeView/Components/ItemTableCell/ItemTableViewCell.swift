//
//  ItemTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

protocol ItemTableViewCellDelegate: class {
    func didSelectProduct(_ product: ProductType)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ItemTableViewCellDelegate?
    
    var isBicycle: Bool =  false {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var bikeData: [ProductType] = []
    var helmData: [ProductType] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20  // Adjust this value as needed for spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30)  // Adjust the section inset as needed
        
        collectionView.collectionViewLayout = layout
        
        fetchBikeData()
        fetchHelmData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = isBicycle ? bikeData[indexPath.row] : helmData[indexPath.row]
        delegate?.didSelectProduct(selectedData)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isBicycle ? bikeData.count : helmData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isBicycle{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            let bike = bikeData[indexPath.row]
            // If isBicycle is true, display bicycle image
            cell.itemImage.image = UIImage(named: bike.image)
            cell.itemName.text = bike.name
            cell.itemPrice.text = "$\(String(bike.price))"
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            let helm = helmData[indexPath.row]
            // If isBicycle is false, display helmet image
            cell.itemImage.image = UIImage(named: helm.image)
            cell.itemName.text = helm.name
            cell.itemPrice.text = "$\(String(helm.price))"
            cell.layer.cornerRadius = 10
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    
    func updateData(forMenu menu: String) {
        if menu == "BICYCLE" {
            isBicycle = true
        } else {
            isBicycle = false
        }
    }
    
    func fetchBikeData() {
        NetworkManager.shared.makeAPICall(endpoint: .getBike) { (response: Result<[ProductType], Error>) in
            switch response {
            case .success(let products):
                self.bikeData = products
                self.collectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchHelmData() {
        NetworkManager.shared.makeAPICall(endpoint: .getHelmet) { (response: Result<[ProductType], Error>) in
            switch response {
            case .success(let products):
                self.helmData = products
                self.collectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
}

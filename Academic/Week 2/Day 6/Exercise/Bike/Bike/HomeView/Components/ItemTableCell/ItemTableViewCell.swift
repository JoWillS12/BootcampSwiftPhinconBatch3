//
//  ItemTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentData: (names: [String], images: [String], prices: [String]) = ([], [], [])
    
    var isBike: Bool =  false {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var productBikeType: [ProductType] = [.init(nama: "PG-102", image: "bike2", price: "$14000"),
                                          .init(nama: "PAS-122", image: "bike3", price: "$20000"),
                                          .init(nama: "JWX-89", image: "bike4", price: "$25000"),.init(nama: "PG-102", image: "bike2", price: "$14000"),
                                          .init(nama: "PAS-122", image: "bike3", price: "$20000"),
                                          .init(nama: "JWX-89", image: "bike4", price: "$25000")]
    
    var productHelmType: [ProductType] = [.init(nama: "Iron-man", image: "helm1", price: "$1000"),
                                          .init(nama: "PUBG", image: "helm2", price: "$900"),
                                          .init(nama: "HALO", image: "helm3", price: "$7000"), .init(nama: "Iron-man", image: "helm1", price: "$1000"),
                                          .init(nama: "PUBG", image: "helm2", price: "$900"),
                                          .init(nama: "HALO", image: "helm3", price: "$7000")]
    
//    var productMotorType: [ProductType] = [.init(nama: "Harley Davidson", image: "moto1", price: "$25000"),
//                                          .init(nama: "R1", image: "moto2", price: "$20000"),
//                                          .init(nama: "CBR-250RR", image: "moto3", price: "$21000"), .init(nama: "Harley Davidson", image: "moto1", price: "$25000"),
//                                           .init(nama: "R1", image: "moto2", price: "$20000"),
//                                           .init(nama: "CBR-250RR", image: "moto3", price: "$21000")]
    
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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isBike ?  productBikeType.count : productHelmType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isBike {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            let names = productBikeType[indexPath.row].nama
            let images = productBikeType[indexPath.row].image
            let prices = productBikeType[indexPath.row].price
            cell.itemName.text = names
            cell.itemImage.image = UIImage(named: images)
            cell.itemPrice.text = prices
            cell.layer.cornerRadius = 10
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
            let names = productHelmType[indexPath.row].nama
            let images = productHelmType[indexPath.row].image
            let prices = productHelmType[indexPath.row].price
            cell.itemName.text = names
            cell.itemImage.image = UIImage(named: images)
            cell.itemPrice.text = prices
            cell.layer.cornerRadius = 10
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 220)
    }
    
    func updateData(forMenu menu: String) {
        if menu == "BICYCLE" {
            isBike = true
        } else {
            isBike = false
        }
    }
    
}

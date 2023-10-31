//
//  MenuTableViewCell.swift
//  Bike
//
//  Created by Joseph William Santoso on 30/10/23.
//

import UIKit

protocol MenuTableViewCellDelegate {
    func didTapCell(name: String)
}

class MenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let menuName = ["BIKE", "HELMET"]
    let menuImage = [UIImage(systemName: "bicycle.circle"), UIImage(systemName: "bolt.shield.fill")]
    
    var buttonAction: ((String) -> Void)?
    var delegate: MenuTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "MenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30  // Adjust this value as needed for spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)  // Adjust the section inset as needed
        
        collectionView.collectionViewLayout = layout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension MenuTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
        let names = menuName[indexPath.row]
        let images = menuImage[indexPath.row]
        cell.menuName.text = names
        cell.menuImage.image = images
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 400)
    }
    
    func getSelectedMenu() -> String? {
        // Implement a method to get the selected menu from the collection view
        // You might need to keep track of the selected index and use it to fetch the menu
        let selectedMenuIndex = 0;
        if selectedMenuIndex == 1 && selectedMenuIndex < menuName.count {
            return menuName[selectedMenuIndex]
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle the selection in the collection view
        let selectedMenu = menuName[indexPath.item]
        self.buttonAction?(selectedMenu) // Call the button action closure with the selected menu
    }
    
}

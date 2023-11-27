//
//  ThirdTableViewCell.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var bundleData: [BundleData] = []
    var buddieData: [BuddiesData] = []
    var shoppingCart: [CartItem] = []
    var selectedButtonType: String?{
        didSet{
            collectionView.reloadData()
        }
    }
    var moveToCart: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registrationCollectionCell()
        fetchData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectedButtonType = nil
    }
    
    func registrationCollectionCell(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionView.register(UINib.init(nibName: "Item2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item2CollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20  // Adjust this value as needed for spacing between cells
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)  // Adjust the section inset as needed
        
        collectionView.collectionViewLayout = layout
    }
    func fetchData(){
        NetworkManager.shared.makeAPICall(endpoint: .getBundles) { [weak self] (response: Result<(Bundles), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.bundleData = datas.data
                self.collectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .getBuddies) { [weak self] (response: Result<(Buddies), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.buddieData = datas.data
                self.collectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveItem(item: CartItem) {
        if !shoppingCart.contains(where: { $0.itemId == item.itemId }) {
            // Item is not in the cart, add it
            shoppingCart.append(item)

            // Update UserDefaults or any other storage mechanism if needed
            AppSetting.shared.selectedItem = shoppingCart
            print(shoppingCart)
        }
    }
    
    func buttonAddItem(indexPath: IndexPath) {
        guard let selectedType = selectedButtonType else { return }

        switch selectedType {
        case "bundle":
            guard bundleData.indices.contains(indexPath.row) else { return }
            let selectedBundle = bundleData[indexPath.row]
            let cartItem = CartItem(itemType: .bundle, itemId: selectedBundle.uuid, itemImage: selectedBundle.displayIcon, itemName: selectedBundle.displayName)
            saveItem(item: cartItem)
            print(cartItem)
            moveToCart?()
        case "buddie":
            guard buddieData.indices.contains(indexPath.row) else { return }
            let selectedBuddie = buddieData[indexPath.row]
            let cartItem = CartItem(itemType: .buddies, itemId: selectedBuddie.uuid, itemImage: selectedBuddie.displayIcon, itemName: selectedBuddie.displayName)
            saveItem(item: cartItem)
            print(cartItem)
            moveToCart?()
        default:
            break
        }
    }
}
extension ThirdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let selectedButtonType = selectedButtonType {
            switch selectedButtonType {
            case "bundle":
                return bundleData.count
            case "buddie":
                return buddieData.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let selectedButtonType = selectedButtonType {
            switch selectedButtonType {
            case "bundle":
                // Configure cell for bundle data
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
                let datas = bundleData[indexPath.row]
                cell.bundleName.text = datas.displayName
                if let imageURL = URL(string: datas.displayIcon) {
                    cell.bundleImage.kf.setImage(with: imageURL)
                }
                cell.tapAction = { [weak self] in
                    guard let indexPath = self?.collectionView.indexPath(for: cell) else { return }
                    self?.buttonAddItem(indexPath: indexPath)
                    cell.cartButton.isHidden = true
                }
                return cell
            case "buddie":
                // Configure cell for buddie data
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item2CollectionViewCell", for: indexPath) as! Item2CollectionViewCell
                let datas = buddieData[indexPath.row]
                cell.buddieName.text = datas.displayName
                if let imageURL = URL(string: datas.displayIcon) {
                    cell.buddieImage.kf.setImage(with: imageURL)
                }
                cell.tapAction = { [weak self] in
                    guard let indexPath = self?.collectionView.indexPath(for: cell) else { return }
                    self?.buttonAddItem(indexPath: indexPath)
                    cell.cartButton.isHidden = true
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let selectedButtonType = selectedButtonType
        switch selectedButtonType{
        case "bundle":
            return CGSize(width: 331, height: 211)
        case "buddie":
            return CGSize(width: 160, height: 218)
        default:
            return UICollectionView.layoutFittingCompressedSize
        }
    }
    
}

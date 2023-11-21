//
//  WeaponViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import UIKit

class WeaponViewController: UIViewController, SideViewControllerDelegate {
    
    @IBOutlet weak var gearCollectionView: UICollectionView!
    @IBOutlet weak var weaponCollectionView: UICollectionView!
    
    private var sidebarMenu: SideViewController!
    var gearData: [GearData] = []
    var weaponData: [WeaponData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate your sidebar menu
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
        
        // Do any additional setup after loading the view.
        registerCollectionCell()
        fetchData()
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    func registerCollectionCell(){
        gearCollectionView.delegate = self
        gearCollectionView.dataSource = self
        gearCollectionView.register(UINib.init(nibName: "GearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GearCollectionViewCell")
        weaponCollectionView.delegate = self
        weaponCollectionView.dataSource = self
        weaponCollectionView.register(UINib.init(nibName: "WeaponCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeaponCollectionViewCell")
    }
    
    // Implement the SidebarMenuDelegate method
    func didSelectMenuItem(index: Int) {
        // Handle the selected menu item
        print("Selected menu item: \(index)")
        
        NavigationHelper.navigateToViewController(for: index, from: navigationController)
        
        // Dismiss the sidebar menu
        if let sidebarMenu = sidebarMenu {
            sidebarMenu.willMove(toParent: nil)
            sidebarMenu.view.removeFromSuperview()
            sidebarMenu.removeFromParent()
        }
    }
    
    func fetchData(){
        NetworkManager.shared.makeAPICall(endpoint: .getGear) { [weak self] (response: Result<(Gears), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.gearData = datas.data
                self.gearCollectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
        
        NetworkManager.shared.makeAPICall(endpoint: .getWeapon) { [weak self] (response: Result<(Weapons), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.weaponData = datas.data
                self.weaponCollectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}
extension WeaponViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gearCollectionView {
            return gearData.count
        } else if collectionView == weaponCollectionView {
            return weaponData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gearCollectionView {
            let gearCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GearCollectionViewCell", for: indexPath) as! GearCollectionViewCell
            let gearDatas = gearData[indexPath.row]
            if let imageURL = URL(string: gearDatas.displayIcon) {
                gearCell.gearImage.kf.setImage(with: imageURL)
            }
            return gearCell
        } else if collectionView == weaponCollectionView {
            let weaponCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeaponCollectionViewCell", for: indexPath) as! WeaponCollectionViewCell
            let weaponDatas = weaponData[indexPath.row]
            if let imageURL = URL(string: weaponDatas.displayIcon) {
                weaponCell.weaponImage.kf.setImage(with: imageURL)
            }
            return weaponCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showTooltip(for: collectionView, at: indexPath)
    }
    
    private func showTooltip(for collectionView: UICollectionView, at indexPath: IndexPath) {
        let tooltipText: String
        if collectionView == gearCollectionView {
            let data = gearData[indexPath.row]
            let cost = gearData[indexPath.row].shopData.cost
            tooltipText = "Gear: \(data.description)\nCost: \(cost)"
        } else if collectionView == weaponCollectionView {
            let data = weaponData[indexPath.row].weaponStats
            let cost = weaponData[indexPath.row].shopData
            let datas = weaponData[indexPath.row]
            tooltipText = "Weapon: \(datas.displayName)\nCost: \(cost?.cost ?? 0)\nFire Rate: \(data?.fireRate ?? 0)\nMagazine Size: \(data?.magazineSize ?? 0)\nRun Speed Multiplier: \(data?.runSpeedMultiplier ?? 0)\nEquip Time Seconds : \(data?.equipTimeSeconds ?? 0)\nReload Time Seconds: \(data?.reloadTimeSeconds ?? 0)\nFirst Bullet Accuracy: \(data?.firstBulletAccuracy ?? 0)"
        } else {
            return
        }
        
        let tooltipView = TooltipView(text: tooltipText)
        tooltipView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tooltipView)
        tooltipView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tooltipView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // You can customize the duration and animation here
        UIView.animate(withDuration: 5.0, delay: 0.0, options: [], animations: {
            tooltipView.alpha = 0.0
        }) { _ in
            tooltipView.removeFromSuperview()
        }
    }
}

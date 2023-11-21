//
//  MainMenuViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 17/11/23.
//

import Foundation
import UIKit

class MainMenuViewController: UIViewController, SideViewControllerDelegate{
    
    @IBOutlet weak var pageCOntrol: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var sidebarMenu: SideViewController!
    var datum: Maps?
    var mapData: [MapsData] = []
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate your sidebar menu
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
        registerCollectionCell()
        registerTableCell()
        fetchMap()
        startTimer()
        configurePageControl()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        print("tapped!")
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    @IBAction func pageClicked(_ sender: Any) {
        let currentPage = (sender as AnyObject).currentPage
        let indexPath = IndexPath(item: currentPage ?? 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
    
    func registerCollectionCell(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "MapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MapCollectionViewCell")
    }
    
    func registerTableCell(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: MapTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MapTableViewCell.self))
    }
    
    func fetchMap(){
        NetworkManager.shared.makeAPICall(endpoint: .getMaps) { [weak self] (response: Result<(Maps), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):
                // Update data source and reload table view
                self.mapData = datas.data
                self.collectionView.reloadData()
                self.tableView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    func configurePageControl() {
        pageCOntrol.currentPageIndicatorTintColor = UIColor.blue
        pageCOntrol.pageIndicatorTintColor = UIColor.lightGray
        pageCOntrol.sizeToFit()
    }
    
    @objc func timerFired() {
        guard mapData.count > 0 else {
            // Handle the case where mapData is empty
            return
        }
        
        let nextPage = (pageCOntrol.currentPage + 1) % mapData.count
        let indexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageCOntrol.currentPage = nextPage
    }
    
    deinit {
        timer?.invalidate()
    }
}
extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageCOntrol.numberOfPages = mapData.count
        return mapData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath) as! MapCollectionViewCell
        let datas = mapData[indexPath.row]
        if let imageURL = URL(string: datas.splash) {
            cell.mapImage.kf.setImage(with: imageURL)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageCOntrol.currentPage = currentPage
    }
}

extension MainMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as! MapTableViewCell
        let datas = mapData[indexPath.row]
        print(datas)
        if let imageURL = URL(string: datas.listViewIcon) {
            cell.mapImage.kf.setImage(with: imageURL)
        }
        cell.mapDesc.text = datas.narrativeDescription
        cell.mapName.text = datas.displayName
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

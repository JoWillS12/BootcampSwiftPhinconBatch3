//
//  TiersViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 21/11/23.
//

import UIKit

class TiersViewController: UIViewController, SideViewControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var rankName: UILabel!
    
    private var sidebarMenu: SideViewController!
    var datum: Tiers?
    var tiersData: [Tier] = []
    var tierData: [TierData] = [] {
        didSet {
        // Filter out tiers with specific names
        let filteredTiers = tierData.first?.tiers.filter { $0.tierName != "Unused1" && $0.tierName != "Unused2" } ?? []
            
        tiersData = filteredTiers
        }
    }
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Instantiate your sidebar menu
        navigationController?.setNavigationBarHidden(true, animated: false)
        sidebarMenu = SideViewController(nibName: "SideViewController", bundle: nil)
        sidebarMenu?.delegate = self
        
        registerCollectionCell()
        fetchTier()
        configurePageControl()
        startTimer()
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        NavigationHelper.handleButtonCondition(for: sidebarMenu, in: self)
    }
    
    @IBAction func pageControlClicked(_ sender: Any) {
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
        collectionView.register(UINib.init(nibName: "TiersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TiersCollectionViewCell")
    }
    
    func fetchTier(){
        NetworkManager.shared.makeAPICall(endpoint: .getTier) { [weak self] (response: Result<(Tiers), Error>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let datas):

                // Update data source and reload table view
                self.tierData = datas.data
//                print(filteredTiers)
                self.collectionView.reloadData()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    func configurePageControl() {
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.sizeToFit()
    }
    
    @objc func timerFired() {
        guard tierData.count > 0 else {
            // Handle the case where mapData is empty
            return
        }
        
        let nextPage = (pageControl.currentPage + 1) % (tiersData.count)
        let indexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = nextPage
    }
    
    deinit {
        timer?.invalidate()
    }
}
extension TiersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = tiersData.count
        return tiersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TiersCollectionViewCell", for: indexPath) as! TiersCollectionViewCell
        let datas = tiersData[indexPath.row]
        if let imageURL = URL(string: datas.largeIcon ?? "") {
            cell.tierImage.kf.setImage(with: imageURL)
        }
        rankName.text = datas.tierName
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

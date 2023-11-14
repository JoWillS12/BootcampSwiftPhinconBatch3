//
//  HomeViewController.swift
//  PetWalk
//
//  Created by Joseph William Santoso on 10/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blueButton: BlueView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var dogData: [MyPet] = []
    var stats: [Home] = [Home(statsType: "Today's plan", statsPercent: "50% accomplished", statsColor: "TodayColor", statsProg: 0.5),
                         Home(statsType: "Energy available", statsPercent: "50% energy", statsColor: "EnergyColor", statsProg: 0.5),
                         Home(statsType: "Weekly's objectives", statsPercent: "3 walks left", statsColor: "WeekColor", statsProg: 0.8)]
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        registerCollectionCell()
        registerTableCell()
        fetchDogData()
        startTimer()
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.sizeToFit()
        blueButton.tapAction = { [weak self] in
            self?.navigateToPetSelect()
        }
    }
    
    @IBAction func pageClicked(_ sender: Any) {
        let currentPage = (sender as AnyObject).currentPage
        let indexPath = IndexPath(item: currentPage ?? 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: StatsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: StatsTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    func registerCollectionCell() {
        collectionView.register(UINib.init(nibName: "HomePetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomePetCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func navigateToPetSelect(){
        let vc = PetSelectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        // Calculate the next page index
        let nextPage = (pageControl.currentPage + 1) % dogData.count
        
        // Scroll to the next page
        let indexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // Update the current page of the page control
        pageControl.currentPage = nextPage
    }
    deinit {
            timer?.invalidate()
        }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = dogData.count
        return dogData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePetCollectionViewCell", for: indexPath) as! HomePetCollectionViewCell
        let dog = dogData[indexPath.row]
        cell.petImage.image = UIImage(named: dog.petImage)
        cell.petName.text = dog.petName
        cell.petAge.text = calculateAge(from: dog.petBirth)
        cell.petKind.text = dog.petRace
        cell.petStatus.text = dog.status
        
        if dog.status == "Happy"{
            cell.dotOne.isHidden = false
            cell.dotTwo.isHidden = false
            cell.dotThree.isHidden = false
        }else if dog.status == "Normal"{
            cell.dotOne.isHidden = false
            cell.dotTwo.isHidden = false
            cell.dotThree.isHidden = true
        }else{
            cell.dotOne.isHidden = false
            cell.dotTwo.isHidden = true
            cell.dotThree.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 96 )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
    
    func fetchDogData() {
        NetworkManager.shared.makeAPICall(endpoint: .myPet) { (response: Result<[MyPet], Error>) in
            switch response {
            case .success(let dogs):
                self.dogData = dogs
                self.collectionView.reloadData()
                self.pageControl.numberOfPages = self.dogData.count
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as! StatsTableViewCell
        let data = stats[indexPath.row]
        cell.statsTitle.text = data.statsType
        cell.statsDesc.text = data.statsPercent
        cell.updateProgress(CGFloat(data.statsProg), progs: UIColor(named: data.statsColor) ?? UIColor.white)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Adjust the spacing height as needed
    }
}


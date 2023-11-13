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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCollectionCell()
        registerTableCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func pageClicked(_ sender: Any) {
        let currentPage = (sender as AnyObject).currentPage
        let indexPath = IndexPath(item: currentPage ?? 0, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 2
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePetCollectionViewCell", for: indexPath) as! HomePetCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 96 )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
    
    func registerCollectionCell() {
        collectionView.register(UINib.init(nibName: "HomePetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomePetCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as! StatsTableViewCell
        return cell
    }
    
    func registerTableCell() {
        tableView.register(UINib(nibName: String(describing: StatsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: StatsTableViewCell.self))
    }
}

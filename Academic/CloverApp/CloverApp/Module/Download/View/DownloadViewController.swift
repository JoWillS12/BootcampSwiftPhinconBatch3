//
//  DownloadViewController.swift
//  C
//
//  Created by Joseph William Santoso on 07/12/23.
//

import UIKit
import Kingfisher
import AVKit

class DownloadViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var downloadedData: [Download] = []
    var vm = DownloadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        fetchData()
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.register(UINib(nibName: String(describing: DownloadedTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DownloadedTableViewCell.self))
    }
    
    func fetchData(){
        vm.fetchDownload { [weak self] error in
            if let error = error {
                print("Error fetching bookmarks: \(error.localizedDescription)")
            } else {
                self?.downloadedData = self?.vm.downloads ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
    func showVideo(){
        guard let videoURL = URLstore.videosURL else {
            // Handle invalid URL
            print("Not this link!")
            return
        }
        
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}

extension DownloadViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadedTableViewCell", for: indexPath) as! DownloadedTableViewCell
        let datas = downloadedData[indexPath.row]
        cell.movieYear.text = datas.movieDate
        cell.movieGenre.text = datas.movieGenre
        cell.movieName.text = datas.movieName
        cell.tapAction = {[weak self] in
            guard let self = self else { return }
            
            self.vm.deleteDownload(movieId: datas.movieId) { error in
                if let error = error {
                    print("Error deleting download: \(error.localizedDescription)")
                } else {
                    print("Download deleted successfully!")
                    self.downloadedData.remove(at: indexPath.row)
                    self.showAlertSuccess(message: "Deleted Successfully")
                    tableView.reloadData()
                }
            }
        }
        if let moviePicture = URL(string: datas.moviePic){
            cell.movieImage.kf.setImage(with: moviePicture)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showVideo()
    }
}

extension DownloadViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let data = downloadedData[indexPath.row]
        let itemProvider = NSItemProvider(object: data.movieName as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { [weak self] items in
            guard let self = self, let movieNames = items as? [String] else { return }
            
            if let draggedMovieName = movieNames.first, let index = self.downloadedData.firstIndex(where: { $0.movieName == draggedMovieName }) {
                self.downloadedData.remove(at: index)
                self.downloadedData.insert(self.downloadedData[index], at: destinationIndexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidEnd session: UIDropSession) {
    }
}

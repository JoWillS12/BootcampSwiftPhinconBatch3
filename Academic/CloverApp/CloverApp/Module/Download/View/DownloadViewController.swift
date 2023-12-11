//
//  DownloadViewController.swift
//  C
//
//  Created by Joseph William Santoso on 07/12/23.
//

import UIKit
import Kingfisher
import AVKit

class DownloadViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var downloadedData: [Download] = []
    var vm = DownloadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showVideo(){
        guard let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/movie-eead1.appspot.com/o/jump%20scare%20videos%20-%20jumpscare%20-%20scare%20videos%20%23shorts.mp4?alt=media&token=817a2ff6-7589-43fc-a462-c2340edd4a90") else {
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
                    self.showAlert(message: "Deleted Successfully")
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

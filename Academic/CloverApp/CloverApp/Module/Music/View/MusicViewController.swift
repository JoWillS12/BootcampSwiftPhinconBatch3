//
//  MusicViewController.swift
//  C
//
//  Created by Joseph William Santoso on 15/12/23.
//

import UIKit
import Kingfisher

class MusicViewController: UIViewController {
    
    @IBOutlet weak var playedMusic: UILabel!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var vm = MusicViewModel()
    var currentlyPlayingTrack: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        fetchData()
        setUp()
    }
    
    @IBAction func playButton(_ sender: Any) {
    }
    
    @IBAction func forwardButton(_ sender: Any) {
    }
    
    func setUp(){
        playerView.layer.cornerRadius = 16
        playerView.layer.shadowColor = UIColor.white.cgColor
        playerView.layer.shadowOpacity = 0.8
        playerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        playerView.layer.shadowRadius = 3
        //        playerView.layer.shouldRasterize = true
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: MusicTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MusicTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: AlbumTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AlbumTableViewCell.self))
    }
    
    func fetchData(){
        vm.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        vm.fetchData()
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.tracks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
            cell.tapAction = {[weak self] in
                cell.startAnimation()
                self?.vm.playAllTracks()
                if let currentSong = self?.vm.currentlyPlayingIndex{
                    self?.playedMusic.text = self?.vm.tracks[currentSong].titleShort
                }else{}
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
            if (indexPath.row - 1) < vm.tracks.count {
                let track = vm.tracks[indexPath.row - 1]
                cell.musicName.text = track.titleShort
                cell.musicArtist.text = track.artist.name.rawValue
                cell.isSelected = (indexPath.row - 1) == vm.currentlyPlayingIndex
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Handle tap on AlbumTableViewCell if needed
        } else {
            // Pause the current track if playing
            if let currentIndex = vm.currentlyPlayingIndex {
                vm.pausePreview(at: currentIndex)
                if let cell = tableView.cellForRow(at: IndexPath(row: currentIndex + 1, section: indexPath.section)) as? AlbumTableViewCell {
                    cell.stopAnimation()
                }
            }
            
            // Play or resume the selected track
            vm.playPreview(at: indexPath.row - 1)
            currentlyPlayingTrack = vm.tracks[indexPath.row - 1]
            playedMusic.text = currentlyPlayingTrack?.titleShort
            if let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell {
                cell.startAnimation()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 324
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // Disable interaction for the first cell
        return indexPath.row != 0
    }
}

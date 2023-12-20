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
        vm.isPlaying.toggle()
        updatePlayPauseButtonImage()
        tableView.reloadData()
        
        if vm.isPlaying {
            if let currentIndex = vm.currentlyPlayingIndex {
                vm.playPreview(at: currentIndex)
            }
            tableView.reloadData()

        } else {
            if let currentIndex = vm.currentlyPlayingIndex {
                vm.pausePreview(at: currentIndex)
            }
            tableView.reloadData()

        }
    }
    
    @IBAction func forwardButton(_ sender: Any) {
    }
    
    func setUp(){
        playerView.layer.cornerRadius = 16
        playerView.layer.shadowColor = UIColor.white.cgColor
        playerView.layer.shadowOpacity = 0.8
        playerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        playerView.layer.shadowRadius = 3
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: MusicTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MusicTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: AlbumTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AlbumTableViewCell.self))
    }
    
    func updatePlayPauseButtonImage() {
        let imageName = vm.isPlaying ? "pause.fill" : "play.fill"
        let image = UIImage(systemName: imageName)
        playPauseButton.setImage(image, for: .normal)
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
            cell.isPlaying = vm.isPlaying
            cell.isPlayMusic()
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
        if indexPath.row != 0 {
            // Play or resume the selected track
            vm.playPreview(at: indexPath.row - 1)
            vm.isPlaying = true
            updatePlayPauseButtonImage()
            currentlyPlayingTrack = vm.tracks[indexPath.row - 1]
            playedMusic.text = currentlyPlayingTrack?.titleShort
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // Disable interaction for the first cell
        return indexPath.row != 0
    }
}

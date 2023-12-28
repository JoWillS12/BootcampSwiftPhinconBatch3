//
//  GroupTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 01/12/23.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var customButton: RoundView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieName.numberOfLines = 0
        movieName.lineBreakMode = .byWordWrapping
        movieGenre.numberOfLines = 0
        movieGenre.lineBreakMode = .byWordWrapping
        movieImage.layer.cornerRadius = 16
        
        customButton.borderColor = UIColor.gray
        customButton.backgroundColorOverride = UIColor.clear
        customButton.textColor = UIColor.gray
        customButton.buttonImage.image = UIImage(systemName: "plus")
        customButton.tintColor = UIColor.gray
        customButton.buttonName.text = "My List"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupTrending(datas: TrendingResult){
        
    }
    
    func setupUpcoming(datas: TopResult){
        
    }
    
    func setupTopRated(datas: UpcomingResult){
        
    }
}

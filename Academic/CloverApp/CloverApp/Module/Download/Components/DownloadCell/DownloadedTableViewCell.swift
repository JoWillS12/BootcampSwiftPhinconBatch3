//
//  DownloadedTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 07/12/23.
//

import UIKit

class DownloadedTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    var tapAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieName.numberOfLines = 0
        movieName.lineBreakMode = .byWordWrapping
        movieGenre.numberOfLines = 0
        movieGenre.lineBreakMode = .byWordWrapping
        movieImage.layer.cornerRadius = 16
    }

    @IBAction func deleteButton(_ sender: Any) {
       tapAction?()
    }
}

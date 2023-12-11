//
//  ImageTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 08/12/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAttachment: UIImageView!
    
    var tapAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        userAttachment.isUserInteractionEnabled = true
        userAttachment.addGestureRecognizer(tapGesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadImageFromURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.userAttachment.image = image
                }
            }
        }.resume()
    }
    
    @objc private func handleTap() {
        tapAction?()
    }
}

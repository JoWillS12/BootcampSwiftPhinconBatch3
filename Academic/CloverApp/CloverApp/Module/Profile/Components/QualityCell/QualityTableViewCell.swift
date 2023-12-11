//
//  QualityTableViewCell.swift
//  C
//
//  Created by Joseph William Santoso on 05/12/23.
//

import UIKit

class QualityTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var qualityImage: UIImageView!
    @IBOutlet weak var qualityName: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var optionStack: UIStackView!
    @IBOutlet weak var optionOne: UIStackView!
    @IBOutlet weak var optionTwo: UIStackView!
    @IBOutlet weak var optionThree: UIStackView!
    
    @IBOutlet weak var optionOneImage: UIImageView!
    @IBOutlet weak var optionOneName: UILabel!
    
    @IBOutlet weak var optionTwoImage: UIImageView!
    @IBOutlet weak var optionTwoName: UILabel!
    
    @IBOutlet weak var optionThreeImage: UIImageView!
    @IBOutlet weak var optionThreeName: UILabel!
    
    var isOptionStackHidden = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUp() {
        let chevronTapGesture = UITapGestureRecognizer(target: self, action: #selector(chevronTapped))
        chevronImage.isUserInteractionEnabled = true
        chevronImage.image = UIImage(systemName: "chevron.down")
        chevronImage.addGestureRecognizer(chevronTapGesture)
        
        let optionOneTapGesture = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
        optionOne.isUserInteractionEnabled = true
        optionOne.tag = 1
        optionOne.addGestureRecognizer(optionOneTapGesture)
        
        let optionTwoTapGesture = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
        optionTwo.isUserInteractionEnabled = true
        optionTwo.tag = 2
        optionTwo.addGestureRecognizer(optionTwoTapGesture)
        
        let optionThreeTapGesture = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
        optionThree.isUserInteractionEnabled = true
        optionThree.tag = 3
        optionThree.addGestureRecognizer(optionThreeTapGesture)
    }
    
    @objc func chevronTapped() {
        isOptionStackHidden.toggle()
        optionStack.isHidden = isOptionStackHidden
        updateHeight()
        
        let chevronImageName = isOptionStackHidden ? "chevron.right" : "chevron.down"
        let chevronImages = UIImage(systemName: chevronImageName)
        chevronImage.image = chevronImages
    }
    
    @objc func optionTapped(_ sender: UITapGestureRecognizer) {
        let selectedOption = sender.view as! UIStackView
        let selectedOptionImage = getImageForOption(selectedOption.tag)
        
        // Reset all option images to circle
        optionOneImage.image = UIImage(systemName: "circle")
        optionTwoImage.image = UIImage(systemName: "circle")
        optionThreeImage.image = UIImage(systemName: "circle")
        
        // Set the selected option image to circle.fill
        selectedOptionImage?.image = UIImage(systemName: "circle.fill")
    }
    
    func getImageForOption(_ tag: Int) -> UIImageView? {
        switch tag {
        case 1:
            return optionOneImage
        case 2:
            return optionTwoImage
        case 3:
            return optionThreeImage
        default:
            return nil
        }
    }
}

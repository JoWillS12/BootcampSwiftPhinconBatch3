//
//  ClassView.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 20/11/23.
//

import UIKit

class ClassView: UIView {

    @IBOutlet weak var duelistSec: UIImageView!
    @IBOutlet weak var controllerSec: UIImageView!
    @IBOutlet weak var sentinelSec: UIImageView!
    @IBOutlet weak var initiatorSec: UIImageView!
    
    var duelAction: (() -> Void)?
    var sentiAction: (() -> Void)?
    var controlAction: (() -> Void)?
    var initAction: (() -> Void)?
    var roleSelectionAction: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    @IBAction func duelClicked(_ sender: Any) {
        duelAction?()
        roleSelectionAction?("duelist")
        print("duelist")
        updateLineColors(duelLine: .red, controlLine: .white, sentiLine: .white, initLine: .white)
    }
    
    @IBAction func controlClicked(_ sender: Any) {
        controlAction?()
        print("controller")
        roleSelectionAction?("controller")
        updateLineColors(duelLine: .white, controlLine: .red, sentiLine: .white, initLine: .white)
    }

    @IBAction func sentinelClicked(_ sender: Any) {
        sentiAction?()
        print("sentinel")
        roleSelectionAction?("sentinel")
        updateLineColors(duelLine: .white, controlLine: .white, sentiLine: .red, initLine: .white)
    }
    
    @IBAction func initiatorClicked(_ sender: Any) {
        initAction?()
        print("initiator")
        roleSelectionAction?("initiator")
        updateLineColors(duelLine: .white, controlLine: .white, sentiLine: .white, initLine: .red)
    }
    
    func configureView() {
        let view = CodeHelper.loadNib(for: self)
        duelistSec.layer.cornerRadius = duelistSec.frame.width / 2
        controllerSec.layer.cornerRadius = controllerSec.frame.width / 2
        sentinelSec.layer.cornerRadius = sentinelSec.frame.width / 2
        initiatorSec.layer.cornerRadius = initiatorSec.frame.width / 2
        
        duelistSec.layer.borderWidth = 2
        controllerSec.layer.borderWidth = 2
        sentinelSec.layer.borderWidth = 2
        initiatorSec.layer.borderWidth = 2
        if let imageURL = URL(string: "https://media.valorant-api.com/agents/roles/dbe8757e-9e92-4ed4-b39f-9dfc589691d4/displayicon.png") {
            duelistSec.kf.setImage(with: imageURL)
        }
        if let imageURL = URL(string: "https://media.valorant-api.com/agents/roles/4ee40330-ecdd-4f2f-98a8-eb1243428373/displayicon.png") {
            controllerSec.kf.setImage(with: imageURL)
        }
        if let imageURL = URL(string: "https://media.valorant-api.com/agents/roles/5fc02f99-4091-4486-a531-98459a3e95e9/displayicon.png") {
            sentinelSec.kf.setImage(with: imageURL)
        }
        if let imageURL = URL(string: "https://media.valorant-api.com/agents/roles/1b47567f-8f7b-444b-aae3-b0c634622d10/displayicon.png") {
            initiatorSec.kf.setImage(with: imageURL)
        }
        addSubview(view)
    }
    
    private func updateLineColors(duelLine: UIColor, controlLine: UIColor, sentiLine: UIColor, initLine: UIColor) {
        self.duelistSec.layer.borderColor = duelLine.cgColor
        self.controllerSec.layer.borderColor = controlLine.cgColor
        self.sentinelSec.layer.borderColor = sentiLine.cgColor
        self.initiatorSec.layer.borderColor = initLine.cgColor
    }
}

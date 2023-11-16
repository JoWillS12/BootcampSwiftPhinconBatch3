//
//  PetSelectionViewController.swift
//  DogApp
//
//  Created by Joseph William Santoso on 14/11/23.
//

import UIKit

class PetSelectionViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var onFoot: MethodView!
    @IBOutlet weak var onBike: MethodView!
    @IBOutlet weak var other: MethodView!
    @IBOutlet weak var blueButton: BlueView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    // MARK: - Properties
    
    var dogData: [MyPet] = []
    var currentIndex: Int = 0
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDogData()
        updateUI()
        setUp()
        
        // Set up tap actions for different methods
        onFoot.tapAction = { [weak self] in
            self?.selectedMethod(method: .onFoot)
        }
        onBike.tapAction = { [weak self] in
            self?.selectedMethod(method: .onBike)
        }
        other.tapAction = { [weak self] in
            self?.selectedMethod(method: .other)
        }
        
        // Set up tap action for the start button
        blueButton.tapAction = { [weak self] in
            guard let self = self else { return }
            let selectedPet = self.dogData[self.currentIndex]
            let vc = StartViewController()
            vc.selectedPet = selectedPet
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        currentIndex += 1
        updateUI()
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        currentIndex -= 1
        updateUI()
    }
    
    // MARK: - UI Updates
    
    func selectedMethod(method: SelectedMethod) {
        // Update UI based on the selected method
        switch method {
        case .onFoot:
            onFoot.methodType.textColor = UIColor.blue
            onBike.methodType.textColor = UIColor.black
            other.methodType.textColor = UIColor.black
            onFoot.methodImage.tintColor = UIColor.blue
            onBike.methodImage.tintColor = UIColor.black
            other.methodImage.tintColor = UIColor.black
        case .onBike:
            onFoot.methodType.textColor = UIColor.black
            onBike.methodType.textColor = UIColor.blue
            other.methodType.textColor = UIColor.black
            onFoot.methodImage.tintColor = UIColor.black
            onBike.methodImage.tintColor = UIColor.blue
            other.methodImage.tintColor = UIColor.black
        case .other:
            onFoot.methodType.textColor = UIColor.black
            onBike.methodType.textColor = UIColor.black
            other.methodType.textColor = UIColor.blue
            onFoot.methodImage.tintColor = UIColor.black
            onBike.methodImage.tintColor = UIColor.black
            other.methodImage.tintColor = UIColor.blue
        }
    }
    
    func setUp() {
        // Set up appearance and content for different UI elements
        onFoot.methodImage.image = UIImage(systemName: "shoeprints.fill")
        onFoot.methodType.text = "On Foot"
        onFoot.layer.cornerRadius = 10
        onFoot.layer.borderColor = UIColor.white.cgColor
        onFoot.layer.borderWidth = 2
        onBike.methodImage.image = UIImage(systemName: "bicycle")
        onBike.methodType.text = "On Bike"
        onBike.layer.cornerRadius = 10
        onBike.layer.borderColor = UIColor.white.cgColor
        onBike.layer.borderWidth = 2
        other.methodImage.image = UIImage(systemName: "paperplane")
        other.methodType.text = "Other"
        other.layer.cornerRadius = 10
        other.layer.borderColor = UIColor.white.cgColor
        other.layer.borderWidth = 2
        
        petImage.layer.cornerRadius = petImage.frame.width / 2
        petImage.layer.borderWidth = 2
        petImage.layer.borderColor = UIColor.white.cgColor
    }
    
    func updateUI() {
        // Update UI based on the current index
        guard currentIndex >= 0 && currentIndex < dogData.count else {
            return
        }
        
        let currentPet = dogData[currentIndex]
        petName.text = currentPet.petName
        petImage.image = UIImage(named: currentPet.petImage)
        
        // Disable/Enable buttons based on currentIndex
        leftButton.isEnabled = currentIndex > 0
        rightButton.isEnabled = currentIndex < dogData.count - 1
    }
    
    // MARK: - Data Fetching
    
    func fetchDogData() {
        // Fetch dog data from the API
        NetworkManager.shared.makeAPICall(endpoint: .myPet) { [weak self] (response: Result<[MyPet], Error>) in
            switch response {
            case .success(let dogs):
                self?.dogData = dogs
                self?.updateUI()
            case .failure(let error):
                print("API Request Error: \(error.localizedDescription)")
            }
        }
    }
}

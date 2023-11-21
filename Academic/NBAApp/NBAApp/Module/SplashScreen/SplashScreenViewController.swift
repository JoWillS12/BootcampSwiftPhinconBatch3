//
//  SplashScreenViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 16/11/23.
//

import UIKit
import RxSwift
import RxCocoa

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var customButton: CustomButton!
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDataNotification(_:)),
            name: NSNotification.Name("DataNotification"),
            object: nil
        )
    }

    @objc func handleDataNotification(_ notification: Notification) {
        // Retrieve data from the notification
        if let data = notification.userInfo?["data"] as? Bool, data {
            print("Received data: \(data)")
            // If data is true, navigate to MainMenuViewController
            let vc = MainMenuViewController()
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func loadButton() {
        customButton.tapAction = { [weak self] in
            self?.showHalfModal()
            print("customButton tapped!")
        }
    }
    
    func showHalfModal() {
        let contentVc = AuthViewController(nibName: "AuthViewController", bundle: nil)
        contentVc.modalPresentationStyle = .custom
        contentVc.transitioningDelegate = self
        present(contentVc, animated: true, completion: nil)
        
        // Add swipe down gesture for dismissal
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissHalfModal))
        swipeDown.direction = .down
        contentVc.view.addGestureRecognizer(swipeDown)
    }
    
    @objc func dismissHalfModal() {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SplashScreenViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}





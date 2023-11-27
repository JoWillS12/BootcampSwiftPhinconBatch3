//
//  TopUpViewController.swift
//  NBAApp
//
//  Created by Joseph William Santoso on 23/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class TopUpViewController: UIViewController {
    
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var textFieldAmount: UITextField!
    
    @IBOutlet weak var vp100: UIStackView!
    @IBOutlet weak var vp500: UIStackView!
    @IBOutlet weak var vp759: UIStackView!
    @IBOutlet weak var vp1000: UIStackView!
    @IBOutlet weak var vp1700: UIStackView!
    @IBOutlet weak var vp2400: UIStackView!
    @IBOutlet weak var vp3900: UIStackView!
    @IBOutlet weak var vp4900: UIStackView!
    @IBOutlet weak var vp7900: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    var amount: Int = 0
    
    let sections = ["E-wallet", "Bank", "Near Store"]
    let ePaymentItems = ["OVO", "Gopay", "LinkAja"]
    let debitItems = ["BCA", "Mandiri", "BNI"]
    let offlineItems = ["Indomaret", "Alfamart"]
    var isSectionExpanded: [Bool] = [false, false, false]
    var currentlyExpandedSection: Int?
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadAmount()
        registerTableCell()
        
        isSectionExpanded = [false, false, false]
        currentlyExpandedSection = 0
        tableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func payButton(_ sender: Any) {
        guard let amountText = textFieldAmount.text, !amountText.isEmpty else {
            showPaymentFailed()
            return
        }
        
        // Save the payment amount in UserDefaults
        UserDefaults.standard.set(amount, forKey: "LastPaymentAmount")
        
        if let selectedIndexPath = selectedIndexPath {
            // Payment success notification with the amount and method
            navigationController?.popViewController(animated: false)
            showPaymentSuccess(for: amount, indexPath: selectedIndexPath)
        } else {
            // Show payment failed notification if no payment method is selected
            showPaymentFailed()
        }
    }
    
    func setupTapGesture(for stackView: UIStackView, amountToAdd: Int) {
        stackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                
                self.amount = amountToAdd
                self.textFieldAmount.text = "\(self.amount) VP"
            })
            .disposed(by: disposeBag)
    }
    
    func loadAmount() {
        setupTapGesture(for: vp100, amountToAdd: 100)
        setupTapGesture(for: vp500, amountToAdd: 500)
        setupTapGesture(for: vp759, amountToAdd: 759)
        setupTapGesture(for: vp1000, amountToAdd: 1000)
        setupTapGesture(for: vp1700, amountToAdd: 1700)
        setupTapGesture(for: vp2400, amountToAdd: 2400)
        setupTapGesture(for: vp3900, amountToAdd: 3900)
        setupTapGesture(for: vp4900, amountToAdd: 4900)
        setupTapGesture(for: vp7900, amountToAdd: 7900)
    }
    
    func registerTableCell(){
        textFieldView.layer.cornerRadius = 20
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: PaymentTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PaymentTableViewCell.self))
    }
    
    func showPaymentFailed() {
        let alertController = UIAlertController(title: "Payment Failed !", message: "Check The Amount and Your Payment Method.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showPaymentSuccess(for amount: Int, indexPath: IndexPath) {
        let method: String
        switch indexPath.section {
        case 0:
            method = ePaymentItems[indexPath.row]
        case 1:
            method = debitItems[indexPath.row]
        case 2:
            method = offlineItems[indexPath.row]
        default:
            method = ""
        }
        
        let alertController = UIAlertController(title: "Payment Success!", message: "Amount: \(amount) VP\nMethod: \(method)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension TopUpViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSectionExpanded[section] ? numberOfRows(forSection: section) : 0
    }
    
    private func numberOfRows(forSection section: Int) -> Int {
        switch section {
        case 0:
            return ePaymentItems.count
        case 1:
            return debitItems.count
        case 2:
            return offlineItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell", for: indexPath) as! PaymentTableViewCell
        
        if indexPath == selectedIndexPath {
            // Show checkmark in the selected cell
            cell.accessoryType = .checkmark
        } else {
            // Hide checkmark in other cells
            cell.accessoryType = .none
        }
        
        if indexPath.section == 0 {
            cell.methodLabel.text = ePaymentItems[indexPath.row]
        } else if indexPath.section == 1 {
            cell.methodLabel.text = debitItems[indexPath.row]
        } else {
            cell.methodLabel.text = offlineItems[indexPath.row]
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView(reuseIdentifier: "SectionHeader")
        headerView.textLabel?.text = sections[section]
        headerView.textLabel?.textColor = UIColor.white
        headerView.textLabel?.adjustsFontForContentSizeCategory = true
        headerView.tapHandler = { [weak self] in
            self?.toggleSection(section)
            // Clear the selected index when a section header is tapped
            self?.selectedIndexPath = nil
            tableView.reloadData()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update the selected index and reload the table
        selectedIndexPath = indexPath
        print(selectedIndexPath ?? 0)
        tableView.reloadData()
        
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    private func toggleSection(_ section: Int) {
        if let expandedSection = currentlyExpandedSection, expandedSection != section {
            isSectionExpanded[expandedSection] = false
            tableView.reloadSections(IndexSet(integer: expandedSection), with: .automatic)
        }
        
        isSectionExpanded[section] = !isSectionExpanded[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        
        // Clear the selected index only when a section header is tapped
        if currentlyExpandedSection != section {
            selectedIndexPath = nil
        }
        
        currentlyExpandedSection = isSectionExpanded[section] ? section : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

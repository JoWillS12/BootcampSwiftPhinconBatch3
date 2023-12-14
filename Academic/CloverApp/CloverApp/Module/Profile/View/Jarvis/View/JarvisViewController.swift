//
//  JarvisViewController.swift
//  C
//
//  Created by Joseph William Santoso on 14/12/23.
//

import UIKit

class JarvisViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var messageInsert: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chatMessages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableCell()
        tableView.reloadData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        messageInsert.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func sendButton(_ sender: Any) {
        guard let message = messageInsert.text, !message.isEmpty else { return }
        sendMessage(message)
        messageInsert.text = ""
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CommunityTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CommunityTableViewCell.self))
    }
    
    func sendMessage(_ message: String) {
        chatMessages.append("You: \(message)")
        let indexPath = IndexPath(row: chatMessages.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        OpenAIAPIManager.shared.generateCompletion(conversation: chatMessages) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let text):
                    self?.receiveMessage("AI: \(text)")
                case .failure(let error):
                    print("Error generating completion: \(error)")
                }
            }
        }
    }
    
    func receiveMessage(_ message: String) {
        chatMessages.append(message)
        tableView.reloadData()
    }
}

extension JarvisViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell", for: indexPath) as! CommunityTableViewCell
        cell.userName.isHidden = true
        cell.userImage.isHidden = true
        cell.userChat.text = chatMessages[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}


//
//  JarvisViewController.swift
//  C
//
//  Created by Joseph William Santoso on 14/12/23.
//

import UIKit
import GoogleGenerativeAI

class JarvisViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var messageInsert: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var chatMessages: [Message] = []
    
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
        Task { @MainActor in
            guard let message = messageInsert.text, !message.isEmpty else { return }
            await sendMessage(message, from: .user)
            messageInsert.text = ""
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: JarvisTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JarvisTableViewCell.self))
    }
    
    func sendMessage(_ message: String, from sender: Message.Sender) async {
        do {
            let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
            
            let newMessage = Message(sender: sender, content: message)
            chatMessages.append(newMessage)
            
            let indexPath = IndexPath(row: chatMessages.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            do {
                let response = try await model.generateContent(message)
                if let text = response.text {
                    print(text)
                    receiveMessage(text, from: .ai)
                } else {
                    print("Response text is nil.")
                }
            } catch {
                print("Error generating content: \(error)")
            }
            
        } catch {
            print("Error getting API key: \(error)")
        }
    }
    
    func receiveMessage(_ message: String, from sender: Message.Sender) {
        let newMessage = Message(sender: sender, content: message)
        chatMessages.append(newMessage)
        tableView.reloadData()
    }
}

extension JarvisViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JarvisTableViewCell", for: indexPath) as! JarvisTableViewCell
        let message = chatMessages[indexPath.row]
        cell.textMessage.text = message.content
        switch message.sender {
        case .user:
            cell.updateCorners(isUserMessage: true)
        case .ai:
            cell.updateCorners(isUserMessage: false)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


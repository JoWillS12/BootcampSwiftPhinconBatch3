//
//  CommentsViewController.swift
//  C
//
//  Created by Joseph William Santoso on 29/11/23.
//

import UIKit
import Parchment
import FirebaseDatabase
import FirebaseAuth

class CommentsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentField: UITextField!
    
    let index: Int
    var currentUser: User?
    var selectedMovieID: Int?
    var typeData: DataType = .trending
    var vm = CommentsViewModel()
    
    init(index: Int, selectedMovieID: Int?) {
        self.index = index
        self.selectedMovieID = selectedMovieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @IBAction func sendComment(_ sender: Any) {
        // Disable the button to prevent multiple clicks
        sendButton.isEnabled = false
        
        // Hide the button for 1 second
        sendButton.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Re-enable the button and make it visible again after 1 second
            self.sendButton.isEnabled = true
            self.sendButton.isHidden = false
        }
        
        guard let currentUser = currentUser,
              let commentText = commentField.text, !commentText.isEmpty else {
            // Handle empty comment text or missing user information
            return
        }
        
        guard let movieID = selectedMovieID else {
            // Handle the case where the movie ID is nil
            return
        }
        
        vm.addComment(movieID: movieID, commentText: commentText, currentUser: currentUser) { error in
            if let error = error {
                print("Error saving comment: \(error.localizedDescription)")
            } else {
                print("Comment saved successfully!")
                self.commentField.text = ""
                self.fetchComments()
            }
        }
    }
    
    func setUp(){
        registerTableCell()
        currentUser = Auth.auth().currentUser
        updateUI()
        fetchComments()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        commentField.delegate = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func registerTableCell(){
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CommentTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: String(describing: CommentTableViewCell.self))
    }
    
    func fetchComments() {
        guard let selectedMovieID = selectedMovieID else {
            // Handle the case where the movie ID is nil
            return
        }
        
        vm.fetchComments(forMovieID: selectedMovieID) {
            self.tableView.reloadData()
        }
    }
    
    func updateUI() {
        // Update UI based on the comments array or any other relevant logic
        tableView.reloadData()
    }
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        let comment = vm.comments[indexPath.row]
        
        // Configure the cell with the comment data
        cell.comment.text = comment.text
        cell.userName.text = comment.username
        
        // Use DateFormatter to convert timestamp to a formatted date
        let timestamp = comment.timestamp
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        let formattedDate = dateFormatter.string(from: date)
        
        cell.commentDate.text = formattedDate
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

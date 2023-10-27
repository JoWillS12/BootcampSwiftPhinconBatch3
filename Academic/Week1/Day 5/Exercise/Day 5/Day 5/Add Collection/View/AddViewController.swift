//
//  ViewController.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import UIKit

class AddViewController: UIViewController {
    
    weak var delegate: PassingBookDelegate?
    
    @IBOutlet weak var bookOne: UILabel!
    @IBOutlet weak var authorOne: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var bookTwo: UILabel!
    @IBOutlet weak var authorTwo: UILabel!
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var bookThree: UILabel!
    @IBOutlet weak var authorThree: UILabel!
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bookOne.text = "Donald Duck"
        authorOne.text = "Rowan"
        bookTwo.text = "Snow White"
        authorTwo.text = "Robin"
        bookThree.text = "Star Wars"
        authorThree.text = "Roswald"
        
    }
    
    @IBAction func addBookOne(_ sender: Any) {
        let name = bookOne.text ?? ""
        let auth = authorOne.text ?? ""
        let book = Books(bookName: name, authName: auth)
        saveBook(book)
        let sBCheck = saveBook(book)
        self.delegate?.passBook(data: book)
        print("button Tapped")
        
        // Check if the save operation was successful
            if sBCheck {
                buttonOne.isHidden = true // Hide the button
            }
    }
    
    @IBAction func addBookTwo(_ sender: Any) {
        let name2 = bookTwo.text ?? ""
        let auth2 = authorTwo.text ?? ""
        let book = Books(bookName: name2, authName: auth2)
        saveBook(book)
        let sBCheck = saveBook(book)
        self.delegate?.passBook(data: book)
        print("button Tapped")
        if sBCheck {
            buttonTwo.isHidden = true // Hide the button
        }
    }
    
    @IBAction func addBookThree(_ sender: Any) {
        let name3 = bookThree.text ?? ""
        let auth3 = authorThree.text ?? ""
        let book = Books(bookName: name3, authName: auth3)
        saveBook(book)
        let sBCheck = saveBook(book)
        self.delegate?.passBook(data: book)
        print("button Tapped")
        if sBCheck {
            buttonThree.isHidden = true // Hide the button
        }
    }
}


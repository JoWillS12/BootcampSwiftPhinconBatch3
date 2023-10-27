//
//  CollectionTableViewController.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import UIKit

// MARK: - CollectionCell Class

class CollectionCell: UITableViewCell{
    
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    
}

// MARK: - CollectionTableViewController Class

class CollectionTableViewController: UITableViewController {
    
    var books: [Books] = []  // Store Book's name and author inside array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! CollectionCell
        let book = books[indexPath.row]
        cell.bookName.text = book.bookName
        cell.bookAuthor.text = book.authName
        return cell
    }
}


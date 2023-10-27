//
//  CollectionTableViewModel.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import Foundation


extension CollectionTableViewController: PassingBookDelegate{
    
    func passBook(data: Books) {
        books.append(data)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "SavedBooks"),
           let savedBooks = try? JSONDecoder().decode([Books].self, from: data) {
            print("YOUR DATA is HERE \(savedBooks)")
            books = savedBooks
            tableView.reloadData()
        }
    }
    
}

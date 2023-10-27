//
//  AddViewModel.swift
//  Day 5
//
//  Created by Joseph William Santoso on 27/10/23.
//

import Foundation

extension AddViewController{
    
    func saveBook(_ book: Books) -> Bool { // Update the function to return a Bool
        var savedBooks = getSavedBooks()
        savedBooks.append(book)
        if let data = try? JSONEncoder().encode(savedBooks) {
            UserDefaults.standard.set(data, forKey: "SavedBooks")
            print("Data Saved \(savedBooks)")
            return true // Return true to indicate a successful save
        } else {
            return false // Return false if there was an issue with the save
        }
    }
    
    func getSavedBooks() -> [Books] {
        if let data = UserDefaults.standard.data(forKey: "SavedBooks"),
           let savedBooks = try? JSONDecoder().decode([Books].self, from: data) {
            print("YOUR DATA is HERE \(savedBooks)")
            return savedBooks
        }
        print("No data!")
        return []
    }
    
}

//
//  DataManager.swift
//  Bike
//
//  Created by Joseph William Santoso on 09/11/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Data")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func updateFeed() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
    func deleteFeed(feed: Feeds) {
        persistentContainer.viewContext.delete(feed)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    func getAllFeed() -> [Feeds] {
        let fetchRequest: NSFetchRequest<Feeds> = Feeds.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func saveFeed(actUser: String, actImage: UIImage, actCaption: String, actStatus: Bool) {
        let user = Users(context: persistentContainer.viewContext)
        user.actUser = actUser
        
        let feed = Feeds(context: persistentContainer.viewContext)
        feed.actCaption = actCaption
        feed.actStatus = actStatus
        
        // Convert UIImage to Data
        if let imageData = actImage.jpegData(compressionQuality: 1.0) {
            feed.actImage = imageData
        }
        
        // Establish the relationship
        feed.ofUser = user
        
        do {
            try persistentContainer.viewContext.save()
            print("Activity saved!")
        } catch {
            print("Failed to save activity: \(error)")
        }
    }
    
    func getImageForFeed(feed: Feeds) -> UIImage? {
        if let imageData = feed.actImage {
            return UIImage(data: imageData)
        }
        return nil
    }
}


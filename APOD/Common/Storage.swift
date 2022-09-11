//
//  Storage.swift
//  APOD
//
//  Created by Supreeth Doddabela on 09/09/2022.
//

import Foundation
import UIKit
import CoreData

struct Storage {
    
    func deleteEntries(for entityName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("\(NSLocalizedString(LocalizeConstants.couldNotDelete, comment: "")) \(error), \(error.userInfo)")
        }
    }
    
    func storeRecentPicture(_ picture: Picture, imagData: Data) {
        deleteEntries(for: StorageConstants.recentPictureEntityName)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: StorageConstants.recentPictureEntityName, in: managedContext) else {
            return
        }
        let pod = NSManagedObject(entity: entity,insertInto: managedContext)
        pod.setValue(picture.date, forKey: StorageConstants.dateKey)
        pod.setValue(picture.explanation, forKey: StorageConstants.explanationKey)
        pod.setValue(picture.hdurl, forKey: StorageConstants.hdurlKey)
        pod.setValue(picture.title, forKey: StorageConstants.titleKey)
        pod.setValue(picture.mediaType, forKey: StorageConstants.mediaTypeKey)
        pod.setValue(imagData, forKey: StorageConstants.imageDataKey)
        appDelegate.saveContext()
    }
    
    func fetchRecentPicture() -> RecentPicture? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: StorageConstants.recentPictureEntityName)
        
        do {
            let recentPicture = try (managedContext.fetch(fetchRequest) as? [RecentPicture])?.first
            return recentPicture
        } catch let error as NSError {
            print("\(NSLocalizedString(LocalizeConstants.couldNotFetch, comment: "")) \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func addToFavourites(_ picture:Picture) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "POD", in: managedContext) else {
            return
        }
        let pod = NSManagedObject(entity: entity,insertInto: managedContext)
        pod.setValue(picture.date, forKey: StorageConstants.dateKey)
        pod.setValue(picture.explanation, forKey: StorageConstants.explanationKey)
        pod.setValue(picture.hdurl, forKey: StorageConstants.hdurlKey)
        pod.setValue(picture.title, forKey: StorageConstants.titleKey)
        pod.setValue(picture.mediaType, forKey: StorageConstants.mediaTypeKey)
        pod.setValue(picture.url, forKey: StorageConstants.urlKey)
        appDelegate.saveContext()
    }
    
    func fetchFavourites() -> [POD]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "POD")
        
        do {
            let favourites = try managedContext.fetch(fetchRequest) as? [POD]
            return favourites
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func deleteFromFavourites(_ url:String?){
        let request: NSFetchRequest<POD> = POD.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url ?? "")
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
       
        guard let result = try? managedContext.fetch(request) else {
            return
        }
        for item in result {
            managedContext.delete(item)
        }
        
        appDelegate.saveContext()
    }
    
    func isFavourite(_ picture:Picture) -> Bool {
        let query = picture.url
        let request: NSFetchRequest<POD> = POD.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", query ?? "")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let result = try? managedContext.fetch(request) else {
            return false
        }
         
        return result.count > 0 ? true : false
    }
}

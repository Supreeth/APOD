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
    
    func storePicture(_ picture: Picture) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: picture, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: pictureKey)
        } catch {
            debugPrint("Could not save data. Reason: \(error)")
        }
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
        pod.setValue(picture.date, forKey: "date")
        pod.setValue(picture.explanation, forKey: "explanation")
        pod.setValue(picture.hdurl, forKey: "hdurl")
        pod.setValue(picture.title, forKey: "title")
        appDelegate.saveContext()
    }
    
    func addToFavourites(_ picture:POD) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "POD", in: managedContext) else {
            return
        }
        let pod = NSManagedObject(entity: entity,insertInto: managedContext)
        pod.setValue(picture.date, forKey: "date")
        pod.setValue(picture.explanation, forKey: "explanation")
        pod.setValue(picture.hdurl, forKey: "hdurl")
        pod.setValue(picture.title, forKey: "title")
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
        request.predicate = NSPredicate(format: "hdurl == %@", url ?? "")
       
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
        let query = picture.hdurl
        let request: NSFetchRequest<POD> = POD.fetchRequest()
        request.predicate = NSPredicate(format: "hdurl == %@", query ?? "")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let result = try? managedContext.fetch(request) else {
            return false
        }
         
        return result.count > 0 ? true : false
    }
    
    func isFavourite(_ pod:POD) -> Bool {
        let query = pod.hdurl
        let request: NSFetchRequest<POD> = POD.fetchRequest()
        request.predicate = NSPredicate(format: "hdurl == %@", query ?? "")
        
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

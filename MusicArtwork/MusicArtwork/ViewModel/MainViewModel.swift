//
//  MainViewModel.swift
//  MusicArtwork
//
//  Created by Serhii CHORNONOH on 9/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MainViewModel {
    
    private var appDelegate: AppDelegate!
    private var managedContext: NSManagedObjectContext!
    
    var managedObject = [NSManagedObject]()
    var history = [CoreDataHistory]()
    
    init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedContext = appDelegate.persistentContainer.viewContext
        
        fetchHistoryFromCoreData()
    }
    
    func saveToCoreDataHistory(request: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: "CoreDataHistory", in: managedContext)!
        let data = NSManagedObject(entity: entity, insertInto: managedContext) as! CoreDataHistory
        
        data.request = request
        
        do {
            try managedContext.save()
            managedObject.append(data)
        } catch let error {
            print(error)
        }
        
    }
    
    func fetchHistoryFromCoreData() {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataHistory")
        
        do {
            managedObject = try managedContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        
        for item in managedObject {
            history.append(item as! CoreDataHistory)
        }
        print("fetchHistoryFromCoreData - history: \(history)")
    }
    
    func deleteAllData(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for manObj in result {
                let managedObjectData : NSManagedObject = manObj as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            try managedContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
}

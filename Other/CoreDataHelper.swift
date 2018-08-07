//
//  CoreDataHelper.swift
//  ocoProject
//
//  Created by Ricardo Ramirez on 8/6/18.
//  Copyright © 2018 Ricardo Ramirez. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func new() -> Challenge {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Challenge", into: context) as! Challenge
        return note
    }
    static func saveData() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    static func delete(note: Challenge) {
        context.delete(note)
        
        saveData()
    }
    
    static func retrieveData() -> [Challenge] {
        do {
            let fetchRequest = NSFetchRequest<Challenge>(entityName: "Challenge")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}

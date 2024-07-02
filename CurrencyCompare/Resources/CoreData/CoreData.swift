//
//  CoreData.swift
//  CurrencyCompare
//
//  Created by Shaik Arshad on 30/7/20.
//  Copyright © 2020 brightsword. All rights reserved.
//

import Foundation
import CoreData

//MARK:- Save to coredata
func saveToCoreData(home_currency: String, compare_currency: String) -> Bool{
    let context = AppInstance.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: CoreData.entity.rawValue, in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
    newUser.setValue(home_currency, forKey: CoreData.home_currency.rawValue)
    newUser.setValue(compare_currency, forKey: CoreData.compare_currency.rawValue)
    do {
        try context.save()
        return true
    } catch {
        print("Failed saving")
        return false
    }
}

//MARK:- Get data from coredata
func fetchFromCoreData() -> [[String : String]]{
    var results: [[String : String]] = [[String : String]]()
    
    let context = AppInstance.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreData.entity.rawValue)
    //request.predicate = NSPredicate(format: "age = %@", "12")
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            print(data.value(forKey: CoreData.compare_currency.rawValue) as! String)
            
            var dict: [String:String] = [String:String]()
            dict[CoreData.compare_currency.rawValue] = (data.value(forKey: CoreData.compare_currency.rawValue) as! String)
            dict[CoreData.home_currency.rawValue] = (data.value(forKey: CoreData.home_currency.rawValue) as! String)
            results.append(dict)
            
            print("results are ", results)
            
        }
        return results
    } catch {
        print("Failed")
        return results
    }
    
}

//MARK:- Delete all records from coredata
func deleteCoreData() -> Bool{
    let context = AppInstance.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreData.entity.rawValue)
    //request.predicate = NSPredicate(format: "age = %@", "12")
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            print(data.value(forKey: CoreData.home_currency.rawValue) as! String)
            print(data)
            context.delete(data)
            
            do {
                try context.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
                return false
            }
        }
        return true
    } catch {
        print("Failed")
        return false
    }
}

func updateCoreData(home_currency: String, compare_currency: String) -> Bool {
    let managedContext = AppInstance.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: CoreData.entity.rawValue, in: managedContext)
    let request = NSFetchRequest<NSFetchRequestResult>()
    request.entity = entity
    //let predicate = NSPredicate(format: "(name = %@)", id)
    //request.predicate = predicate
    do {
        let results =
            try managedContext.fetch(request)
        let objectUpdate = results[0] as! NSManagedObject
        if home_currency != "" {
            objectUpdate.setValue(home_currency, forKey: CoreData.home_currency.rawValue)
        }
        
        if compare_currency != "" {
            objectUpdate.setValue(compare_currency, forKey: CoreData.compare_currency.rawValue)
        }
        
        do {
            try managedContext.save()
            return true
        }catch _ as NSError {
            return false
        }
    }
    catch _ as NSError {
        return false
    }
}

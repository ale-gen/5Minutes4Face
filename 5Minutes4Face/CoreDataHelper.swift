//
//  CoreDataHelper.swift
//  5Minutes4Face
//
//  Created by Aleksandra Generowicz on 25/09/2021.
//

import UIKit
import CoreData

class CoreDataHelper {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func savePeopleList() {
        do {
            try CoreDataHelper.context.save()
        } catch {
            print("Error during saving people list: \(error)")
        }
    }
    
    static func loadPeopleList() -> [Person] {
        do {
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            let peopleList = try CoreDataHelper.context.fetch(request)
            return peopleList
        } catch {
            print("Error during loading people list: \(error)")
        }
        return []
    }
    
    static func deleteFromList(person: Person) {
        CoreDataHelper.context.delete(person)
        savePeopleList()
    }
}

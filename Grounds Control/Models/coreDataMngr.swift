//
//  coreDataMngr.swift
//  Grounds Control
//
//  Created by Brett on 10/12/21.
//

import Foundation
import CoreData

class coreDataMngr {
    
    static let shared = coreDataMngr(modelName: "Grounds_Control")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores{ (description, error) in
                                                 guard error == nil else {
            fatalError(error!.localizedDescription)
        }
        completion?()
    }
}
    func save(){
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error occured while saving: \(error.localizedDescription)")
            }
        }
    }
}

// helper fuctions
extension coreDataMngr {
    func createNote() -> Coffee {
        let drink = Coffee(context: viewContext)
        drink.id = UUID()
        drink.otherNotes = ""
        drink.created = Date()
        drink.floral = Float()
        drink.fruity = Float()
        drink.nutty = Float()
        drink.other = Float()
        drink.roasted = Float()
        drink.sour = Float()
        drink.spice = Float()
        drink.sweet = Float()
        drink.veggie = Float()
        drink.name = ""
        drink.aged = Float()
        drink.decomp = Float()
        drink.mold = Float()
        drink.overroast = Float()
        drink.tainted = Float()
        drink.underripe = Float()
        drink.underroast = Float()
        drink.grade = ""
        drink.chocolate = Float()
        save()
        return drink
    }
    
    func fetchNotes(filter: String? = nil) -> [Coffee] {
        let request: NSFetchRequest<Coffee> = Coffee.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Coffee.created, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        return (try? viewContext.fetch(request)) ?? []
        }
    
    func deleteNote(_ note: Coffee){
        viewContext.delete(note)
        save()
    }
    
    func createNotesFetchedResultsController(filter: String? = nil) -> NSFetchedResultsController<Coffee>{
        let request: NSFetchRequest<Coffee> = Coffee.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Coffee.created, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }

}


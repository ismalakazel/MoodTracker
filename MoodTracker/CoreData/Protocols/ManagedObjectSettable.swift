import Foundation
import CoreData


/**
  
 A protocol for objects that use a NSManagedObjectContext.
 
 */
public protocol ManagedObjectSettable: class {
    var managedObjectContext: NSManagedObjectContext! { get set }
}


public extension NSManagedObjectContext {
    
    /**
     
     Saves or rolls back changes performed in the NSManagedObjectContext
     
     - parameter b: A callback for a a successfull save operation
    
     */
    func performChanges(b: @escaping () -> ()) {
        self.perform {
            do {
                b()
                try self.save()
            } catch {
                self.rollback()
            }
        }
    }
}



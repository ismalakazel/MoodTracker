import CoreData


/**
 
 A persistent container that uses SQlite store to persist data.
 
 - Note: This persistent container is set to perform a lightweight migration.
 
 */
public class PersistentContainer: NSPersistentContainer {
    
    /**
     
     Required initializer.
     
     - parameter name: The persistent store coordinator name.
     - parameter storeType: The StoreType to load the model in.
     
     */
    public required convenience init(name: String, store: Store) {
        
        // Create the persistent store description to attach to the persistent container:
        let description = NSPersistentStoreDescription(
            url: try! FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true).appendingPathComponent("Model.sqlite")
        )
        description.type = store.type
        description.shouldAddStoreAsynchronously = false
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        
        // Initialize the persistent container.
        self.init(name: name)
        
        // Add the store description to the persistent container.
        self.persistentStoreDescriptions = [description]
        
        // Load the store in the persistent container.
        self.loadPersistentStores { description, error in
            if case .some(let e) = error {
                fatalError ("Not able to load store: \(e.localizedDescription)" )
            }
        }
    }
}


/**
 
 Store types to use with a PersistentContainer.
 
 */
public enum Store {
    
    /// A store type that lives in memory.
    case memory
    
    /// A store type that is saved to disk.
    case sqlite
    
    /// The constant value for each enum case.
    public var type: String {
        switch self {
        case .memory: return NSInMemoryStoreType
        case .sqlite: return NSSQLiteStoreType
        }
    }
}

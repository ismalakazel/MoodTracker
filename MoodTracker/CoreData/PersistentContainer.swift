import CoreData


/**
 
 A custom NSPersistentContainer.
 
 */
final public class PersistentContainer: NSPersistentContainer {
    
    /**
     
     Required initializer.
     
     - parameter name: The persistent store coordinator name.
     - parameter storeType: The StoreType to load the model in.
     
     */
    public required convenience init(name: String, model: NSManagedObjectModel, store: Store) {
        /**
         
         NSPersistentStoreDescription with desired store type.
         
         */
        let description = NSPersistentStoreDescription()
        description.type = store.type
        description.shouldAddStoreAsynchronously = false
        
        /**
         
         Create container.
         
         */
        self.init(name: name, managedObjectModel: model)
        self.persistentStoreDescriptions = [description]
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

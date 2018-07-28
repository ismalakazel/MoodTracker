import CoreData


/**
 
 A protocol for base NSManagedObject operations.

 */
public protocol ManagedObjectType {}


extension ManagedObjectType where Self: NSManagedObject {
    
    /**
    
     Initializes the NSManagedObject.
     
     - parameter moc: The NSManagedObjectContext to load the NSEntityDescription from.
     
     */
    public init(moc: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: Self.entity().name!, in: moc) else {
            fatalError("Cannot create NSEntityDescription for \(Self.entity().name!))")
        }
        self.init(entity: entity, insertInto: moc)
    }
}

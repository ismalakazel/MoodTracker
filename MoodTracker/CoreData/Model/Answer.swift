import CoreData


/**
 
 The choosen answer to a question posed to the user.
 
 */
final public class Answer: NSManagedObject, ManagedObjectType {
    
    /// The remote identifier of this object.
    @NSManaged var id: Int16
    
    /// The textual representation of this object.
    @NSManaged var text: String
    
    /// The numeric value of this object.
    @NSManaged var weight: Int16
    
    /// The local identifier of this object.
    @NSManaged var lid: UUID?
    
    /// The date this answer was recorded.
    @NSManaged var date: Date
}

extension Answer: FetchResultControllable {
    public static var descriptors: [NSSortDescriptor]! {
        return [NSSortDescriptor(key: "date", ascending: true)]
    }
    
    public static var predicate: NSPredicate {
        return NSPredicate(format: "lid != NULL")
    }
}

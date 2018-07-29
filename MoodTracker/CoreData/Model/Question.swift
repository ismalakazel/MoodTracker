import CoreData


/**
 
 A question that is posed to the user.
 
 */
final public class Question: NSManagedObject, ManagedObjectType {
    
    /// The remote identifier of this object.
    @NSManaged var id: Int16
    
    /// The textual representation of this object.
    @NSManaged var text: String
    
    /// The date this answer was recorded.
    @NSManaged var date: Date
}

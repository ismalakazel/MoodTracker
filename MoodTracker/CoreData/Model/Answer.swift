import CoreData


/**
 
 The choosen answer to a question posed to the user.
 
 */
final public class Answer: NSManagedObject, ManagedObjectType {
    
    /// The remote identifier of this object.
    @NSManaged var id: Int16
    
    /// The local identifier of this object.
    @NSManaged var lid: UUID?
    
    /// The textual representation of this object.
    @NSManaged var text: String
    
    static var fetchByLid: NSFetchRequest<Answer> {
        let request = fetchRequest
        request.predicate = NSPredicate(format: "lid != NULL")
        return request
    }
}

extension Answer: FetchResultControllable {
    public static var descriptors: [NSSortDescriptor]! {
        return []
    }
}

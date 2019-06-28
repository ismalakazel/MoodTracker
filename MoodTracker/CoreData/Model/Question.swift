import CoreData


/**
 
 A question that is posed to the user.
 
 */
final public class Question: NSManagedObject, ManagedObjectType {
    
    /// The textual representation of this object.
    @NSManaged var text: String
    
    /// The date this answer was recorded.
    @NSManaged var date: Date
    
    /// The choosen answers to this question.
    @NSManaged var answers: NSSet
}

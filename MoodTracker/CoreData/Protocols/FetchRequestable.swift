import CoreData


/**
 
 A base protocol for working with NSFetchRequestResult.
 
 */
public protocol FetchResultControllable: AnyObject, NSFetchRequestResult {
    
    /**
     
     The entity name of the NSFetchRequest.
     
     */
    static var entityName: String { get }
    
    /**
     
     The NSFetchRequestResult default sort descriptors.
     
     */
    static var descriptors: [NSSortDescriptor]! { get }
    
    /**
     
     The sectionNameKeyPath the FetchResultsController should use.
     
     - remark: If this key path is not the same as that specified by the first sort descriptor in fetchRequest, they must generate the same relative orderings
     
     */
    static var sectionNameKeyPath: String? { get }
    
    /**
     
     The name of the cache file the FetchResultsController should use. Pass nil to prevent caching.
     
     */
    static var cacheName: String? { get }
}


extension FetchResultControllable {
    
    /**
     
     Default ManagedObjectType fetch request with sort descriptors
     
     */
    static var fetchRequest: NSFetchRequest<Self> {
        
        let request = NSFetchRequest<Self>(entityName: entityName)
        request.sortDescriptors = descriptors
        return request
    }
}

// MARK: NSManagedObject

extension FetchResultControllable where Self: NSManagedObject {
    
    /**
     
     Default entityName for NSManagedObject classes.
     
     */
    public static var entityName: String {
        return entity().name!
    }
    
    public static var sectionNameKeyPath: String? {
        return descriptors.first?.key
    }
    
    public static var cacheName: String? {
        return entity().name!
    }
}

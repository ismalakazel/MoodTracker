import CoreData


/**
 
 A protocol for base NSManagedObject operations.

 */
public protocol ManagedObjectType {}


public extension ManagedObjectType where Self: NSManagedObject {
    
    init(context: NSManagedObjectContext) {
        guard let entity = NSEntityDescription.entity(forEntityName: Self.entity().name!, in: context) else {
            fatalError("Cannot create NSEntityDescription for \(Self.entity().name!))")
        }
        self.init(entity: entity, insertInto: context)
    }
    
    static func findOrCreate(in context: NSManagedObjectContext, matching predicate: NSPredicate, configure: (Self) -> ()) -> Self {
        guard let object = findOrFetch(in: context, matching: predicate) else {
            let newObject: Self = context.insertObject()
            configure(newObject)
            return newObject
        }
        configure(object)
        return object
    }
    
    static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        guard let object = materializedObject(in: context, matching: predicate) else {
            return fetch(in: context) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
                }.first
        }
        return object
    }
    
    static func fetch(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entity().name!)
        configurationBlock(request)
        return try! context.fetch(request)
    }
    
    static func count(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> () = { _ in }) -> Int {
        let request = NSFetchRequest<Self>(entityName: Self.entity().name!)
        configure(request)
        return try! context.count(for: request)
    }
    
    static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        return nil
    }
}


extension NSManagedObjectContext {
    public func insertObject<A: NSManagedObject>() -> A where A: ManagedObjectType {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entity().name!, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
}

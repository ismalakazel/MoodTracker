/**
  
 A protocol describing a UITableViewCell that can be managed in ManagedTableViewDataSource.

 */
public protocol ManagedTableViewCell {
    
    /**
     
     A ManagedObjectType model managed in the ManagedTableViewDataSource.
     
     - remark: Maybe make this a TestType or a Type that combines ManagedObjectType and TestType and TestStatusSettable.
     
     */
    associatedtype Model: FetchResultControllable
    
    /**
     
     The required UITableViewCell identifier.
     
     */
    static var identifier: String { get }
    
    /**
     
     A cell configuration function used when cells are first loaded or reused.
     
     */
    func configure(model: Model)
}


extension ManagedTableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

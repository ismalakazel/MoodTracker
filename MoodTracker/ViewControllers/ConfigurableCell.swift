import UIKit


/**
 
 A protocol for cells that can be configured with T.
 
 */
internal protocol ConfigurableCell: class {
    
    /// The associated type used to configure the cell.
    associatedtype T
    
    /// The cell identifier.
    static var identifier: String { get }
    
    /// The cell configuration block.
    func configure(with model: T)
}


extension ConfigurableCell {
    
    /// The cell identifier. Default is the class name.
    static var identifier: String {
        return String(describing: self)
    }
}

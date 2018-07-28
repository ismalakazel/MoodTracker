import Foundation


/**
 
 Enum case for HTTP method.
 
 */
enum Method: CustomStringConvertible {
    case get
    case post(Any?)
    case put(Any)
    case patch(Any)
    case delete
    
    /**
     
     CustomStringConvertible of the enum case.
    
     */
    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
    
    /**
    
     The body the request method.
 
     */
    var body: Any? {
        switch self {
        case .post(let o): return o
        case .put(let o): return o
        case .patch(let o): return o
        default: return nil
        }
    }
}

import UIKit


/**
 
 Cattle resource route.
 
 */
enum CattleRoute: RouteType {
    case list
    
    var description: (url: String, method: Method) {
        switch self {
        case .list: return ("List%20of%20cattle%20breeds", .get)
        }
    }
}


/**
 
 The description of a cattle breed.
 
 */
public struct Cattle: Serializable {
    let breed: String
    let imageUrl: String
    let subspecies: String
    let region: String
    let meat: Bool
    let dairy: Bool
    let draught: Bool
    let other: String
}

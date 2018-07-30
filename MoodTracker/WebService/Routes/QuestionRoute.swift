import UIKit


/**
 
 Cattle resource route.
 
 */
enum QuestionRoute: RouteType {
    case list
    
    var description: (url: String, method: Method) {
        switch self {
        case .list: return ("\(host)/1bagiq", .get)
        }
    }
}


/**
 
 The struct representation of a question object.
 
 */
public struct QuestionResponse: Serializable {
    let id: Int
    let text: String
    let answers: [AnswerResponse]
}


/**
 
 The struct representation of a answer object.
 
 */
public struct AnswerResponse: Serializable {
    let id: Int
    let text: String
    let weight: Int
}

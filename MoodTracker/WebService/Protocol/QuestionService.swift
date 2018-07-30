import Foundation


/**
 
 A protocol to manage cattle resources in the web service.
 
 */
protocol QuestionService { }


extension QuestionService {
    
    /**
     
     Fetch cattle breed list from Wikipedia.
     
     - parameter c: A callback with the serialized request result.
     
     */
    public func list(_ c: @escaping (Result<QuestionResponse>) -> ()) {
        Request<QuestionRoute, QuestionResponse>(route: .list, c).perform()
    }
}

import Foundation


/**
 
 A protocol to manage cattle resources in the web service.
 
 */
protocol WebServiceCattleManager { }


extension WebServiceCattleManager {
    
    /**
     
     Fetch cattle breed list from Wikipedia.
     
     - parameter c: A callback with the serialized request result.
     
     */
    public func list(_ c: @escaping (Result<Cattle>) -> ()) {
        Request<CattleRoute, Cattle>(route: .list, c).perform()
    }
}

import Foundation


/**
 
 A protocol to perform requests.
 
 */
protocol RequestType {
    
    /**
    
     The request response type.
     
     */
    associatedtype T: Serializable
    
    /**
   
     The request to be performed.
     
     */
    var request: URLRequest! { get }
    
    /**
    
     The request callback.
     
     */
    var callback: (Result<T>) -> () { get }
}


extension RequestType {
    
    /**
    
     Performs a URLSession request.
     
     - parameter RequestResult<T>: The result of the request where T: ResponseType
     
     */
    func perform() {
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            switch response.status {
            case .ok, .created: self.callback(.success(T.serialize(data)))
            case .unprocessable: self.callback(.error(.decode(from: data)))
            case .unauthorized: self.callback(.error(.decode(from: data)))
            default: break
            }
        }.resume()
    }
}

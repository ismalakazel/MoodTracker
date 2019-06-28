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
}


extension RequestType {
    
    /**
    
     Performs a URLSession request.
     
     - parameter RequestResult<T>: The result of the request where T: ResponseType
     
     */
    func perform(completionHandler: @escaping (Result<T, APIError>) -> ()) {
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else { return }
            switch response.status {
            case .ok, .created: completionHandler(.success(T.serialize(data)))
            case .unprocessable: completionHandler(.failure(.decode(from: data)))
            case .unauthorized: completionHandler(.failure(.decode(from: data)))
            default: break
            }
        }.resume()
    }
}

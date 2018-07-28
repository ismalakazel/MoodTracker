import Foundation


/**
 
 Request JSON content type.
 
 */
struct Request<R: RouteType, T: Serializable>: RequestType {
    
    var request: URLRequest!
    
    var callback: (Result<T>) -> () = { _ in }
    
    init(route: R, _ callback: @escaping (Result<T>) -> ()) {
        self.callback = callback
        self.request = URLRequest(url: URL(string: route.description.url)!)
        self.request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.request.httpMethod = route.description.method.description
        self.request.httpBody = route.description.method.body as? Data
        self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
}


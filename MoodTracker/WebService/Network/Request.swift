import Foundation


/**
 
 Request JSON content type.
 
 */
struct Request<R: RouteType, T: Serializable>: RequestType {
    
    private(set) var session: URLSession!
    private(set) var request: URLRequest!

    init(route: R, session: URLSession = .shared) {
        self.session = session
        request = URLRequest(url: URL(string: route.description.url)!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = route.description.method.description
        request.httpBody = route.description.method.body as? Data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
}


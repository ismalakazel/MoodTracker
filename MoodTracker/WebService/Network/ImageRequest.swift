import Foundation


/**
 
 Image upload request.
 
 */
struct ImageRequest<R: RouteType, T: Serializable>: RequestType {
    
    var request: URLRequest!
    
    var callback: (Result<T>) -> () = { _ in }
    
    init(route: R, _ callback: @escaping (Result<T>) -> ()) {
        self.callback = callback
        
        let boundary = "\(NSUUID().uuidString)"
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"upload\"; filename=\"image.jpeg\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(route.description.method.body as! Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        self.request = URLRequest(url: URL(string: route.description.url)!)
        self.request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.request.httpMethod = route.description.method.description
        self.request.httpBody = body
        self.request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        self.request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
}

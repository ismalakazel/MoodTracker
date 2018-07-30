import Foundation


protocol RouteType {
    var description: (url: String, method: Method) { get }
    var host: String { get }
}


extension RouteType {
    var host: String {
        return "https://api.myjson.com/bins"
    }
}

import Foundation


struct APIError: Error, Serializable {
    var title = "An error occurred"
    var message = "Please try again"
}


extension APIError {
    static func decode(from data: Data) -> APIError {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            return self.init()
        }
    }
}


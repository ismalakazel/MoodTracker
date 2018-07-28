import Foundation


public struct Error: Serializable {
    var title: String = "An error occurred"
    var message: String = "Please try again"
}

extension Error{
    static func decode(from data: Data) -> Error {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            return self.init()
        }
    }
}


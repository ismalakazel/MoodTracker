import Foundation


/**
 
 A protocol for serializable request responses.
 
 */
protocol Serializable: Decodable {
    static func serialize(_ data: Data) -> Self
}


extension Serializable {
    
    /**
     
     Serialize from data.
     
     */
    static func serialize(_ data: Data) -> Self {
        guard let serialized = try? JSONDecoder().decode(Self.self, from: data) else {
            let d = try! JSONSerialization.data(withJSONObject: [:], options: [])
            return try! JSONDecoder().decode(Self.self, from: d)
        }
        return serialized
    }
}

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
    }
    
    struct Current: Codable {
        let tempC: Double
        let condition: Condition
        let humidity: Int
        let windKph: Double
        let pressure_mb: Double
        
        enum CodingKeys: String, CodingKey {
            case tempC = "temp_c"
            case condition
            case humidity
            case windKph = "wind_kph"
            case pressure_mb = "pressure_mb"
        }
    }
    
    struct Condition: Codable {
        let text: String
        var icon: String

        
       
       
    }
}

import Foundation

protocol APIServiceProtocol {
    func fetchWeatherData(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    
    func fetchWeatherData(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let apiKey = "35c69ea68c2543dd966143300242011"
        let baseURL = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
    
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    completion(.success(results))
                    
                } catch {
                    completion(.failure(APIError.decodingError))
                }
            }
            
            task.resume()
        }
    }


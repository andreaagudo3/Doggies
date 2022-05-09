import Foundation

protocol APIManagerProtocol {
    func initRequest(with data: RequestProtocol) async throws -> Data
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    private let networkLogger: NetworkLogger
    
    init(urlSession: URLSession = URLSession.shared,
         networkLogger: NetworkLogger = DefaultNetworkLogger()) {
        self.urlSession = urlSession
        self.networkLogger = networkLogger
    }
    
    func initRequest(with data: RequestProtocol) async throws -> Data {
        networkLogger.log(request: try data.request())
        
        if #available(iOS 15.0, *) {
            let (data, response) = try await urlSession.data(for: data.request())
            networkLogger.log(responseData: data)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      networkLogger.log(error: data)
                      throw NetworkError.invalidServerResponse
                  }
            return data
        } else {
            guard let url = try data.request().url else {
                throw NetworkError.invalidURL
            }
            
            let (data, response) = try await urlSession.data(from: url)
            networkLogger.log(responseData: data)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      networkLogger.log(error: data)
                      throw NetworkError.invalidServerResponse
                  }
            return data
        }
        
    }
}

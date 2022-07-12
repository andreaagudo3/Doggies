public protocol RequestManagerProtocol {
    var apiManager: APIManagerProtocol { get }
    var parser: DataParserProtocol { get }
    func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T
}

public class RequestManager: RequestManagerProtocol {
	public let apiManager: APIManagerProtocol
    
	public init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
	public func initRequest<T: Decodable>(with data: RequestProtocol) async throws -> T {
        let data = try await apiManager.initRequest(with: data)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

// MARK: - Returns Data Parser
extension RequestManagerProtocol {
	public var parser: DataParserProtocol {
        return DataParser()
    }
}

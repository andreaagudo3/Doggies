import Foundation
import Networking

final class DefaultBreedsRepository {

    internal let requestManager: RequestManagerProtocol
    // TODO: Add cache storage

    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
}

extension DefaultBreedsRepository: BreedsRepository {
    func fetchAll() async throws -> Breeds {
        let requestData = BreedRequest.getBreeds
        do {
            let response: ApiResponse<Breeds> = try await requestManager.initRequest(with: requestData)
            return response.message
        } catch {
            DebugPrint.error(error.localizedDescription)
            throw error
        }
    }
    
    func fetchRandomImage(breed: String, count: Int) async throws -> [String] {
        let requestData = BreedRequest.getRandomImages(breed: breed, count: count)
        do {
            let response: ApiResponse<[String]> = try await requestManager.initRequest(with: requestData)
            return response.message
        } catch {
            DebugPrint.error(error.localizedDescription)
            throw error
        }
    }
}

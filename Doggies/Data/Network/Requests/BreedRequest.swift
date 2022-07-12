import Foundation
import Networking

enum BreedRequest: RequestProtocol {
    case getBreeds
    case getRandomImages(breed: String, count: Int)
    
	var host: String {
		AppConfiguration.getValue(.urlHost)
    }
    
    var path: String {
        switch self {
        case .getBreeds:
            return "/api/breeds/list/all"
        case .getRandomImages(let breed, let count):
            return "/api/breed/\(breed)/images/random/\(count)"
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}

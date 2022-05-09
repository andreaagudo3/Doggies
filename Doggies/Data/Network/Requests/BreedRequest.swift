import Foundation

enum BreedRequest: RequestProtocol {
    case getBreeds
    case getRandomImages(breed: String, count: Int)
    
    // TODO: Move to info plist
    var host: String {
        "dog.ceo"
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

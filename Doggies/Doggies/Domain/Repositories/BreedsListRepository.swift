import Foundation

protocol BreedsRepository {
    func fetchAll() async throws -> Breeds
    func fetchRandomImage(breed: String, count: Int) async throws -> [String]
}


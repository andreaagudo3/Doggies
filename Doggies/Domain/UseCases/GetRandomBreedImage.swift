protocol GetRandomBreedImage {
    func run(breed: String, count: Int) async throws -> [String]
}

final class DefaultGetRandomBreedImage: GetRandomBreedImage {
    private let repository: BreedsRepository
    
    init(repository: BreedsRepository) {
        self.repository = repository
    }
    
    func run(breed: String, count: Int) async throws -> [String] {
        try await repository.fetchRandomImage(breed: breed, count: count)
    }
}

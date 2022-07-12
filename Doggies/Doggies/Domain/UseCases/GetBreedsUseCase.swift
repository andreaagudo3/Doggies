import Foundation

protocol GetBreedsUseCase {
    func run() async throws -> Breeds
}

final class DefaultGetBreedsUseCase: GetBreedsUseCase {
    private let repository: BreedsRepository
    
    init(repository: BreedsRepository) {
        self.repository = repository
    }
    
    func run() async throws -> Breeds {
        try await repository.fetchAll()
    }
}

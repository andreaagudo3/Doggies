struct ApiResponse<T: Decodable>: Decodable {
    let message: T
    let status: String
}


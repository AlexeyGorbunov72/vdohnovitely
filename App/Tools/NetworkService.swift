import Foundation

final class NetworkService {

    private let urlSession = URLSession(configuration: .default)
    private let jsonDecoder = JSONDecoder()

    func fetch<T>(
        _ fuck: T.Type,
        for url: URL,
        priority: TaskPriority = .high
    ) async -> Result<T, Error> where T: Decodable {
        let task = Task(priority: priority) { () -> T in
            let request = URLRequest(url: url)
            let (data, _) = try await urlSession.data(for: request)
            let decoded = try jsonDecoder.decode(fuck, from: data)
            return decoded
        }

        do {
            let value = try await task.value
            return .success(value)
        } catch {
            return .failure(error)
        }
    }
}

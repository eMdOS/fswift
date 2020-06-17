import Foundation

// MARK: - Succes == Void | syntax-sugar

public extension Result where Success == Void {
    static func success() -> Self {
        .success(())
    }
}


// MARK: - Map | (Data, URLResponse)

public extension Result where Success == (data: Data, response: URLResponse) {
    func map<T>(_ keyPath: KeyPath<Success, T>) -> Result<T, Failure> {
        switch self {
        case .success(let response):
            return .success(response[keyPath: keyPath])
        case .failure(let error):
            return .failure(error)
        }
    }
}

// MARK: - Decoding

public protocol DecodableDataDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: DecodableDataDecoder {}
extension PropertyListDecoder: DecodableDataDecoder {}

public extension Result where Success == Data {
    func decode<T: Decodable>(_ type: T.Type, using decoder: DecodableDataDecoder) -> Result<T, Error> {
        do {
            return .success(try decoder.decode(type, from: try get()))
        } catch {
            return .failure(error)
        }
    }
}

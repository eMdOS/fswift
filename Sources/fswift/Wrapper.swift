
public protocol Wrapper {
    associatedtype Wrapped
    init(_ wrapped: Wrapped)
    var unwrap: Wrapped { get }
}

public extension Wrapper where Wrapped: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.unwrap == rhs.unwrap
    }
}

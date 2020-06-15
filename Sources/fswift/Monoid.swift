
// MARK: - Monoid

public protocol Monoid: Semigroup {
    static var empty: Self { get }
}

public func concat<M: Monoid>(_ elements: [M]) -> M {
    elements.reduce(.empty, <>)
}

// MARK: String

extension String: Monoid {
    public static let empty: String = ""
}

// MARK: Array

extension Array: Monoid {
    public static var empty: Array { [] }
}

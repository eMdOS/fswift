
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

// MARK: Optional

extension Optional: Monoid {
    public static var empty: Optional { nil }
}

// MARK: And

extension And: Monoid {
    public static let empty: And = true
}

// MARK: Or

extension Or: Monoid {
    public static let empty: Or = false
}

import Arrows

// MARK: - Pair

public struct Pair<First, Second> {
    public let first: First
    public let second: Second

    public init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
}

public extension Pair {
    func flip() -> Pair<Second, First> {
        Pair<Second, First>(second, first)
    }

    func fold<T>(_ transform: @escaping (First, Second) -> T) -> T {
        transform(first, second)
    }
}

extension Pair: Equatable where First: Equatable, Second: Equatable {
    public static func == (lhs: Pair, rhs: Pair) -> Bool {
        lhs.first == rhs.first && lhs.second == rhs.second
    }
}

// MARK: Pair | Semigroup

extension Pair: Semigroup where First: Semigroup, Second: Semigroup {
    public static func <> (left: Pair, right: Pair) -> Pair {
        Pair(left.first <> right.first, left.second <> right.second)
    }
}

// MARK: Pair | Monoid

extension Pair: Monoid where First: Monoid, Second: Monoid {
    public static var empty: Pair { Pair(.empty, .empty) }
}

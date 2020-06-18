
// MARK: - curry & uncurry

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        return { b in
            f(a, b)
        }
    }
}

public func uncurry<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { a, b in
        return f(a)(b)
    }
}

// MARK: - flipping

public func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    return { b, a in
        f(a, b)
    }
}

public func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in
        return { a in
            f(a)(b)
        }
    }
}

// MARK: - first & second

public func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
    return { pair in
        (f(pair.0), pair.1)
    }
}

public func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
    return { pair in
        (pair.0, f(pair.1))
    }
}

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

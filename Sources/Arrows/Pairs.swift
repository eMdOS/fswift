
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

// MARK: - Arrow

public func id<A>(_ a: A) -> A { a }

// MARK: Forward Composition

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication, FunctorPrecedence, ApplicativePrecedence
}

infix operator >>> : ForwardComposition

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { a in
        g(f(a))
    }
}

// MARK: Backward Composition

precedencegroup BackwardComposition {
    associativity: left
}

infix operator <<< : BackwardComposition

public func <<< <A, B, C>(g: @escaping (B) -> C, f: @escaping (A) -> B) -> (A) -> C {
    return { a in
        g(f(a))
    }
}

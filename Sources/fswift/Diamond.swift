
precedencegroup AssociativeComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <> : AssociativeComposition

public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> (A) -> A {
    return { a in
        g(f(a))
    }
}

public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

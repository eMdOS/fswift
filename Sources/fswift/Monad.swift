
precedencegroup MonadicPrecedenceLeft {
    associativity: left
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

precedencegroup MonadicPrecedenceRight {
    associativity: right
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

// MARK: -

infix operator >>= : MonadicPrecedenceLeft

public func >>= <A, B>(a: A?, f: @escaping (A) -> B?) -> B? {
    a.flatMap(f)
}

public func >>= <A, B>(a: [A], f: @escaping (A) -> [B]) -> [B] {
    a.flatMap(f)
}

public func >>= <A, B, E>(a: Result<A, E>, f: @escaping (A) -> Result<B, E>) -> Result<B, E> {
    a.flatMap(f)
}

// MARK: -

infix operator =<< : MonadicPrecedenceRight

public func =<< <A, B>(f: @escaping (A) -> B?, a: A?) -> B? {
    a.flatMap(f)
}

public func =<< <A, B>(f: @escaping (A) -> [B], a: [A]) -> [B] {
    a.flatMap(f)
}

public func =<< <A, B, E>(f: @escaping (A) -> Result<B, E>, a: Result<A, E>) -> Result<B, E> {
    a.flatMap(f)
}

// MARK: -

infix operator >=> : MonadicPrecedenceRight

public func >=> <A, B, C>(f: @escaping (A) -> B?, g: @escaping (B) -> C?) -> (A) -> C? {
    return { a in f(a) >>= g }
}

public func >=> <A, B, C>(f: @escaping (A) -> [B], g: @escaping (B) -> [C]) -> (A) -> [C] {
    return { a in f(a) >>= g }
}

public func >=> <A, B, C, E>(f: @escaping (A) -> Result<B, E>, g: @escaping (B) -> Result<C, E>) -> (A) -> Result<C, E> {
    return { a in f(a) >>= g }
}

// MARK: -

infix operator <=< : MonadicPrecedenceRight

public func <=< <A, B, C>(f: @escaping (B) -> C?, g: @escaping (A) -> B?) -> (A) -> C? {
    return { a in g(a) >>= f }
}

public func <=< <A, B, C>(f: @escaping (B) -> [C], g: @escaping (A) -> [B]) -> (A) -> [C] {
    return { a in g(a) >>= f }
}

public func <=< <A, B, V, E>(f: @escaping (B) -> Result<V, E>, g: @escaping (A) -> Result<B, E>) -> (A) -> Result<V, E> {
    return { a in g(a) >>= f }
}

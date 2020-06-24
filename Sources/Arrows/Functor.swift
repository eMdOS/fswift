
precedencegroup FunctorPrecedence {
    associativity: left
    lowerThan: NilCoalescingPrecedence
}

infix operator <^> : FunctorPrecedence

public func <^> <A, B>(f: @escaping (A) -> B, a: A) -> B {
    f(a)
}

// MARK: Optional

public func <^> <A, B>(f: @escaping (A) -> B, a: A?) -> B? {
    a.map(f)
}

public func map<A, B>(_ f: @escaping (A) -> B) -> (A?) -> B? {
    return { $0.map(f) }
}

// MARK: Array

public func <^> <A, B>(f: @escaping (A) -> B, a: [A]) -> [B] {
    a.map(f)
}

public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    return { $0.map(f) }
}

// MARK: Result

public func <^> <A, B, E>(f: @escaping (A) -> B, a: Result<A, E>) -> Result<B, E> {
    a.map(f)
}

public func map<A, B, E>(_ f: @escaping (A) -> B) -> (Result<A, E>) -> Result<B, E> {
    return { $0.map(f) }
}


precedencegroup ApplicativePrecedence {
    associativity: left
    lowerThan: NilCoalescingPrecedence
}

infix operator <*> : ApplicativePrecedence

// MARK: Optional

public extension Optional {
    func apply<U>(_ transform: ((Wrapped) -> U)?) -> U? {
        transform.flatMap { map($0) }
    }
}

public func <*> <A, B>(f: ((A) -> B)?, a: A?) -> B? {
    return a.apply(f)
}

// MARK: Array

public extension Array {
    func apply<U>(_ transform: [(Element) -> U]) -> [U] {
        transform.flatMap { map($0) }
    }
}

public func <*> <A, B>(f: [(A) -> B], a: [A]) -> [B] {
    return a.apply(f)
}

// MARK: Result

public extension Result {
    func apply<U>(_ transform: Result<(Success) -> U, Failure>) -> Result<U, Failure> {
        transform.flatMap { map($0) }
    }
}

public func <*> <A, B, E>(f: Result<(A) -> B, E>, a: Result<A, E>) -> Result<B, E> {
    a.apply(f)
}

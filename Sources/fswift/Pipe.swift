// MARK: - Pipe

// MARK: Forward Application

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |> : ForwardApplication

public func |> <A, B>(a: A, f: @escaping (A) -> B) -> B {
    f(a)
}

public func |> <A, B>(a: A?, f: @escaping (A) -> B) -> B? {
    a.map(f)
}

public func |> <A, B>(a: [A], f: @escaping (A) -> B) -> [B] {
    a.map(f)
}

public func |> <A, B, E: Swift.Error>(a: Result<A, E>, f: @escaping (A) -> B) -> Result<B, E> {
    a.map(f)
}

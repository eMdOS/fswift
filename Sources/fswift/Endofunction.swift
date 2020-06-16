
public struct Endofunction<A>: Wrapper {
    public var unwrap: (A) -> A

    public init(_ wrapped: @escaping (A) -> A) {
        unwrap = wrapped
    }

    public func transform(_ value: A) -> A {
        unwrap(value)
    }
}

extension Endofunction: Semigroup {
    public static func <> (left: Endofunction, right: Endofunction) -> Endofunction {
        Endofunction { right.transform(left.transform($0)) }
    }
}

extension Endofunction: Monoid {
    public static var empty: Endofunction { Endofunction { $0 } }
}

import Arrows

public struct Function<A, B>: Wrapper {
    public let unwrap: (A) -> B

    public init(_ wrapped: @escaping (A) -> B) {
        unwrap = wrapped
    }

    public func transform(_ value: A) -> B {
        unwrap(value)
    }
}

extension Function: Semigroup where B: Semigroup {
    public static func <> (left: Function, right: Function) -> Function {
        Function { left.transform($0) <> right.transform($0) }
    }
}

extension Function: Monoid where B: Monoid {
    public static var empty: Function { Function { _ in .empty } }
}

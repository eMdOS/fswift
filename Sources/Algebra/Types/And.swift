
public struct And: Wrapper {
    public let unwrap: Bool

    public init(_ wrapped: Bool) {
        unwrap = wrapped
    }
}

extension And: Equatable {}

extension And: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self.init(value)
    }
}

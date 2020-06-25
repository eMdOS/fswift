
public struct Or: Wrapper {
    public let unwrap: Bool

    public init(_ wrapped: Bool) {
        unwrap = wrapped
    }
}

extension Or: Equatable {}

extension Or: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self.init(value)
    }
}

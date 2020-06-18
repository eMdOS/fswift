
precedencegroup AlternativePrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    lowerThan: ComparisonPrecedence
}

infix operator <|> : AlternativePrecedence

// MARK: - Result

public extension Result {
    func or(_ alternative: @autoclosure () -> Result<Success, Failure>) -> Result<Success, Failure> {
        switch self {
        case .success:
            return self
        case .failure:
            return alternative()
        }
    }
}

public func <|> <A, E>(left: Result<A, E>, right: @autoclosure () -> Result<A, E>) -> Result<A, E> {
    left.or(right())
}

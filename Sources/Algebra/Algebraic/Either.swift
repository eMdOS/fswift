import Arrows

// MARK: - Either

public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

// MARK: flip

public extension Either {
    func flip() -> Either<Right, Left> {
        switch self {
        case .left(let newRight):
            return .right(newRight)
        case .right(let newLeft):
            return .left(newLeft)
        }
    }
}

// MARK: fold

public extension Either {
    func fold<Value>(
        _ onLeft: (Left) -> Value,
        _ onRight: (Right) -> Value
    ) -> Value {
        switch self {
        case .left(let left):
            return onLeft(left)
        case .right(let right):
            return onRight(right)
        }
    }

    func fold<SubVlaue>(
        _ leftKeyPath: KeyPath<Left, SubVlaue>,
        _ rightKeyPath: KeyPath<Right, SubVlaue>
    ) -> SubVlaue {
        switch self {
        case .left(let left):
            return left[keyPath: leftKeyPath]
        case .right(let right):
            return right[keyPath: rightKeyPath]
        }
    }
}

// MARK: left side

public extension Either {
    var isLeft: Bool {
        switch self {
        case .left: return true
        case .right: return false
        }
    }

    var left: Left? {
        guard case .left(let left) = self else {
            return nil
        }
        return left
    }
}

// MARK: right side

public extension Either {
    var isRight: Bool {
        switch self {
        case .right: return true
        case .left: return false
        }
    }

    var right: Right? {
        guard case .right(let right) = self else {
            return nil
        }
        return right
    }
}

// MARK: Equatable

extension Either: Equatable where Left: Equatable, Right: Equatable {
    public static func == (lhs: Either, rhs: Either) -> Bool {
        switch (lhs, rhs) {
        case (.left(let leftValue), .left(let rightValue)):
            return leftValue == rightValue
        case (.right(let leftValue), .right(let rightValue)):
            return leftValue == rightValue
        default:
            return false
        }
    }
}

// MARK: Hashable

extension Either: Hashable where Left: Hashable, Right: Hashable {}

// MARK: map | functor

public extension Either {
    func leftMap<NewLeft>(
        _ transform: (Left) -> NewLeft
    ) -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            return .left(transform(value))
        case .right(let value):
            return .right(value)
        }
    }

    func leftMap<LeftSubValue>(
        _ keyPath: KeyPath<Left, LeftSubValue>
    ) -> Either<LeftSubValue, Right> {
        leftMap { $0[keyPath: keyPath] }
    }

    func rightMap<NewRight>(
        _ transform: (Right) -> NewRight
    ) -> Either<Left, NewRight> {
        switch self {
        case .right(let value):
            return .right(transform(value))
        case .left(let value):
            return .left(value)
        }
    }

    func rightMap<RightSubValue>(
        _ keyPath: KeyPath<Right, RightSubValue>
    ) -> Either<Left, RightSubValue> {
        rightMap { $0[keyPath: keyPath] }
    }
}

// MARK: apply | applicative

public extension Either {
    func leftApply<NewLeft>(
        _ transform: Either<(Left) -> NewLeft, Right>
    ) -> Either<NewLeft, Right> {
        switch transform {
        case .left(let transform):
            return leftMap(transform)
        case .right(let value):
            return .right(value)
        }
    }

    func rightApply<NewRight>(
        _ transform: Either<Left, (Right) -> NewRight>
    ) -> Either<Left, NewRight> {
        switch transform {
        case .left(let value):
            return .left(value)
        case .right(let transform):
            return rightMap(transform)
        }
    }
}

// MARK: flatMap | monad

public extension Either {
    func leftFlatMap<NewLeft>(
        _ transform: (Left) -> Either<NewLeft, Right>
    ) -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            return transform(value)
        case .right(let value):
            return .right(value)
        }
    }

    func rightFlatMap<NewRight>(
        _ transform: (Right) -> Either<Left, NewRight>
    ) -> Either<Left, NewRight> {
        switch self {
        case .right(let value):
            return transform(value)
        case .left(let value):
            return .left(value)
        }
    }
}

// MARK: Semigroup

extension Either: Semigroup where Left: Semigroup, Right: Semigroup {
    public static func <> (left: Either, right: Either) -> Either {
        switch (left, right) {
        case (.right(let leftValue), .right(let rightValue)):
            return .right(leftValue <> rightValue)
        case (.right(let leftValue), .left):
            return .right(leftValue)
        case (.left, .right(let rightValue)):
            return .right(rightValue)
        case (.left(let leftValue), .left(let rightValue)):
            return .left(leftValue <> rightValue)
        }
    }
}

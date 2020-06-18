
public enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

public extension Either {
    var isLeft: Bool {
        switch self {
        case .left:
            return true
        case .right:
            return false
        }
    }

    var left: Left? {
        guard case .left(let left) = self else {
            return nil
        }
        return left
    }

    var isRight: Bool {
        switch self {
        case .right:
            return true
        case .left:
            return false
        }
    }

    var right: Right? {
        guard case .right(let right) = self else {
            return nil
        }
        return right
    }
}

public extension Either {
    func flip() -> Either<Right, Left> {
        switch self {
        case .left(let newRight):
            return .right(newRight)
        case .right(let newLeft):
            return .left(newLeft)
        }
    }

    func fold<T>(_ onLeft: (Left) -> T, _ onRight: (Right) -> T) -> T {
        switch self {
        case .left(let left):
            return onLeft(left)
        case .right(let right):
            return onRight(right)
        }
    }
}

// MARK: - map

public extension Either {
    func leftMap<NewLeft>(_ transform: (Left) -> NewLeft) -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            return .left(transform(value))
        case .right(let value):
            return .right(value)
        }
    }

    func rightMap<NewRight>(_ transform: (Right) -> NewRight) -> Either<Left, NewRight> {
        switch self {
        case .right(let value):
            return .right(transform(value))
        case .left(let value):
            return .left(value)
        }
    }
}

// MARK: - apply

public extension Either {
    func leftApply<NewLeft>(_ transform: Either<(Left) -> NewLeft, Right>) -> Either<NewLeft, Right> {
        switch transform {
        case .left(let transform):
            return leftMap(transform)
        case .right(let value):
            return .right(value)
        }
    }

    func rightApply<NewRight>(_ transform: Either<Left, (Right) -> NewRight>) -> Either<Left, NewRight> {
        switch transform {
        case .left(let value):
            return .left(value)
        case .right(let transform):
            return rightMap(transform)
        }
    }
}

// MARK: - flatMap

public extension Either {
    func leftFlatMap<NewLeft>(_ transform: (Left) -> Either<NewLeft, Right>) -> Either<NewLeft, Right> {
        switch self {
        case .left(let value):
            return transform(value)
        case .right(let value):
            return .right(value)
        }
    }


    func rightFlatMap<NewRight>(_ transform: (Right) -> Either<Left, NewRight>) -> Either<Left, NewRight> {
        switch self {
        case .right(let value):
            return transform(value)
        case .left(let value):
            return .left(value)
        }
    }
}

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

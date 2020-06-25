import Arrows

// MARK: - Semigroup

public protocol Semigroup {
    static func <> (left: Self, right: Self) -> Self
}

public func concat<S: Semigroup>(_ initial: S, _ elements: [S]) -> S {
    elements.reduce(initial, <>)
}

// MARK: String

extension String: Semigroup {
    public static func <> (left: String, right: String) -> String {
        left + right
    }
}

// MARK: Array

extension Array: Semigroup {
    public static func <> (left: Array, right: Array) -> Array {
        left + right
    }
}

// MARK: Optional

extension Optional: Semigroup {
    public static func <> (left: Optional, right: Optional) -> Optional {
        left ?? right
    }
}

// MARK: And

extension And: Semigroup {
    public static func <> (left: And, right: And) -> And {
        And(left.unwrap && right.unwrap)
    }
}

// MARK: Or

extension Or: Semigroup {
    public static func <> (left: Or, right: Or) -> Or {
        Or(left.unwrap || right.unwrap)
    }
}

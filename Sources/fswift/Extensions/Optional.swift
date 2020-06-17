
// MARK: - Fallback & Error Throwing

public extension Optional {
    func or(_ fallback: @autoclosure () -> Wrapped) -> Wrapped {
        guard let unwrappedValue = self else {
            return fallback()
        }
        return unwrappedValue
    }

    func orThrow(_ error: @autoclosure () -> Error) throws -> Wrapped {
        guard let unwrappedValue = self else {
            throw error()
        }
        return unwrappedValue
    }
}

// MARK: - Transforming

public extension Optional {
    func map<T>(_ keyPath: KeyPath<Wrapped, T>) -> T? {
        map { $0[keyPath: keyPath] }
    }

    func flatMap<T>(_ keyPath: KeyPath<Wrapped, T?>) -> T? {
        flatMap { $0[keyPath: keyPath] }
    }
}

public extension Optional where Wrapped: ExpressibleByNilLiteral {
    func flatten() -> Wrapped {
        switch self {
        case .some(let unwraped):
            return unwraped
        case .none:
            return nil
        }
    }
}

// MARK: - Filtering

public extension Optional {
    func filter(when predicate: (Wrapped) -> Bool) -> Self {
        guard let unwrappedValue = self, predicate(unwrappedValue) else {
            return nil
        }
        return unwrappedValue
    }

    func filter(when keyPath: KeyPath<Wrapped, Bool>) -> Self {
        guard let matches = map({ $0[keyPath: keyPath] }), matches else {
            return nil
        }
        return self
    }

    func filter(when predicate: Predicate<Wrapped>) -> Self {
        guard let unwrappedValue = self, predicate.transform(unwrappedValue) else {
            return nil
        }
        return unwrappedValue
    }
}

// MARK: - Side effects

public extension Optional {
    @discardableResult
    func then(_ function: (Wrapped) -> Void) -> Self {
        guard let unwrappedValue = self else {
            return nil
        }
        function(unwrappedValue)
        return self
    }
}

// MARK: - Nullability Handling

public extension Optional {
    var isNil: Bool {
        self == nil
    }

    var isNotNil: Bool {
        !isNil
    }
}

// MARK: - When String

public extension Optional where Wrapped == String {
    var orEmpty: String {
        or(.empty)
    }

    var isNilOrEmpty: Bool {
        guard let unwrappedValue = self else {
            return true
        }
        return unwrappedValue.isEmpty
    }

    var isNotNilOrEmpty: Bool {
        !isNilOrEmpty
    }
}

// MARK: - When Collection

public extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        guard let unwrappedValue = self else {
            return true
        }
        return unwrappedValue.isEmpty
    }

    var isNotNilOrEmpty: Bool {
        !isNilOrEmpty
    }
}

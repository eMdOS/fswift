
public extension Array {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

// MARK: - Filtering

public extension Array {
    func firstIndex(where keyPath: KeyPath<Element, Bool>) -> Int? {
        firstIndex(where: { $0[keyPath: keyPath] })
    }

    func last(where keyPath: KeyPath<Element, Bool>) -> Element? {
        last(where: { $0[keyPath: keyPath] })
    }

    func lastIndex(where keyPath: KeyPath<Element, Bool>) -> Int? {
        lastIndex(where: { $0[keyPath: keyPath] })
    }
}

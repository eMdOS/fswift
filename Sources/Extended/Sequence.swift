
// MARK: - Transforming

public extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    func flatMap<T>(_ keyPath: KeyPath<Element, [T]>) -> [T] {
        flatMap { $0[keyPath: keyPath] }
    }

    func compactMap<T>(_ keyPath: KeyPath<Element, T?>) -> [T] {
        compactMap { $0[keyPath: keyPath] }
    }
}

// MARK: - Filtering

public extension Sequence {
    func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
        filter { $0[keyPath: keyPath] }
    }

    func first(where keyPath: KeyPath<Element, Bool>) -> Element? {
        first(where: { $0[keyPath: keyPath] })
    }
}

// MARK: - Ordering

public extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { first, second in
            first[keyPath: keyPath] < second[keyPath: keyPath]
        }
    }

    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        ordering areInIncreasingOrder: (T, T) -> Bool
    ) -> [Element] {
        sorted { first, second in
            areInIncreasingOrder(first[keyPath: keyPath], second[keyPath: keyPath])
        }
    }
}

// MARK: - Grouping

public extension Sequence {
    func grouped<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [T: [Element]] {
        Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
    }
}

// MARK: - Duplicate Removing

public extension Sequence where Iterator.Element: Equatable {
    func withoutDuplicates() -> [Iterator.Element] {
        reduce([]) { sequence, element in
            sequence.contains(element) ? sequence : sequence + [element]
        }
    }
}

public extension Sequence where Iterator.Element: Equatable & Hashable {
    func withoutDuplicates() -> [Iterator.Element] {
        var dictionary: [Element: Bool] = [:]
        return filter {
            dictionary.updateValue(true, forKey: $0) == .none
        }
    }
}

import fswift

enum Law<Element: Equatable> {
    static func isAssociative(a: Element, b: Element, c: Element, operation: (Element, Element) -> Element) -> Bool {
        // a <> (b <> c) = (a <> b) <> c
        operation(a, operation(b, c)) == operation(operation(a, b), c)
    }

    static func hasNeutralIdentity(empty: Element, a: Element, operation: (Element, Element) -> Element) -> Bool {
        // empty <> a = a = a <> empty
        operation(empty, a) == a && a == operation(a, empty)
    }
}

extension Law where Element: Semigroup {
    static func isAssociative(a: Element, b: Element, c: Element) -> Bool {
        isAssociative(a: a, b: b, c: c, operation: <>)
    }
}

extension Law where Element: Monoid {
    static func hasNeutralIdentity(a: Element) -> Bool {
        hasNeutralIdentity(empty: .empty, a: a, operation: <>)
    }
}

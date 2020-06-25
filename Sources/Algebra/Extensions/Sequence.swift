
public extension Sequence {
    func filter(by predicate: Predicate<Iterator.Element>) -> [Iterator.Element] {
        filter({ predicate.transform($0) })
    }

    func filtered(by predicate: PredicateAnd<Iterator.Element>) -> [Iterator.Element] {
        filter({ predicate.transform($0).unwrap })
    }

    func filtered(by predicate: PredicateOr<Iterator.Element>) -> [Iterator.Element] {
        filter({ predicate.transform($0).unwrap })
    }
}

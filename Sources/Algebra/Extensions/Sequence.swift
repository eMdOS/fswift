
public extension Sequence {
    func filter(by predicate: Predicate<Iterator.Element>) -> [Iterator.Element] {
        filter({ predicate.transform($0) })
    }
}

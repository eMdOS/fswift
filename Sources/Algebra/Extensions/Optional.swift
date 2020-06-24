
public extension Optional {
    func filter(when predicate: Predicate<Wrapped>) -> Self {
        guard let unwrappedValue = self, predicate.transform(unwrappedValue) else {
            return nil
        }
        return unwrappedValue
    }
}

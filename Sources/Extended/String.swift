
public extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }

    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

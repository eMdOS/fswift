import XCTest
import fswift

final class SemigroupTests: XCTestCase {
    func test_semigroup_concat() {
        XCTAssertEqual("abc", concat(.empty, ["a", "b", "c"]))
    }

    func test_string_isSemigroup() {
        XCTAssert(Law<String>.isAssociative(a: "a", b: "b", c: "c"))
    }

    func test_array_isSemigroup() {
        XCTAssert(Law<[String]>.isAssociative(a: ["a"], b: ["b"], c: ["c"]))
    }
}

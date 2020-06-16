import XCTest
import fswift

final class MonoidTests: XCTestCase {
    func test_monoid_concat() {
        XCTAssertEqual("abc", concat(["a", "b", "c"]))
    }

    func test_string_isMonoid() {
        XCTAssert(Law<String>.hasNeutralIdentity(a: "a"))
    }

    func test_array_isMonoid() {
        XCTAssert(Law<[String]>.hasNeutralIdentity(a: ["a"]))
    }
}

import XCTest
import Algebra

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

    func test_optional_isMonoid() {
        XCTAssert(Law<String?>.hasNeutralIdentity(a: "a"))
    }

    func test_and_isMonoid() {
        XCTAssert(Law<And>.hasNeutralIdentity(a: true))
        XCTAssert(Law<And>.hasNeutralIdentity(a: false))
    }

    func test_or_isMonoid() {
        XCTAssert(Law<Or>.hasNeutralIdentity(a: true))
        XCTAssert(Law<Or>.hasNeutralIdentity(a: false))
    }
}

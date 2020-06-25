import XCTest
import Algebra

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

    func test_optional_isSemigroup() {
        XCTAssert(Law<String?>.isAssociative(a: "a", b: "b", c: "c"))
    }

    func test_and_isSemigroup() {
        XCTAssert(Law<And>.isAssociative(a: true, b: true, c: true))
        XCTAssert(Law<And>.isAssociative(a: false, b: false, c: false))

        XCTAssert(Law<And>.isAssociative(a: true, b: true, c: false))
        XCTAssert(Law<And>.isAssociative(a: true, b: false, c: false))

        XCTAssert(Law<And>.isAssociative(a: false, b: true, c: true))
        XCTAssert(Law<And>.isAssociative(a: false, b: true, c: false))

        XCTAssert(Law<And>.isAssociative(a: false, b: false, c: true))
        XCTAssert(Law<And>.isAssociative(a: true, b: false, c: true))
    }

    func test_or_isSemigroup() {
        XCTAssert(Law<Or>.isAssociative(a: true, b: true, c: true))
        XCTAssert(Law<Or>.isAssociative(a: false, b: false, c: false))

        XCTAssert(Law<Or>.isAssociative(a: true, b: true, c: false))
        XCTAssert(Law<Or>.isAssociative(a: true, b: false, c: false))

        XCTAssert(Law<Or>.isAssociative(a: false, b: true, c: true))
        XCTAssert(Law<Or>.isAssociative(a: false, b: true, c: false))

        XCTAssert(Law<Or>.isAssociative(a: false, b: false, c: true))
        XCTAssert(Law<Or>.isAssociative(a: true, b: false, c: true))
    }
}

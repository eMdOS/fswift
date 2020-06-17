import XCTest
import fswift

final class OptionalTests: XCTestCase {
    struct ErrorStub: Swift.Error {}

    struct Stub {
        let optionalString: String? = "optional"
        let nonOptionalString: String = "non-optional"
        let testTrue = true
        let testFalse = false
    }

    let stub: Stub? = .init()

    let nilString: String? = nil
    let nonNilString: String? = "non-nil"
    let emptyString: String? = String.empty

    let nilCollection: [Int]? = nil
    let nonNilCollection: [Int]? = [0]
    let emptyCollection: [Int]? = .empty
}

extension OptionalTests {
    func test_orFallback() {
        let fallbackString = "fallback"

        XCTAssertEqual(fallbackString, nilString.or(fallbackString))
        XCTAssertEqual(nonNilString, nonNilString.or(fallbackString))
    }

    func test_orThrow() {
        // then
        XCTAssertThrowsError(try nilString.orThrow(ErrorStub()))
        XCTAssertNoThrow(try nonNilString.orThrow(ErrorStub()))
    }

    func test_isNil() {
        XCTAssertTrue(nilString.isNil)
        XCTAssertFalse(nonNilString.isNil)
    }

    func test_isNotNil() {
        XCTAssertFalse(nilString.isNotNil)
        XCTAssertTrue(nonNilString.isNotNil)
    }

    func test_orEmpty() {
        XCTAssertEqual(String.empty, nilString.orEmpty)
        XCTAssertEqual("non-nil", nonNilString.orEmpty)
    }

    func test_isNilOrEmpty() {
        // when Wrapped == String
        XCTAssertTrue(nilString.isNilOrEmpty)
        XCTAssertTrue(emptyString.isNilOrEmpty)
        XCTAssertFalse(nonNilString.isNilOrEmpty)
        // when Wrapped == Collection
        XCTAssertTrue(nilCollection.isNilOrEmpty)
        XCTAssertTrue(emptyCollection.isNilOrEmpty)
        XCTAssertFalse(nonNilCollection.isNilOrEmpty)
    }

    func test_isNotNilOrEmpty() {
        // when Wrapped == String
        XCTAssertTrue(nonNilString.isNotNilOrEmpty)
        XCTAssertFalse(nilString.isNotNilOrEmpty)
        XCTAssertFalse(emptyString.isNotNilOrEmpty)
        // when Wrapped == Collection
        XCTAssertTrue(nonNilCollection.isNotNilOrEmpty)
        XCTAssertFalse(nilCollection.isNotNilOrEmpty)
        XCTAssertFalse(emptyCollection.isNotNilOrEmpty)
    }

    func test_then() {
        let called = expectation(description: "called")
        let notCalled = expectation(description: "not called")
        notCalled.isInverted = true

        nonNilString.then { _ in called.fulfill() }
        nilString.then { _ in notCalled.fulfill() }

        wait(for: [called, notCalled], timeout: 0.1)
    }

    func test_map_by_keyPath() {
        XCTAssertEqual("non-optional", stub.map(\.nonOptionalString))
    }

    func test_flatMap_by_keyPath() {
        XCTAssertEqual("optional", stub.flatMap(\.optionalString))
    }

    func test_filterWhen_predicate() {
        XCTAssertNil(stub.filter(when: { $0.testFalse }))
        XCTAssertNotNil(stub.filter(when: { $0.testTrue }))

        let predicateFalse = Predicate<Stub> { _ in false }
        XCTAssertNil(stub.filter(when: predicateFalse))

        let predicateTrue = Predicate<Stub> { _ in true }
        XCTAssertNotNil(stub.filter(when: predicateTrue))
    }

    func test_filterWhen_keyPath() {
        XCTAssertNil(stub.filter(when: \.testFalse))
        XCTAssertNotNil(stub.filter(when: \.testTrue))
    }
}

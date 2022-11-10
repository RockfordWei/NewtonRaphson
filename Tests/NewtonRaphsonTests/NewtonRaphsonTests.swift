import Foundation
import XCTest
@testable import NewtonRaphson

enum Exception: Error {
    case divideByZero
}

// swiftlint:disable identifier_name
final class NewtonRaphsonTests: XCTestCase {
    func _squareSum(x: Int) -> Double {
        let y = x * (x + 1) * (2 * x + 1) / 6
        return Double(y)
    }
    func _testPyramid(layers: Int) throws -> Int {
        let volume = _squareSum(x: layers)
        let initialValue = Double(cbrt(CGFloat(volume * 6)))
        let solver = NewtonRaphson(
            initialValue: initialValue,
            function: { x in
                return 2 * x * x * x + 3 * x * x + x - 6 * volume
            }, differential: { x in
                return 6 * x * x + 6 * x + 1
            })
        let result = try solver.solve()
        guard let x = result.x else {
            throw Exception.divideByZero
        }
        XCTAssertEqual(Int(x.rounded()), layers)
        NSLog("layers = \(layers), steps = \(result.steps)")
        return result.steps
    }
    func testSimple() throws {
        let solver = NewtonRaphson(
            initialValue: 1, function: { x in
                return x * x + 2 * x
            }, differential: { x in
                return 2 * x + 2
            })
        let result = try solver.solve()
        XCTAssertEqual(result.x, 0)
    }
    func testPyramid() throws {
        var _max = 0
        for x in 1..<10_000 {
            let steps = try _testPyramid(layers: x)
            _max = max(_max, steps)
        }
        NSLog("max steps = \(_max)")
    }
}

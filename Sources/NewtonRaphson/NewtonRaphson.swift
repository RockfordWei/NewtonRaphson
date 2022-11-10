/**
 [Newton Raphson Method to solve an equation](https://en.wikipedia.org/wiki/Newton%27s_method)
 Assuming f(x) = x^ + 2x, so the differential function f'(x) = 2x + 2
 giving an initial value of x0 = 1, so the equation can be solved by this snippet:
 ```swift
 let solver = NewtonRaphson(
    initialValue: 1,
    function: { x in
        return x * x + 2 * x
    }, differential: { x in
        return 2 * x + 2
    })
 let result = try solver.solve()
 XCTAssertEqual(result.x, 0)
 ```
 **/
public struct NewtonRaphson {

    /// function type, y = f(x)
    public typealias Function = (Double) -> Double
    /// solution type. x == nil means  f'(x) = 0 caused a division by zero
    /// steps is an optional output to indicate how many steps used by this solution
    public typealias Solution = (x: Double?, steps: Int)
    internal let initialValue: Double
    internal let error: Double
    internal let function: Function
    internal let differential: Function

    /// initialize a Newton Raphson equation solver
    /// - parameter initialValue: a preset (random) value of the equation
    /// - parameter error: error control
    /// - parameter function: the function of the equation - f(x)
    /// - parameter differential: the differential function of the equaltion f'(x)
    init(initialValue: Double = 0,
         error: Double = 1e-16,
         function: @escaping Function,
         differential: @escaping Function) {
        self.initialValue = initialValue
        self.error = error
        self.function = function
        self.differential = differential
    }
    // swiftlint:disable identifier_name
    /// solve the equation
    /// - returns: a solution
    public func solve() throws -> Solution {
        var x = initialValue
        var e = Double.infinity
        var steps = 0
        repeat {
            let delta = differential(x)
            guard abs(delta) > error else {
                return (nil, steps)
            }
            let y = x - function(x) / delta
            e = abs(x - y)
            x = y
            steps += 1
        } while e > error
        return (x: x, steps: steps)
    }
}

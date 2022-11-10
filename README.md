# NewtonRaphson

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

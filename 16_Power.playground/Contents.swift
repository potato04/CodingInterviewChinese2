//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题16：数值的整数次方
// 题目：实现函数double Power(double base, int exponent)，求base的exponent
// 次方。不得使用库函数，同时不需要考虑大数问题。

import Foundation
import XCTest

class Solution {
    /**
     主要考察代码规范性、完整性
     需要考虑exponent为0、负数的情况以及错误处理
     - parameters:
        - base：底数
        - exponent: 指数
      - Returns: 如果无法求值，返回nil，否者返回double类型数据
     */
    func pow(_ base: Double, exponent: Int) -> Double? {
        if base == 0  && exponent < 0 {
            return nil
        }
        let absExp = exponent < 0 ? -exponent : exponent
        var result = powExp(base, exponent: absExp)
        if exponent < 0 {
            result = 1 / result
        }
        return result
    }
    private func powExp(_ base: Double, exponent: Int) -> Double{
        if exponent == 0 {
            return 1
        }
        if exponent == 1 {
            return base
        }
        
        var result = powExp(base, exponent: exponent / 2)
        result *= result
        if exponent % 2 == 1 {
            result *= base
        }
        return result
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //底数2，指数3，结果8
    func testCase1() {
        XCTAssertEqual(solution.pow(2, exponent: 3), 8)
    }
    //底数-2，指数3，结果-8
    func testCase2() {
        XCTAssertEqual(solution.pow(-2, exponent: 3), -8)
    }
    //底数2，指数-3，结果0.125
    func testCase3() {
        XCTAssertEqual(solution.pow(2, exponent: -3), 1/8)
    }
    //底数2，指数0，结果1
    func testCase4() {
        XCTAssertEqual(solution.pow(2, exponent: 0), 1)
    }
    //底数0，指数0，结果1
    func testCase5() {
        XCTAssertEqual(solution.pow(0, exponent: 0), 1)
    }
    //底数0，指数4，结果0
    func testCase6() {
        XCTAssertEqual(solution.pow(0, exponent: 4), 0)
    }
    //底数0，指数-4，结果nil
    func testCase7() {
        XCTAssertEqual(solution.pow(0, exponent: -4), nil)
    }
    
}

UnitTests.defaultTestSuite.run()







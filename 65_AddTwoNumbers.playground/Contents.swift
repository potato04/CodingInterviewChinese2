//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题65：不用加减乘除做加法
// 题目：写一个函数，求两个整数之和，要求在函数体内不得使用＋、－、×、÷
// 四则运算符号。
import Foundation
import XCTest

class Solution1 {
    /*
     不使用加减乘除做加法
     - Parameters:
        - num1: 数字1
        - num2: 数字2
     - Returns: 两数之和
     解法：num1^num2 = num1+num2（不考虑进位），进位计算： (num1 & num2) << 1  
     */
    func sum(num1:Int, with num2:Int) -> Int {
        var num1 = num1
        var num2 = num2
        repeat {
            let sum = num1 ^ num2
            let carry = (num1 & num2) << 1
            num1 = sum
            num2 = carry
        } while (num2 != 0);
        return num1
    }
}

class UnitTests: XCTestCase {
    let solution1 = Solution1()
    override func setUp() {
        super.setUp()
    }
    func testCase1() {
        XCTAssertEqual(3, solution1.sum(num1: 1, with: 2))
        XCTAssertEqual(1010, solution1.sum(num1: 111, with: 899))
        XCTAssertEqual(-1, solution1.sum(num1: 1, with: -2))
        XCTAssertEqual(3, solution1.sum(num1: 3, with: 0))
        XCTAssertEqual(-4, solution1.sum(num1: -4, with: 0))
        XCTAssertEqual(-10, solution1.sum(num1: -2, with: -8))
    }
}

UnitTests.defaultTestSuite.run()

//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题10：斐波那契数列
// 题目：写一个函数，输入n，求斐波那契（Fibonacci）数列的第n项。

import Foundation
import XCTest

class Solution {
    /**
     求斐波那契数列中的第n个元素（递归方式-效率低）
     - Parameters:
        - n: n
     - Returns: 第n个斐波那契数列的值
     */
    func recursion(_ n: Int) -> Int{
        if n <= 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        return recursion(n - 1) + recursion(n - 2)
    }
    /**
     求斐波那契数列中的第n个元素（循环方式-效率较高）
     - Parameters:
        - n: n
     - Returns: 第n个斐波那契数列的值
     */
    func loop(_ n: Int) -> Int {
        if n <= 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        var num1 = 0
        var num2 = 1
        for _ in 2...n {
            let sum = num1 + num2
            num1 = num2
            num2 = sum
        }
        return num2
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    private func test(_ n: Int, expected: Int) {
        XCTAssertEqual(solution.loop(n), expected)
        XCTAssertEqual(solution.recursion(n), expected)
    }
    func testCase1() {
        test(0, expected: 0)
        test(1, expected: 1)
        test(2, expected: 1)
        test(3, expected: 2)
        test(4, expected: 3)
        test(5, expected: 5)
        test(6, expected: 8)
        test(7, expected: 13)
        test(8, expected: 21)
        test(9, expected: 34)
        test(10, expected: 55)
        test(20, expected: 6765)
        //再往上测试，通过递归的方式，电脑CPU就转的不行了😓
    }
}

UnitTests.defaultTestSuite.run()

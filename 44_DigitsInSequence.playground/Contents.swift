//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题44：数字序列中某一位的数字
// 题目：数字以0123456789101112131415…的格式序列化到一个字符序列中。在这
// 个序列中，第5位（从0开始计数）是5，第13位是1，第19位是4，等等。请写一
// 个函数求任意位对应的数字。

import Foundation
import XCTest

class Solution {
    
    /**
     数字以0123456789101112131415…的格式序列化到一个字符序列中。求第index位的数字
     - Parameters:
        - index: index
     - Returns: 对应的数字
     */
    func digitAtIndex(_ index: Int) -> Int? {
        if index < 0 { return nil }
        var index = index
        var digits = 1
        while true {
            let numbers = countOfIntegers(with: digits)
            if index < numbers * digits {
                return digitAtIndex(index, digits)
            }
            index -= digits * numbers
            digits += 1
        }
    }
    
    /**
     根据digits位数 返回整数个数
     例如1位数字的整数有10个（0-9)
        2位数字的整数有90个 (10-99)
        3位数字的整数有900个(100-999)
     - Parameters:
        - digits: 位数
     - Returns: 位数是digits的整数个数
     */
    private func countOfIntegers(with digits: Int) -> Int {
        if digits == 1 { return 10 }
        return 9 * Int(pow(Double(10), Double(digits - 1)))
    }
    
    /**
     以digits位数的整数第一个数字的字符序列开始，取第index位的数字
     - Parameters:
        - index: 第index位
        - digits: 整数位数
     - Returns: digits位整数开始第index位数字
     */
    private func digitAtIndex(_ index: Int, _ digits: Int) -> Int {
        var number = beginNumber(digits) + index / digits
        let indexFromRight = digits - index % digits; //表示digits位数中的第几位（从个位数开始数，也就是右边）
        for _ in 1..<indexFromRight {
            number = number / 10
        }
        return number % 10
    }
    
    /**
     根据digits位数 返回digits位数的第一个数字
        1位数字，第一个数字是0
        2位数字，第一个数字是10
        3位数字，第一个数字是100
     - Parameters:
        - digits: 整数位数
     - Returns: digits位数的第一个数字
     */
    private func beginNumber(_ digits: Int) -> Int {
        if digits == 1 { return 0 }
        return Int(pow(Double(10), Double(digits - 1)))
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        XCTAssertEqual(0, solution.digitAtIndex(0))
        XCTAssertEqual(1, solution.digitAtIndex(1))
        XCTAssertEqual(9, solution.digitAtIndex(9))
        XCTAssertEqual(1, solution.digitAtIndex(10))
        XCTAssertEqual(9, solution.digitAtIndex(189)) // 99的最后一位，9
        XCTAssertEqual(1, solution.digitAtIndex(190)) //100的最后一位 0
        XCTAssertEqual(3, solution.digitAtIndex(1000)) //370的第一位，3
        XCTAssertEqual(7, solution.digitAtIndex(1001)) //370的第二位，7
        XCTAssertEqual(0, solution.digitAtIndex(1002)) //370的第三位 0
    }
}

UnitTests.defaultTestSuite.run()

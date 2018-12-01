//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题49：丑数
// 题目：我们把只包含因子2、3和5的数称作丑数（Ugly Number）。求按从小到
// 大的顺序的第1500个丑数。例如6、8都是丑数，但14不是，因为它包含因子7。
// 习惯上我们把1当做第一个丑数。

import Foundation
import XCTest

class Solution {
    
    /**
     计算丑数
     - Parameters:
        - index: 返回第index个丑数
     - Returns: 丑数
     解法：从0开始遍历判断是否丑数，直到计算到index个
     */
    func getUglyNumber_Solution1(_ index: Int) -> Int {
        guard index > 0 else {
            return 0
        }
        var number = 0
        var uglyFound = 0
        while uglyFound < index {
            number += 1
            if isUglyNumber(number) {
                uglyFound += 1
            }
        }
        return number
    }
    /**
     判断是否是丑数
     - Parameters:
        - number: 数字
     - Returns: 判断结果
     */
    private func isUglyNumber(_ number: Int) -> Bool {
        var number = number
        while number % 2 == 0 {
            number /= 2
        }
        while number % 3 == 0 {
            number /= 3
        }
        while number % 5 == 0 {
            number /= 5
        }
        return number == 1 ? true : false
    }
    
    /**
     计算丑数
     - Parameters:
        - index: 返回第index个丑数
     - Returns: 丑数
     解法：根据已知的丑数，*2、*3、*5等方式计算下一个丑数
     */
    func getUglyNumber_Solution2(_ index: Int) -> Int {
        guard index > 0 else {
            return 0
        }
        var uglyNumbers = [Int]()
        uglyNumbers.append(1) //第一个丑数是1
        var nextUglyIndex = 1
        var multiply2Index = 0, multiply3Index = 0, multiply5Index = 0
        while nextUglyIndex < index {
            let nextUglyNumber = min(uglyNumbers[multiply2Index] * 2,
                          uglyNumbers[multiply3Index] * 3,
                          uglyNumbers[multiply5Index] * 5)
            uglyNumbers.append(nextUglyNumber)
            while uglyNumbers[multiply2Index] * 2 <= uglyNumbers.last! {
                multiply2Index += 1
            }
            while uglyNumbers[multiply3Index] * 3 <= uglyNumbers.last! {
                multiply3Index += 1
            }
            while uglyNumbers[multiply5Index] * 5 <= uglyNumbers.last! {
                multiply5Index += 1
            }
            nextUglyIndex += 1
        }
        return uglyNumbers.last!
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        XCTAssertEqual(1, solution.getUglyNumber_Solution1(1))
        XCTAssertEqual(2, solution.getUglyNumber_Solution1(2))
        XCTAssertEqual(3, solution.getUglyNumber_Solution1(3))
        XCTAssertEqual(4, solution.getUglyNumber_Solution1(4))
        XCTAssertEqual(5, solution.getUglyNumber_Solution1(5))
        XCTAssertEqual(6, solution.getUglyNumber_Solution1(6))
        XCTAssertEqual(8, solution.getUglyNumber_Solution1(7))
        XCTAssertEqual(9, solution.getUglyNumber_Solution1(8))
        XCTAssertEqual(10, solution.getUglyNumber_Solution1(9))
        XCTAssertEqual(12, solution.getUglyNumber_Solution1(10))
        XCTAssertEqual(15, solution.getUglyNumber_Solution1(11))
        //XCTAssertEqual(859963392, solution.getUglyNumber_Solution1(1500)) //太tm耗时了
    }
    func testCase2() {
        XCTAssertEqual(1, solution.getUglyNumber_Solution2(1))
        XCTAssertEqual(2, solution.getUglyNumber_Solution2(2))
        XCTAssertEqual(3, solution.getUglyNumber_Solution2(3))
        XCTAssertEqual(4, solution.getUglyNumber_Solution2(4))
        XCTAssertEqual(5, solution.getUglyNumber_Solution2(5))
        XCTAssertEqual(6, solution.getUglyNumber_Solution2(6))
        XCTAssertEqual(8, solution.getUglyNumber_Solution2(7))
        XCTAssertEqual(9, solution.getUglyNumber_Solution2(8))
        XCTAssertEqual(10, solution.getUglyNumber_Solution2(9))
        XCTAssertEqual(12, solution.getUglyNumber_Solution2(10))
        XCTAssertEqual(15, solution.getUglyNumber_Solution2(11))
        XCTAssertEqual(859963392, solution.getUglyNumber_Solution2(1500))
    }
}

UnitTests.defaultTestSuite.run()

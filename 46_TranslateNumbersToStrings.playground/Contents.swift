//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题46：把数字翻译成字符串
// 题目：给定一个数字，我们按照如下规则把它翻译为字符串：0翻译成"a"，1翻
// 译成"b"，……，11翻译成"l"，……，25翻译成"z"。一个数字可能有多个翻译。例
// 如12258有5种不同的翻译，它们分别是"bccfi"、"bwfi"、"bczi"、"mcfi"和
// "mzi"。请编程实现一个函数用来计算一个数字有多少种不同的翻译方法。

import Foundation
import XCTest

class Solution {
    /**
     求数字翻译成字符串的方法种数
     - Parameters:
        - number: 数字
     - Returns: 翻译方法种数
     解法：从数字的右边往左边进行递归计算，消除重复计算的问题
     */
    func GetTranslationCount(_ number: Int) -> Int {
        if number < 0 { return 0 }
        return GetTranslationCount(String(number).map{Int(String($0))!})
    }
    /**
     求数字翻译成字符串的方法种数
     - Parameters:
        - nums: 数字的各位拆成的数组
     - Returns: 翻译方法种数
     */
    private func GetTranslationCount(_ nums: [Int]) -> Int {
        var counts: [Int:Int] = [:] //counts[i] 表示第i位到个位数组成数字的翻译方法次数
        for index in stride(from: nums.count - 1, through: 0, by: -1) {
            var count = 0
            if index < nums.count - 1 {
                count = counts[index + 1]!
            } else {
                count = 1
            }
            if index < nums.count - 1 {
                let digit1 = nums[index]
                let digit2 = nums[index + 1]
                let converted = digit1 * 10 + digit2
                if converted >= 10 && converted <= 25 {
                    if index < nums.count - 2 {
                        count += counts[index + 2]!
                    } else {
                        count += 1
                    }
                }
            }
            counts[index] = count
        }
        return counts[0]!
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        XCTAssertEqual(1, solution.GetTranslationCount(0))
        XCTAssertEqual(2, solution.GetTranslationCount(10))
        XCTAssertEqual(3, solution.GetTranslationCount(125))
        XCTAssertEqual(2, solution.GetTranslationCount(126))
        XCTAssertEqual(1, solution.GetTranslationCount(426))
        XCTAssertEqual(2, solution.GetTranslationCount(100))
        XCTAssertEqual(2, solution.GetTranslationCount(101))
        XCTAssertEqual(5, solution.GetTranslationCount(12258))
        XCTAssertEqual(0, solution.GetTranslationCount(-100))
    }
}

UnitTests.defaultTestSuite.run()

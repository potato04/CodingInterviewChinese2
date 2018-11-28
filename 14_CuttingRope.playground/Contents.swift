//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题14：剪绳子
// 题目：给你一根长度为n绳子，请把绳子剪成m段（m、n都是整数，n>1并且m≥1）。
// 每段的绳子的长度记为k[0]、k[1]、……、k[m]。k[0]*k[1]*…*k[m]可能的最大乘
// 积是多少？例如当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此
// 时得到最大的乘积18。

import Foundation
import XCTest

class Solution {
    /**
     长度为n的绳子剪成m段后的最大乘积（动态规划法）
     - Parameters:
        - length: 绳子长度
     - Returns: 最大乘积
     */
    func maxProductAfterCutting_solution1(length: Int) -> Int {
        if length < 2 {
            //length = 1时只能剪成 1和0  1*0
            return 0
        }
        if length == 2 {
            //1*1
            return 1
        }
        if length == 3 {
            //1*2
            return 2
        }
        //maxProduct[n] 为把长度为n的绳子剪成若干段后各段长度乘积的最大值
        var products = [0, 1, 2, 3]
        var max = 0
        for i in 4...length {
            max = 0
            for j in 1...i/2 {
                let product = products[j] * products[i-j]
                if product > max {
                    max = product
                }
            }
            products.append(max)
        }
        return products[length]
    }
    /**
     贪心算法：尽可能多地减去长度为3的绳子段，当绳子最后剩下的长度为4的时候，剪成2*2的2段
     - Parameters:
        - length: 绳子长度
     - Returns: 段数的最大乘积
     */
    func maxProductAfterCutting_solution2(length: Int) -> Int {
        if length < 2 {
            return 0
        }
        if length == 2 {
            return 1
        }
        if length == 3 {
            return 2
        }
        if length % 3 == 1 {
            return Int(truncating: (pow(3, length / 3 - 1) * 4) as NSDecimalNumber)
        }
        else if length % 3 == 0 {
            return Int(truncating: (pow(3, length / 3)) as NSDecimalNumber)
        }
        else {
            return Int(truncating: (pow(3, length / 3) * 2) as NSDecimalNumber)
        }
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //长度为1
    func testCase1() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 1), 0)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 1), 0)
    }
    //长度为2
    func testCase2() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 2), 1)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 2), 1)
    }
    //长度为3
    func testCase3() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 3), 2)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 3), 2)
    }
    //长度为4
    func testCase4() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 4), 4)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 4), 4)
    }
    //长度为5
    func testCase5() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 5), 6)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 5), 6)
    }
    //长度为6
    func testCase6() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 6), 9)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 6), 9)
    }
    //长度为7
    func testCase7() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 7), 12)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 7), 12)
    }
    //长度为8
    func testCase8() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 8), 18)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 8), 18)
    }
    //长度为9
    func testCase9() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 9), 27)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 9), 27)
    }
    //长度为10
    func testCase10() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 10), 36)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 10), 36)
    }
    //长度为50
    func testCase11() {
        XCTAssertEqual(solution.maxProductAfterCutting_solution1(length: 50), 86093442)
        XCTAssertEqual(solution.maxProductAfterCutting_solution2(length: 50), 86093442)
    }
}

UnitTests.defaultTestSuite.run()

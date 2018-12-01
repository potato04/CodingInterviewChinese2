//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题42：连续子数组的最大和
// 题目：输入一个整型数组，数组里有正数也有负数。数组中一个或连续的多个整
// 数组成一个子数组。求所有子数组的和的最大值。要求时间复杂度为O(n)。

import Foundation
import XCTest

class Solution {
    
    /**
     连续子数组的最大和
     - Parameters:
        - nums: n个数的数组
     - Returns: 最大和
     */
    func FindGreatestSumOfSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 { return 0 }
        var currentSum = 0
        var maxSum = Int.min
        for num in nums {
            if currentSum <= 0 {
                currentSum = num
            } else {
                currentSum += num
            }
            if currentSum > maxSum {
                maxSum = currentSum
            }
        }
        return maxSum
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //有正数有负数
    func testCase1() {
        XCTAssertEqual(18, solution.FindGreatestSumOfSubArray([1,-2,3,10,-4,7,2,-5]))
    }
    //全是负数
    func testCase2() {
        XCTAssertEqual(-1, solution.FindGreatestSumOfSubArray([-2,-8,-1,-5,-9]))
    }
    //全是正数
    func testCase3() {
        XCTAssertEqual(25, solution.FindGreatestSumOfSubArray([2,8,1,5,9]))
    }
}

UnitTests.defaultTestSuite.run()

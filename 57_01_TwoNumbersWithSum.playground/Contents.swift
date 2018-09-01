//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题57（一）：和为s的两个数字
// 题目：输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们
// 的和正好是s。如果有多对数字的和等于s，输出任意一对即可。

import Foundation
import XCTest

class Solution {
    
    /**
    返回递增排序数组中和为s的两个数字
     - parameters:
        - nums: 数组
        - sum: 和
     - Returns: 和为s的两个数字
     */
    func FindNumbersWithSum(_ nums: [Int], _ sum: Int) -> (num1: Int?, num2: Int?) {
        guard nums.count > 2 else {
            return (nil, nil)
        }
        var start = 0
        var end = nums.count - 1
        while start < end {
            let currentSum = nums[start] + nums[end]
            if currentSum == sum {
                return (nums[start], nums[end])
            }
            else if currentSum > sum {
                end = end - 1
            } else {
                start = start + 1
            }
        }
        return (nil, nil)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 存在和为s的两个数字，这两个数字位于数组的中间
    func testCase1() {
        let nums = [1,2,4,7,11,16]
        let result = solution.FindNumbersWithSum(nums, 15)
        XCTAssertEqual(4, result.num1)
        XCTAssertEqual(11, result.num2)
    }
    
    // 存在和为s的两个数字，这两个数字位于数组的两段
    func testCase2() {
        let nums = [1,2,4,7,11,16]
        let result = solution.FindNumbersWithSum(nums, 17)
        XCTAssertEqual(1, result.num1)
        XCTAssertEqual(16, result.num2)
    }
    // 不存在和为s的两个数字
    func testCase3() {
        let nums = [1,2,4,7,11,16]
        let result = solution.FindNumbersWithSum(nums, 10)
        XCTAssertEqual(nil, result.num1)
        XCTAssertEqual(nil, result.num2)
    }
}
UnitTests.defaultTestSuite.run()







//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题3（一）：找出数组中重复的数字
// 题目：在一个长度为n的数组里的所有数字都在0到n-1的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，
// 也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。例如，如果输入长度为7的数组{2, 3, 1, 0, 2, 5, 3}，
// 那么对应的输出是重复的数字2或者3。

import Foundation
import XCTest

class Solution {
    /**
     查找整数数组中任一重复的数字
     - parameters:
        - nums: 整数数组
     - Returns: Tuple(重复数字的索引，值)
     */
    func duplicate(_ nums: [Int]) -> (index: Int, num: Int)? {
        var nums = nums
        for index in 0..<nums.count {
            while nums[index] != index {
                if nums[index] == nums[nums[index]] {
                    return (index, nums[index])
                }
                let temp = nums[index]
                nums[index] = nums[temp]
                nums[temp] = temp
            }
        }
        return nil
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    ///重复数字是数组中最小的数字
    func testCase1() {
        let nums = [2, 1, 3, 1, 4]
        XCTAssertEqual(solution.duplicate(nums)!.num, 1)
    }
    ///重复数字是数组中最大的数字
    func testCase2() {
        let nums = [2, 4, 3, 1, 4]
        XCTAssertEqual(solution.duplicate(nums)!.num, 4)
    }
    ///数组中存在多个重复的数字
    func testCase3() {
        let nums = [2, 4, 2, 1, 4]
        let duplications = [2,4]
        XCTAssertTrue(duplications.contains(solution.duplicate(nums)!.num))
    }
    ///数组中不存在重复的数字
    func testCase4() {
        let nums = [2, 1, 3, 0, 4]
        XCTAssertNil(solution.duplicate(nums))
    }
    ///无效输入
    func testCase5() {
        let nums:[Int] = []
        XCTAssertNil(solution.duplicate(nums))
    }
}

UnitTests.defaultTestSuite.run()

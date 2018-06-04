//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题11：旋转数组的最小数字
// 题目：把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。
// 输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如数组
// {3, 4, 5, 1, 2}为{1, 2, 3, 4, 5}的一个旋转，该数组的最小值为1。

import Foundation
import XCTest

class Solution {
    /**
     
     - parameters:
        - nums: 一个递增数组的旋转
      - Returns: 数组中最小的那个数字
     */
    func Min(_ nums: [Int]) -> Int{
        if nums.count == 1 || nums.first! < nums.last! {
            return nums[0]
        }
        if nums.first! == nums.last! {
            var min = nums[0]
            for num in nums {
                if num < min {
                    min = num
                }
            }
            return min
        }
        
        var startIndex = 0
        var endIndex = nums.count - 1
        while startIndex != endIndex - 1 {
            let midIndex = startIndex + (endIndex - startIndex) / 2
            if nums[midIndex] >= nums[startIndex] {
                startIndex = midIndex
            }
            if nums[midIndex] <= nums[endIndex] {
                endIndex = midIndex
            }
        }
        return nums[endIndex]
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    // 典型输入，单调升序的数组的一个旋转
    func testCase1() {
        let nums = [3, 4, 5, 1, 2]
        XCTAssertEqual(solution.Min(nums), 1)
    }
    // 有重复数字，并且重复的数字刚好的最小的数字
    func testCase2() {
        let nums = [3, 4, 5, 1, 1, 2]
        XCTAssertEqual(solution.Min(nums), 1)
    }
    // 有重复数字，但重复的数字不是第一个数字和最后一个数字
    func testCase3() {
        let nums = [3, 4, 5, 1, 2, 2]
        XCTAssertEqual(solution.Min(nums), 1)
    }
    // 有重复的数字，并且重复的数字刚好是第一个数字和最后一个数字
    func testCase4() {
        let nums = [1, 0, 1, 1, 1]
        XCTAssertEqual(solution.Min(nums), 0)
    }
    // 单调升序数组，旋转0个元素，也就是单调升序数组本身
    func testCase5() {
        //let nums = [1, 2, 3, 4, 5]
        //XCTAssertEqual(solution.Min(nums), 1)
    }
    // 数组中只有一个数字
    func testCase6() {
        let nums = [2]
        XCTAssertEqual(solution.Min(nums), 2)
    }
}

UnitTests.defaultTestSuite.run()







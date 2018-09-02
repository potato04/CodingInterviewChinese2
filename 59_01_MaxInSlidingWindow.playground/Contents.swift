//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题59（一）：滑动窗口的最大值
// 题目：给定一个数组和滑动窗口的大小，请找出所有滑动窗口里的最大值。例如，
// 如果输入数组{2, 3, 4, 2, 6, 2, 5, 1}及滑动窗口的大小3，那么一共存在6个
// 滑动窗口，它们的最大值分别为{4, 4, 6, 6, 6, 5}，


import Foundation
import XCTest

class Solution {
    
    /**
     - parameters:
        - nums:数组
        - size: 滑动窗口大小
     - Returns: 所有滑动窗口里的最大值
     */
    func maxInWindows(_ nums: [Int], _ size: Int) -> [Int] {
        var maxInWindows = [Int]()
        var queue = [Int]()
        guard nums.count >= size && size > 0 else {
            return maxInWindows
        }
        //将第一个滑动窗口的值添加到队列中
        for index in stride(from: 0, to: size, by: 1) {
            while queue.count > 0 && nums[index] > nums[queue.last!] {
                queue.removeLast()
            }
            queue.append(index) //这里存储的是数组的下标，因为后续要根据下标来判断是否需要删除窗口之外的数 见①
        }
        //处理其他滑动窗口
        for index in stride(from: size, to: nums.endIndex, by: 1) {
            maxInWindows.append(nums[queue.first!])
            while queue.count > 0 && nums[index] > nums[queue.last!] {
                queue.removeLast()
            }
            if queue.count > 0 && queue.first! + size <= index {
                //①: 队列头部的最大数已经不在滑动窗口中，需要删除
                queue.removeFirst()
            }
            queue.append(index)
        }
        maxInWindows.append(nums[queue.first!])
        return maxInWindows
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        let nums = [2,3,4,2,6,2,5,1]
        let expected = [4,4,6,6,6,5]
        XCTAssertEqual(expected, solution.maxInWindows(nums, 3))
    }
    func testCase2() {
        let nums = [1,3,-1,-3,5,3,6,7]
        let expected = [3,3,5,5,6,7]
        XCTAssertEqual(expected, solution.maxInWindows(nums, 3))
    }
    func testCase3() {
        let nums = [1, 3, 5, 7, 9, 11, 13, 15]
        let expected = [7, 9, 11, 13, 15]
        XCTAssertEqual(expected, solution.maxInWindows(nums, 4))
    }
    func testCase4() {
        let nums = [16, 14, 12, 10, 8, 6, 4]
        let expected = [16, 14, 12]
        XCTAssertEqual(expected, solution.maxInWindows(nums, 5))
    }
    func testCase5() {
        let nums = [10,14,12,11]
        let expected = [10,14,12,11]
        XCTAssertEqual(expected, solution.maxInWindows(nums, 1))
    }
    func testCase6() {
        let nums = [10,14,12,11]
        let expected = [14]
        XCTAssertEqual(expected, solution.maxInWindows(nums, 4))
    }
    func testCase7() {
        let nums = [10,14,12,11]
        let expected:[Int] = []
        XCTAssertEqual(expected, solution.maxInWindows(nums, 0))
    }
    func testCase8() {
        let nums = [10,14,12,11]
        let expected:[Int] = []
        XCTAssertEqual(expected, solution.maxInWindows(nums, 5))
    }
    func testCase9() {
        let nums:[Int] = []
        let expected:[Int] = []
        XCTAssertEqual(expected, solution.maxInWindows(nums, 5))
    }
}
UnitTests.defaultTestSuite.run()







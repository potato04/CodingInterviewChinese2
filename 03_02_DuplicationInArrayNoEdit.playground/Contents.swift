//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题3（二）：不修改数组找出重复的数字
// 题目：在一个长度为n+1的数组里的所有数字都在1到n的范围内，所以数组中至
// 少有一个数字是重复的。请找出数组中任意一个重复的数字，但不能修改输入的
// 数组。例如，如果输入长度为8的数组{2, 3, 5, 4, 3, 2, 6, 7}，那么对应的
// 输出是重复的数字2或者3。

import Foundation
import XCTest

class Solution {
    /**
     查找整数数组中任一重复的数字
     - Parameters:
        - nums: 整数数组
     - Returns: 重复的整数
     */
    func duplicate(_ nums: [Int]) -> Int? {
        var start = 1
        var end = nums.count - 1
        while start <= end {
            let middle = (end - start) / 2 + start
            let count = countAtRange(nums, min: start, max: middle)
            if start == end {
                if count > 1 {
                    return start
                } else {
                    break
                }
            }
            let expectCount = middle - start + 1
            if count > expectCount {
                end = middle
            } else {
                start = middle + 1
            }
        }
        return nil
    }
    /**
     统计数组nums元素大小在[min,max]范围内的个数
     - Parameters:
        - nums: 数组
        - min: 最小值
        - max: 最大值
     - Returns: 重复的整数
     */
    func countAtRange(_ nums:[Int], min: Int, max: Int) -> Int{
        var count = 0
        for num in nums {
            if num >= min && num <= max {
                count += 1
            }
        }
        return count
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    ///数组中存在多个重复的数字
    func testCase1() {
        let nums = [2, 3, 5, 4, 3, 2, 6, 7]
        let duplications = [2,3]
        XCTAssertTrue(duplications.contains(solution.duplicate(nums)!))
    }
    ///数组中存在一个重复的数字
    func testCase2() {
        let nums = [3, 2, 1, 4, 4, 5, 6, 7]
        XCTAssertEqual(solution.duplicate(nums)!, 4)
    }
    ///重复数字是数组中最小的数字
    func testCase3() {
        let nums = [1, 2, 3, 4, 5, 6, 7, 1, 8]
        XCTAssertEqual(solution.duplicate(nums)!, 1)
    }
    ///重复数字是数组中最大的数字
    func testCase4() {
        let nums = [1, 7, 3, 4, 5, 6, 8, 2, 8]
        XCTAssertEqual(solution.duplicate(nums)!, 8)
    }
    ///数组中只有两个数字
    func testCase5() {
        let nums = [1, 1]
        XCTAssertEqual(solution.duplicate(nums)!, 1)
    }
    ///一个数字重复三次
    func testCase6() {
        let nums = [1, 2, 2, 6, 4, 5, 2]
        XCTAssertEqual(solution.duplicate(nums)!, 2)
    }
    ///数组中不存在重复的数字
    func testCase7() {
        let nums = [1, 2, 6, 4, 5, 3]
        XCTAssertNil(solution.duplicate(nums))
    }
    ///无效输入
    func testCase8() {
        let nums:[Int] = []
        XCTAssertNil(solution.duplicate(nums))
    }
}

UnitTests.defaultTestSuite.run()

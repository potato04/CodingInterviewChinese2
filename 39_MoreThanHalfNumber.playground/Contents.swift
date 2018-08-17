//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题39：数组中出现次数超过一半的数字
// 题目：数组中有一个数字出现的次数超过数组长度的一半，请找出这个数字。例
// 如输入一个长度为9的数组{1, 2, 3, 2, 2, 2, 5, 4, 2}。由于数字2在数组中
// 出现了5次，超过数组长度的一半，因此输出2。

import Foundation
import XCTest

class Solution {
    
    private func checkMoreThanHalf(_ nums: [Int], num: Int) -> Bool {
        return nums.filter { $0 == num }.count * 2 <= nums.count ? false : true
    }
    
    /**
     如果某个数字的次数超过数组长度一半，那么该数字必然是数组中间的那个数字（中位数）
     - parameters:
     - nums: 数组
     - Returns: 出现次数超过数组长度一半的数字
     */
    func MoreThanHalfNum_Solution1(_ nums: [Int]) -> Int? {
        if nums.count == 0 {
            return nil
        }
        var nums = nums
        let middle = nums.count / 2
        var start = 0
        var end = nums.count - 1
        var index:Int
        (index, nums) = partition(nums, start: start, end: end)
        while index != middle {
            if index > middle {
                end = index - 1
                (index, nums) = partition(nums, start: start, end: end)
            } else {
                start = index + 1
                (index, nums) = partition(nums, start: start, end: end)
            }
        }
        let median = nums[middle]
        return checkMoreThanHalf(nums, num: median) ? median : nil
    }
    func partition (_ nums: [Int], start: Int, end: Int) -> (index: Int, newNums: [Int]) {
        if nums.count == 0 || start > end {
            return (-1, nums)
        }
        var nums = nums
        var startIndex = start
        var endIndex = end
        let pivot = nums[start]
        startIndex += 1
        while true {
            while nums[startIndex] <= pivot && startIndex <= endIndex {
                startIndex += 1
            }
            while nums[endIndex] >= pivot && endIndex >= startIndex {
                endIndex -= 1
            }
            if endIndex > startIndex {
                nums = swap(nums, a: startIndex, b: endIndex)
            } else {
                break
            }
        }
        nums = swap(nums, a: start, b: endIndex)
        return (endIndex, nums)
    }
    private func swap(_ nums:[Int], a: Int, b: Int) -> [Int] {
        if nums.count == 0 || a > nums.count || b > nums.count {
            return nums
        }
        var nums = nums
        let temp = nums[a]
        nums[a] = nums[b]
        nums[b] = temp
        return nums
    }
    
    /**
     保存数组第一个数字result和次数times
     从index=1开始遍历数组，如果数字与result相同，times+1，否则times-1
     如果times=0, result保存下一个遍历数字，times重置为1
     **我们要找的数字出现的次数其他数字次数的和都多，所以要找的数字肯定是最后把次数设为1的数字**
     - parameters:
     - nums: 数组
     - Returns: 出现次数超过数组长度一半的数字
     */
    func MoreThanHalfNum_Solution2(_ nums: [Int]) -> Int? {
        if nums.count == 0 {
            return nil
        }
        var result = nums[0]
        var times = 1
        for num in nums[1...] {
            if times == 0 {
                result = num
                times = 1
            } else if num == result {
                times += 1
            } else {
                times -= 1
            }
        }
        return checkMoreThanHalf(nums, num: result) ? result : nil
    }

}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //存在超过一半的数字
    func testCase1() {
        let nums = [1,2,3,2,2,2,5,4,2]
        XCTAssertEqual(2, solution.MoreThanHalfNum_Solution1(nums))
        XCTAssertEqual(2, solution.MoreThanHalfNum_Solution2(nums))
    }
    //不存在超过一半的数字
    func testCase2() {
        let nums = [1,2,3,2,4,2,5,2,3]
        XCTAssertEqual(nil, solution.MoreThanHalfNum_Solution1(nums))
        XCTAssertEqual(nil, solution.MoreThanHalfNum_Solution2(nums))
    }
    //存在超过一半的数字(该数字全部出现在数组前半部分)
    func testCase3() {
        let nums = [2,2,2,2,2,1,3,4,5]
        XCTAssertEqual(2, solution.MoreThanHalfNum_Solution1(nums))
        XCTAssertEqual(2, solution.MoreThanHalfNum_Solution2(nums))
    }
    //存在超过一半的数字(该数字全部出现在数组后半部分)
    func testCase4() {
        let nums = [1,3,4,5,2,2,2,2,2]
        XCTAssertEqual(2, solution.MoreThanHalfNum_Solution1(nums))
        XCTAssertEqual(2, solution.MoreThanHalfNum_Solution2(nums))
    }
}


UnitTests.defaultTestSuite.run()







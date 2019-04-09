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
    /**
     验证数组中是否出现一半以上的指定数字
     - Parameters:
        - nums: 数组
        - num: 指定数字
     - Returns: 验证结果
     */
    private func checkMoreThanHalf(_ nums: [Int], num: Int) -> Bool {
        return nums.filter { $0 == num }.count * 2 <= nums.count ? false : true
    }
    
    /**
     找出数组中出现次数超过一半的数字
     解法：将数组排序（不一定要完全排序，利用快排原理，只要找到中位数即可），如果某个数字的次数超过数组长度一半，那么该数字必然是数组中间的那个数字
     - Parameters:
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
        
        var p = partition(&nums, start: start, end: end)
        while p != middle {
            if p > middle {
                end = p - 1
            } else {
                start = p + 1
            }
             p = partition(&nums, start: start, end: end)
        }
        let median = nums[middle]
        return checkMoreThanHalf(nums, num: median) ? median : nil
    }
    
    /**
     将数组在指定范围内[start，end]分区，使得左边部分数字比右边部分的小
     - Parameters:
        - nums: 数组
        - start: 分区开始索引
        - end: 分区结束索引
     - Returns: index：当前分区的分界索引
     */
    func partition (_ nums: inout [Int], start: Int, end: Int) -> Int {
        if nums.count == 0 || start > end {
            return start
        }
        let pivot = nums[start]
        var lo = start + 1
        var hi = end
        
        while true {
            while nums[lo] <= pivot && lo < end {
                lo += 1
            }
            while nums[hi] > pivot {
                hi -= 1
            }
            if lo < hi {
                (nums[lo], nums[hi]) = (nums[hi], nums[lo])
            } else {
                (nums[start], nums[hi]) = (nums[hi], nums[start])
                return hi
            }
        }
    }
    /**
     找出数组中出现次数超过一半的数字
     解法：保存数组第一个数字result和次数times
     从index=1开始遍历数组，如果数字与result相同，times+1，否则times-1
     如果times=0, result保存下一个遍历数字，times重置为1
     **我们要找的数字出现的次数其他数字次数的和都多，所以要找的数字肯定是最后把次数设为1的数字**
     - Parameters:
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

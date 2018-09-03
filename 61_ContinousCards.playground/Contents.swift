//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题61：扑克牌的顺子
// 题目：从扑克牌中随机抽5张牌，判断是不是一个顺子，即这5张牌是不是连续的。
// 2～10为数字本身，A为1，J为11，Q为12，K为13，而大、小王可以看成任意数字。

import Foundation
import XCTest

class Solution {
    /**
     - parameters:
        - nums:数组
     - Returns: 是否顺子
     解法：将输入的数字排序，统计出0的个数，在从非0数字开始计算当前数字与下一个数字之间的间隙（gap）
     如果间隙大于0的个数则非顺子，否则为顺子
     */

    func IsContinuous(_ nums: [Int]) -> Bool {
        guard nums.count > 0 else {
            return false
        }
        var nums = nums.sorted()
        let numberOfZero = nums.filter{$0 == 0}.count
        var numberOfGap = 0
        for index in numberOfZero..<nums.count-1 {
            if nums[index] == nums[index+1] {
                return false //两数相等，不可能会是顺子
            }
            numberOfGap += nums[index+1] - nums[index] - 1
        }
        return numberOfGap > numberOfZero ? false : true
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1() {
        let nums = [1,3,2,5,4]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase2() {
        let nums = [1,3,2,6,4]
        XCTAssertEqual(false, solution.IsContinuous(nums))
    }
    func testCase3() {
        let nums = [0,3,2,6,4]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase4() {
        let nums = [0,3,1,6,4]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase5() {
        let nums = [1,3,0,5,0]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase6() {
        let nums = [1,3,0,7,0]
        XCTAssertEqual(false, solution.IsContinuous(nums))
    }
    func testCase7() {
        let nums = [1,0,0,5,0]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase8() {
        let nums = [1,0,0,7,0]
        XCTAssertEqual(false, solution.IsContinuous(nums))
    }
    func testCase9() {
        let nums = [3,0,0,0,0]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase10() {
        let nums = [0,3,2,6,4]
        XCTAssertEqual(true, solution.IsContinuous(nums))
    }
    func testCase11() {
        let nums = [1,0,0,1,0]
        XCTAssertEqual(false, solution.IsContinuous(nums))
    }
    func testCase12() {
        let nums:[Int] = []
        XCTAssertEqual(false, solution.IsContinuous(nums))
    }
}
UnitTests.defaultTestSuite.run()







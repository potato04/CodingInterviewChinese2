//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题56（二）：数组中唯一只出现一次的数字
// 题目：在一个数组中除了一个数字只出现一次之外，其他数字都出现了三次。请
// 找出那个出现一次的数字。

import Foundation
import XCTest

class Solution {
    
    /**
    返回数组中只出现一次的数字
     - Parameters:
        - nums: 数组
     - Returns: 出现一次的数字
     */
    func FindNumberAppearingOnce(_ nums: [Int]) -> Int? {
        guard nums.count > 0 else {
            return nil
        }
        var bitSum = Array.init(repeating: 0, count: Int.bitWidth)
        nums.forEach {
            var bitMask = 1
            for i in 0..<Int.bitWidth {
                let bit = $0 & bitMask
                bitSum[i] += bit == 0 ? 0 : 1
                bitMask = bitMask << 1
            }
        }
        var result = 0
        for i in stride(from: Int.bitWidth - 1, through: 0, by: -1) {
            result = result << 1
            result += bitSum[i] % 3
        }
        return result
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        let nums = [1,1,1,2,2,2,3]
        XCTAssertEqual(3, solution.FindNumberAppearingOnce(nums))
    }
    func testCase2() {
        let nums = [4, 3, 3, 2, 2, 2, 3]
        XCTAssertEqual(4, solution.FindNumberAppearingOnce(nums))
    }
    func testCase3() {
        let nums = [4,4,1,1,1,7,4]
        XCTAssertEqual(7, solution.FindNumberAppearingOnce(nums))
    }
    func testCase4() {
        let nums = [-10,214,214,214]
        XCTAssertEqual(-10, solution.FindNumberAppearingOnce(nums))
    }
    func testCase5() {
        let nums = [-209, 3467, -209, -209]
        XCTAssertEqual(3467, solution.FindNumberAppearingOnce(nums))
    }
    func testCase6() {
        let nums = [1024, -1025, 1024, -1025, 1024, -1025, 1023]
        XCTAssertEqual(1023, solution.FindNumberAppearingOnce(nums))
    }
    func testCase7() {
        let nums = [-1024, -1024, -1024, -1023]
        XCTAssertEqual(-1023, solution.FindNumberAppearingOnce(nums))
    }
    func testCase8() {
        let nums = [-23, 0, 214, -23, 214, -23, 214]
        XCTAssertEqual(0, solution.FindNumberAppearingOnce(nums))
    }
    func testCase9() {
        let nums = [0,3467,0,0,0,0,0,0]
        XCTAssertEqual(3467, solution.FindNumberAppearingOnce(nums))
    }
}

UnitTests.defaultTestSuite.run()

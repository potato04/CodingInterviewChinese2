//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题56（一）：数组中只出现一次的两个数字
// 题目：一个整型数组里除了两个数字之外，其他的数字都出现了两次。请写程序
// 找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。

import Foundation
import XCTest

class Solution {
    
    /**
    返回数组中只出现一次的两个数字(其他数字都出现了两次)
     - Parameters:
        - nums: 数组
     - Returns: 两个数字
     */
    func FindNumsAppearOnce(_ nums: [Int]) -> (num1: Int?, num2: Int?) {
        guard nums.count >= 2 else {
            return (nil, nil)
        }
        let xorResult = nums.reduce(0) {
            return $0 ^ $1
        }
        let indexOf1 = FindFirstBitIs1(xorResult)
        var num1 = 0, num2 = 0
        nums.forEach {
            if(IsBit1($0, at: indexOf1)) {
                num1 ^= $0
            } else {
                num2 ^= $0
            }
        }
        return (min(num1, num2), max(num1, num2))
    }
    /**
     查找从右边数起第一个是1的位
     - Parameters:
        - num: 数字
        - index: 第index位（从右开始）
     - Returns: 判断结果
     */
    private func FindFirstBitIs1(_ num: Int) -> Int{
        var index = 0
        var num = num
        while num & 1 == 0 && index < num.bitWidth {
            num = num >> 1
            index += 1
        }
        return index
    }
    /**
     判断数字的第index位是不是1
     - Parameters:
        - num: 数字
        - index: 第index位（从右开始）
     - Returns: 判断结果
     */
    private func IsBit1(_ num: Int, at index:Int) ->  Bool {
        let num = num >> index
        return num & 1 == 1
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func testCase1() {
        let nums = [2,4,3,6,3,2,5,5]
        XCTAssertEqual(4, solution.FindNumsAppearOnce(nums).num1)
        XCTAssertEqual(6, solution.FindNumsAppearOnce(nums).num2)
    }
    
    func testCase2() {
        let nums = [4,6]
        XCTAssertEqual(4, solution.FindNumsAppearOnce(nums).num1)
        XCTAssertEqual(6, solution.FindNumsAppearOnce(nums).num2)
    }
    
    func testCase3() {
        let nums = [4,6,1,1,1,1]
        XCTAssertEqual(4, solution.FindNumsAppearOnce(nums).num1)
        XCTAssertEqual(6, solution.FindNumsAppearOnce(nums).num2)
    }
}

UnitTests.defaultTestSuite.run()

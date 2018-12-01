//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题45：把数组排成最小的数
// 题目：输入一个正整数数组，把数组里所有数字拼接起来排成一个数，打印能拼
// 接出的所有数字中最小的一个。例如输入数组{3, 32, 321}，则打印出这3个数
// 字能排成的最小数字321323。

import Foundation
import XCTest

class Solution {
    
    /**
     根据输入数组，返回数组里所有数字拼接起来能排成的最小数字
     - Parameters:
        - nums: 数组
     - Returns: 最小的数字
     */
    func PrintMinNumber(_ nums: [Int]) -> Int? {
        if nums.count == 0 { return nil }
        let digitCount = nums.reduce(0, { x, y in
            x + String(y).count
        })
        if digitCount > 10 {
            return nil
        }
        
        //核心解法：将问题转换为排序，然后将输入的数字转换成字符串，再将$0和$1进行拼接比较，小的排在前面
        let nums = nums.map{String($0)}.sorted{return $0+$1 < $1+$0 }
        let minNumber = nums.reduce("", {x, y in
            x + y
        })
        return Int(minNumber)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func testCase1() {
        XCTAssertEqual(12345, solution.PrintMinNumber([3,5,1,4,2]))
        XCTAssertEqual(321323, solution.PrintMinNumber([3,32,321]))
        XCTAssertEqual(321233233, solution.PrintMinNumber([3,323,32123]))
        XCTAssertEqual(111111, solution.PrintMinNumber([1,11,111]))
        XCTAssertEqual(321, solution.PrintMinNumber([321]))
    }
}

UnitTests.defaultTestSuite.run()

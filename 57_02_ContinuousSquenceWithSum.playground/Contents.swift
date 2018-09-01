//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题57（二）：和为s的连续正数序列
// 题目：输入一个正数s，打印出所有和为s的连续正数序列（至少含有两个数）。
// 例如输入15，由于1+2+3+4+5=4+5+6=7+8=15，所以结果打印出3个连续序列1～5、
// 4～6和7～8。


import Foundation
import XCTest

class Solution {
    
    /**
     - parameters:
        - sum: 和
     - Returns: 和为s的连续正数序列
     */
    func FindContinuousSequence(_ sum: Int) -> [[Int]] {
        var small = 1, big = 2
        let middle = (sum + 1) / 2
        var currentSum = small + big
        var result = [[Int]]()
        while small < middle {
            if currentSum == sum {
                result.append(CreateResult(small, big))
            }
            
            while currentSum > sum && small < middle {
                currentSum -= small
                small += 1
                
                if currentSum == sum {
                    result.append(CreateResult(small, big))
                }
            }
            
            big += 1
            currentSum += big
        }
        return result
    }
    private func CreateResult(_ small: Int, _ big: Int) -> [Int] {
        var result = [Int]()
        for i in small...big {
            result.append(i)
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
        XCTAssertEqual(nil, solution.FindContinuousSequence(1).first)
        XCTAssertEqual([1,2], solution.FindContinuousSequence(3).first)
        XCTAssertEqual(nil, solution.FindContinuousSequence(4).first)
        XCTAssertEqual([[2,3,4],[4,5]], solution.FindContinuousSequence(9))
        XCTAssertEqual([[1, 2, 3, 4, 5], [4, 5, 6], [7, 8]], solution.FindContinuousSequence(15))
        XCTAssertEqual([[9, 10, 11, 12, 13, 14, 15, 16], [18, 19, 20, 21, 22]], solution.FindContinuousSequence(100))
    }
}
UnitTests.defaultTestSuite.run()







//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题62：圆圈中最后剩下的数字
// 题目：0, 1, …, n-1这n个数字排成一个圆圈，从数字0开始每次从这个圆圈里
// 删除第m个数字。求出这个圆圈里剩下的最后一个数字。

import Foundation
import XCTest

class Solution {
    /**
     获取圆圈中最后剩下的数字
     - Parameters:
        - n:表示圆圈中的数字为 1...n-1
        - m:表示每次删除第m个数字
     - Returns: 最后一个数字
     */
    func LastRemaining_Solution1(n: Int,  m: Int) -> Int? {
        guard n > 0 && m > 0 else {
            return nil
        }
        var nums = [Int]() //用数组来模拟圆圈中的数字
        for i in 0..<n {
            nums.append(i)
        }
        var currentDeleteIndex = nums.startIndex
        while nums.count > 1 {
            for _ in 1..<m {
                currentDeleteIndex += 1
                if currentDeleteIndex == nums.endIndex {
                    currentDeleteIndex = nums.startIndex
                }
            }
            nums.remove(at: currentDeleteIndex)
            if currentDeleteIndex == nums.endIndex {
                currentDeleteIndex = nums.startIndex
            }
        }
        return nums.first!
    }
    
    /**
     获取圆圈中最后剩下的数字
     - Parameters:
        - n:表示圆圈中的数字为 1...n-1
        - m:表示每次删除第m个数字
     - Returns: 最后一个数字
     */
    func LastRemaining_Solution2(n: Int,  m: Int) -> Int? {
        guard n > 0 && m > 0 else {
            return nil
        }
        var last = 0
        for i in 2...n {
            last = (last + m) % i
        }
        return last
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1() {
        XCTAssertEqual(3, solution.LastRemaining_Solution1(n: 5, m: 3))
        XCTAssertEqual(3, solution.LastRemaining_Solution2(n: 5, m: 3))
    }
    func testCase2() {
        XCTAssertEqual(2, solution.LastRemaining_Solution1(n: 5, m: 2))
        XCTAssertEqual(2, solution.LastRemaining_Solution2(n: 5, m: 2))
    }
    func testCase3() {
        XCTAssertEqual(4, solution.LastRemaining_Solution1(n: 6, m: 7))
        XCTAssertEqual(4, solution.LastRemaining_Solution2(n: 6, m: 7))
    }
    func testCase4() {
        XCTAssertEqual(3, solution.LastRemaining_Solution1(n: 6, m: 6))
        XCTAssertEqual(3, solution.LastRemaining_Solution2(n: 6, m: 6))
    }
    func testCase5() {
        XCTAssertEqual(nil, solution.LastRemaining_Solution1(n: 0, m: 0))
        XCTAssertEqual(nil, solution.LastRemaining_Solution2(n: 0, m: 0))
    }
    func testCase6() {
        //XCTAssertEqual(1027, solution.LastRemaining_Solution1(n: 4000, m: 997))
        XCTAssertEqual(1027, solution.LastRemaining_Solution2(n: 4000, m: 997))
    }
}

UnitTests.defaultTestSuite.run()

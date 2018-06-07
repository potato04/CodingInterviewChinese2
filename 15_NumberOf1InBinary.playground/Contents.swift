//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题15：二进制中1的个数
// 题目：请实现一个函数，输入一个整数，输出该数二进制表示中1的个数。例如
// 把9表示成二进制是1001，有2位是1。因此如果输入9，该函数输出2。

import Foundation
import XCTest

class Solution {
    /**
     方法：将输入的整数与flag（初始值为1）进行按位与运算，如果大于0，则计数+1
          每次比较完将flag左移1位再比较，直到flag=0
     - parameters:
        - num: 输入的整数
      - Returns: i的2进制表示中1的个数
     */
    func NumberOf1_Solution1(_ num: Int) -> Int {
        var count = 0
        var flag = 1
        while flag != 0 {
            if flag & num > 0 {
                count += 1
            }
            flag = flag << 1
        }
        return count
    }
    /**
     方法：将整数 num-1 与 num 做与运算，会把该整数的最右边的1变成0
          那么1个整数二进制有多少个1就可以进行多少次这样操作
     - parameters:
     - num: 输入的整数
     - Returns: i的2进制表示中1的个数
     */
    func NumberOf1_Solution2(_ num: Int) -> Int {
        var count = 0
        var num = num
        while num > 0 {
            count += 1
            num = num & (num - 1)
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
    //输入0
    func testCase1() {
        XCTAssertEqual(solution.NumberOf1_Solution1(0), 0)
        XCTAssertEqual(solution.NumberOf1_Solution2(0), 0)
    }
    //输入1
    func testCase2() {
        XCTAssertEqual(solution.NumberOf1_Solution1(1), 1)
        XCTAssertEqual(solution.NumberOf1_Solution2(1), 1)
    }
    //输入10
    func testCase3() {
        XCTAssertEqual(solution.NumberOf1_Solution1(10), 2)
        XCTAssertEqual(solution.NumberOf1_Solution2(10), 2)
    }
    //输入0x7FFFFFFF
    func testCase4() {
        XCTAssertEqual(solution.NumberOf1_Solution1(Int("7FFFFFFF", radix: 16)!), 31)
        XCTAssertEqual(solution.NumberOf1_Solution2(Int("7FFFFFFF", radix: 16)!), 31)
    }
    
    //输入0xFFFFFFFF 负数
    func testCase5() {
        XCTAssertEqual(solution.NumberOf1_Solution1(Int("FFFFFFFF", radix: 16)!), 32)
        XCTAssertEqual(solution.NumberOf1_Solution2(Int("FFFFFFFF", radix: 16)!), 32)
    }
    
    //输入0x80000000（负数），期待的输出是1
    func testCase6() {
        XCTAssertEqual(solution.NumberOf1_Solution1(Int("80000000", radix: 16)!), 1)
        XCTAssertEqual(solution.NumberOf1_Solution2(Int("80000000", radix: 16)!), 1)
    }
    
}

UnitTests.defaultTestSuite.run()







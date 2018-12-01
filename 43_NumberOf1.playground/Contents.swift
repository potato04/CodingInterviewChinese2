//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题43：从1到n整数中1出现的次数
// 题目：输入一个整数n，求从1到n这n个整数的十进制表示中1出现的次数。例如
// 输入12，从1到12这些整数中包含1 的数字有1，10，11和12，1一共出现了5次。

import Foundation
import XCTest

class Solution {
    
    /**
     统计从1到N整数中1出现的次数
     - Parameters:
        - nums: 整数N
     - Returns: 1-N 的数十进制表示中1出现的次数
     解法：遍历1-N，累计过程中每个数字中1出现的计数
     */
    func NumberOf1Between1AndN_Solution1(N: Int) -> Int {
        if N <= 0 { return 0 }
        var totalCount = 0
        for i in 1...N {
            var count = 0
            var n = i
            while n > 0 {
                if n % 10 == 1 {
                    count += 1
                }
                n = n / 10
            }
            totalCount += count
        }
        return totalCount
    }
    /**
     统计从1到N整数中1出现的次数
     - Parameters:
        - nums: 整数N
     - Returns: 1-N 的数十进制表示中1出现的次数
     */
    func NumberOf1Between1AndN_Solution2(N: Int) -> Int {
        if N <= 0 { return 0 }
        return NumberOf1(Array(String(N)).map { Int(String($0))! })
    }
    /**
     统计从1到N整数中1出现的次数
     - Parameters:
        - digits: 整数N的各位组成的数组
     - Returns: 1-N 的数十进制表示中1出现的次数
     */
    private func NumberOf1(_ digits:[Int]) -> Int {
        if digits.count == 1 { return digits[0] > 0 ? 1 : 0  } //个位数，1只会出现1次
        //假如数组是[2,1,3,4,5]
        //numFirstDigit是数字10000-19999的第一位中1的数目
        var numFirstDigit = 0
        if digits[0] > 1{
            numFirstDigit = PowerBase10(n: digits.count - 1)
        } else if digits[0] == 1 {
            numFirstDigit = Int(digits[1...].map(String.init).joined())! + 1
        }
        //numOtherDigits 是 01346 - 21345 除了第一位之外的数位中1的数目
        let numOtherDigits = digits[0] * (digits.count - 1) * PowerBase10(n: digits.count - 2)
        // numRecursive 是1-1345的数目，用递归求得
        let numRecursive = NumberOf1(Array(digits[1...]))
        return numFirstDigit + numOtherDigits + numRecursive
    }
    /**
     计算10的n次方
     - Parameters:
        - n: n
     - Returns: 10的n次方结果
     */
    private func PowerBase10(n: Int) -> Int {
        if n < 1 { return 1}
        var result = 1
        for _ in 0..<n {
            result *= 10
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
        XCTAssertEqual(1, solution.NumberOf1Between1AndN_Solution1(N: 1))
        XCTAssertEqual(1, solution.NumberOf1Between1AndN_Solution2(N: 1))
    }
    func testCase2() {
        XCTAssertEqual(1, solution.NumberOf1Between1AndN_Solution1(N: 5))
        XCTAssertEqual(1, solution.NumberOf1Between1AndN_Solution2(N: 5))
    }
    func testCase3() {
        XCTAssertEqual(2, solution.NumberOf1Between1AndN_Solution1(N: 10))
        XCTAssertEqual(2, solution.NumberOf1Between1AndN_Solution2(N: 10))
    }
    func testCase4() {
        XCTAssertEqual(16, solution.NumberOf1Between1AndN_Solution1(N: 55))
        XCTAssertEqual(16, solution.NumberOf1Between1AndN_Solution2(N: 55))
    }
    func testCase5() {
        XCTAssertEqual(20, solution.NumberOf1Between1AndN_Solution1(N: 99))
        XCTAssertEqual(20, solution.NumberOf1Between1AndN_Solution2(N: 99))
    }
    func testCase6() {
        XCTAssertEqual(4001, solution.NumberOf1Between1AndN_Solution1(N: 10000))
        XCTAssertEqual(4001, solution.NumberOf1Between1AndN_Solution2(N: 10000))
    }
    func testCase7() {
        XCTAssertEqual(18821, solution.NumberOf1Between1AndN_Solution1(N: 21345))
        XCTAssertEqual(18821, solution.NumberOf1Between1AndN_Solution2(N: 21345))
    }
    func testCase8() {
        XCTAssertEqual(0, solution.NumberOf1Between1AndN_Solution1(N: 0))
        XCTAssertEqual(0, solution.NumberOf1Between1AndN_Solution2(N: 0))
    }
}

UnitTests.defaultTestSuite.run()

//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题17：打印1到最大的n位数
// 题目：输入数字n，按顺序打印出从1最大的n位十进制数。比如输入3，则
// 打印出1、2、3一直到最大的3位数即999。

import Foundation
import XCTest

class Solution {
    private let dict:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
    /**
     主要考察n比较大时，long longlong都不能表示的情况
     - parameters:
        - n：最大的位数
     */
    func print1ToMaxOfNDigits(_ n: Int){
        if n <= 0 {
            return
        }
        var numStr: [Character] = Array(repeating: "0", count: n)
        for i in 0..<dict.count {
            numStr[0] = dict[i]
            printCoreRecursively(numStr, index: 0)
        }
    }
    private func printCoreRecursively(_ num:[Character], index: Int){
        var num = num
        if num.count - 1 == index{
            printNum(num)
            return
        }
        for i in 0..<dict.count {
            num[index + 1] = dict[i]
            printCoreRecursively(num, index: index + 1)
        }
        
    }
    private func printNum(_ num:[Character]){
        var isBeginning = true
        for char in num {
            if char == "0" && isBeginning{
                continue
            }else {
                isBeginning = false
                print(char, terminator:"")
            }
        }
        print("\n")
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }

    func testCase1() {
        solution.print1ToMaxOfNDigits(1)
    }
    func testCase2() {
        solution.print1ToMaxOfNDigits(2)
    }
    func testCase3() {
        solution.print1ToMaxOfNDigits(3)
    }
    func testCase4() {
        solution.print1ToMaxOfNDigits(0)
    }
    func testCase5() {
        solution.print1ToMaxOfNDigits(-1)
    }
}

UnitTests.defaultTestSuite.run()







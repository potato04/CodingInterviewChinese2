//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题17：打印1到最大的n位数
// 题目：输入数字n，按顺序打印出从1最大的n位十进制数。比如输入3，则
// 打印出1、2、3一直到最大的3位数即999。

import Foundation
import XCTest

class Solution {
    
    private let digitsDict:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
    
    /**
     按顺序打印出从1最大的n位十进制数
     主要考察n比较大时，long longlong都不能表示的情况
     - Parameters:
        - n：最大的位数
     */
    func print1ToMaxOfNDigits(_ n: Int){
        if n <= 0 {
            return
        }
        var charArray: [Character] = Array(repeating: "0", count: n)
        for i in 0..<digitsDict.count {
            charArray[0] = digitsDict[i]
            printCoreRecursively(charArray, index: 0)
        }
    }
    /**
     循环递归的替换num数组中的第index及之后的每个元素（字符）
     如果数组的最后一个元素也已经替换，则调用打印函数进行打印
     - Parameters:
        - nums: 字符数组
        - index: 当前需要替换字符的数组索引
     */
    private func printCoreRecursively(_ nums:[Character], index: Int){
        var nums = nums
        if nums.count - 1 == index{
            printNum(nums)
            return
        }
        for i in 0..<digitsDict.count {
            nums[index + 1] = digitsDict[i]
            printCoreRecursively(nums, index: index + 1)
        }
        
    }
    /**
     打印字符数组里的所有字符，如果数组前几个字符是0，则忽略它们
     - Parameters:
        - nums：输入的字符数组
     */
    private func printNum(_ nums:[Character]){
        var isBeginning = true
        for char in nums {
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

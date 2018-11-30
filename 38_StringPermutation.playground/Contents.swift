//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题38：字符串的排列
// 题目：输入一个字符串，打印出该字符串中字符的所有排列。例如输入字符串abc，
// 则打印出由字符a、b、c所能排列出来的所有字符串abc、acb、bac、bca、cab和cba。

import Foundation
import XCTest

class Solution {
    /**
     返回该字符串中字符的所有排列
     - Parameters:
        - str: 输入的字符串
     - Returns: 字符所有可能的排列
     */
    func Permutation(_ str: String) -> [String]{
        let chars = Array(str)
        if chars.count == 0 {
            return [String]()
        }
        return Permutation(chars, startIndex: 0)
    }
    /**
     返回该字符串中字符的所有排列
     - Parameters:
        - chars: 字符数组
        - startIndex: 开始排列的数组索引
     - Returns: 字符所有可能的排列
     */
    private func Permutation(_ chars:[Character], startIndex: Int) -> [String] {
        var result = [String]()
        var chars = chars
        if startIndex == chars.count {
            result.append(String(chars))
        } else {
            for index in startIndex..<chars.count {
                var temp = chars[index]
                chars[index] = chars[startIndex]
                chars[startIndex] = temp
                
                result.append(contentsOf: Permutation(chars, startIndex: startIndex + 1))
                
                temp = chars[index]
                chars[index] = chars[startIndex]
                chars[startIndex] = temp
            }
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
    func testCase1(){
        let result = solution.Permutation("")
        XCTAssertEqual([], result)
    }
    func testCase2(){
        let result = solution.Permutation("a")
        XCTAssertEqual(["a"], result)
    }
    func testCase3(){
        let result = solution.Permutation("ab")
        XCTAssertEqual(["ab","ba"], result)
    }
    func testCase4(){
        let result = solution.Permutation("abc")
        XCTAssertEqual(["abc","acb","bac","bca","cba","cab"], result)
    }
}

UnitTests.defaultTestSuite.run()

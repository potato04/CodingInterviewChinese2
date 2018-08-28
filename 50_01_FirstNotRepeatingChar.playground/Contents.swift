//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题50（一）：字符串中第一个只出现一次的字符
// 题目：在字符串中找出第一个只出现一次的字符。如输入"abaccdeff"，则输出
// 'b'。

import Foundation
import XCTest

class Solution {
    
    /**
     - parameters:
        - string: 输入的字符串
     - Returns: 第一个不重复的字符
     解法：利用字典存储各个字符的出现次数
     */
    func getFirstNotRepeatingChar(_ string: String) -> Character? {
        let chars = Array(string)
        var dict = [Character:Int]()
        for char in chars {
            if dict[char] == nil {
                dict[char] = 1
            } else {
                dict[char]! += 1
            }
        }
        for char in chars {
            if dict[char]! == 1 {
                return char
            }
        }
        return nil
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        XCTAssertEqual("l", solution.getFirstNotRepeatingChar("google"))
    }
    func testCase2() {
        XCTAssertEqual(nil, solution.getFirstNotRepeatingChar("aabccdbd"))
    }
    func testCase3() {
        XCTAssertEqual("a", solution.getFirstNotRepeatingChar("abcdefg"))
    }
}

UnitTests.defaultTestSuite.run()







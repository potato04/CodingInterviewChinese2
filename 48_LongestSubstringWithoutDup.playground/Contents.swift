//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题48：最长不含重复字符的子字符串
// 题目：请从字符串中找出一个最长的不包含重复字符的子字符串，计算该最长子
// 字符串的长度。假设字符串中只包含从'a'到'z'的字符。

import Foundation
import XCTest

class Solution {
    
    /**
     求最长不含重复字符的子字符串
     - Parameters:
        - str: 字符串
     - Returns: 最长的不包含重复字符的子字符串长度
     解法：穷举法，验证所有的子字符串
     */
    func longestSubstringWithoutDuplication_1(_ str: String) -> Int {
        var longest = 0
        var chars = Array(str)
        
        for i in stride(from: 0, to: chars.count, by: 1) {
            for j in stride(from: i, to: chars.count, by: 1) {
                if !hasDuplication(String(chars[i...j])) {
                    let count = j - i + 1
                    if count > longest {
                        longest = count
                    }
                }
            }
        }
        return longest
    }
    /**
     判断字符串中是否包含重复字符
     - Parameters:
        - substring: 字符串
     - Returns: 判断结果
     */
    private func hasDuplication(_ substring: String) -> Bool {
        let chars = Array(substring)
        var result = [Character]()
        for char in chars {
            if result.contains(char) {
                return true
            } else {
                result.append(char)
            }
        }
        return false
    }
    
    /**
     求最长不含重复字符的子字符串
     - Parameters:
        - str: 字符串
     - Returns: 最长的不包含重复字符的子字符串长度
     解法：动态规划
     */
    func longestSubstringWithoutDuplication_2(_ str: String) -> Int {
        var curLength = 0
        var maxLength = 0
        let chars = Array(str)
        var position = [Character:Int]()
        for (i, char) in chars.enumerated() {
            let prePosition = position[char]
            if prePosition == nil || i - prePosition! > curLength {
                curLength += 1
            } else {
                if curLength > maxLength {
                    maxLength = curLength
                }
                curLength = i - prePosition!
            }
            position[char] = i
        }
        return max(curLength, maxLength)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1() {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("abcacfrar"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("abcacfrar"))
    }
    func testCase2() {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("acfrarabc"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("acfrarabc"))
    }
    func testCase3() {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("arabcacfr"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("arabcacfr"))
    }
    func testCase4() {
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_1("aaa"))
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_2("aaa"))
    }
    func testCase5() {
        XCTAssertEqual(7, solution.longestSubstringWithoutDuplication_1("abcdefg"))
        XCTAssertEqual(7, solution.longestSubstringWithoutDuplication_2("abcdefg"))
    }
    func testCase6() {
        XCTAssertEqual(2, solution.longestSubstringWithoutDuplication_1("aaabbbccc"))
        XCTAssertEqual(2, solution.longestSubstringWithoutDuplication_2("aaabbbccc"))
    }
    func testCase7() {
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_1("abcdcba"))
        XCTAssertEqual(4, solution.longestSubstringWithoutDuplication_2("abcdcba"))
    }
    func testCase8() {
        XCTAssertEqual(6, solution.longestSubstringWithoutDuplication_1("abcdaef"))
        XCTAssertEqual(6, solution.longestSubstringWithoutDuplication_2("abcdaef"))
    }
    func testCase9() {
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_1("a"))
        XCTAssertEqual(1, solution.longestSubstringWithoutDuplication_2("a"))
    }
    func testCase10() {
        XCTAssertEqual(0, solution.longestSubstringWithoutDuplication_1(""))
        XCTAssertEqual(0, solution.longestSubstringWithoutDuplication_2(""))
    }
}

UnitTests.defaultTestSuite.run()

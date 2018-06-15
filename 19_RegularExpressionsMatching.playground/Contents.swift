//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题19：正则表达式匹配
// 题目：请实现一个函数用来匹配包含'.'和'*'的正则表达式。模式中的字符'.'
// 表示任意一个字符，而'*'表示它前面的字符可以出现任意次（含0次）。在本题
// 中，匹配是指字符串的所有字符匹配整个模式。例如，字符串"aaa"与模式"a.a"
// 和"ab*ac*a"匹配，但与"aa.a"及"ab*a"均不匹配。


import Foundation
import XCTest

class Solution {
    /**
     - parameters:
     - str: 待匹配的字符串
     - pattern: 模式
     - Returns: 是否匹配
     */
    func match(str: String,pattern: String) -> Bool {
        return matchCore(str: Array(str), strIndex: 0, pattern: Array(pattern), patternIndex: 0)
    }
    private func matchCore(str: [Character], strIndex: Int, pattern: [Character], patternIndex: Int) -> Bool {
        if !inRange(str, strIndex) && !inRange(pattern, patternIndex) {
            return true
        }
        if inRange(str, strIndex) && !inRange(pattern, patternIndex) {
            return false
        }
        
        if inRange(pattern, patternIndex + 1) && pattern[patternIndex + 1] == "*" {
            if inRange(str, strIndex) &&
                (pattern[patternIndex] == "." || pattern[patternIndex] == str[strIndex]) {
                return matchCore(str:str, strIndex: strIndex + 1, pattern: pattern, patternIndex: patternIndex + 2) || matchCore(str:str, strIndex: strIndex + 1, pattern: pattern, patternIndex: patternIndex) || matchCore(str:str, strIndex: strIndex, pattern: pattern, patternIndex: patternIndex + 2)
            } else {
                return matchCore(str:str, strIndex: strIndex, pattern: pattern, patternIndex: patternIndex + 2)
            }
        }
        
        if(inRange(str, strIndex) && inRange(pattern, patternIndex)) &&
            (str[strIndex] == pattern[patternIndex] || (pattern[patternIndex] == ".")) {
            return matchCore(str:str, strIndex: strIndex + 1, pattern: pattern, patternIndex: patternIndex + 1)
        }
        return false
    }
    private func inRange<T>(_ arr: [T], _ index: Int) -> Bool {
        if index < arr.count {
            return true
        }
        return false
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1(){
        XCTAssertTrue(solution.match(str: "", pattern: ""))
        XCTAssertTrue(solution.match(str: "", pattern: ".*"))
        XCTAssertFalse(solution.match(str: "", pattern: "."))
        XCTAssertTrue(solution.match(str: "", pattern: "c*"))
        XCTAssertTrue(solution.match(str: "a", pattern: ".*"))
        XCTAssertFalse(solution.match(str: "a", pattern: "a."))
        XCTAssertFalse(solution.match(str: "a", pattern: ""))
        XCTAssertTrue(solution.match(str: "a", pattern: "."))
        XCTAssertTrue(solution.match(str: "a", pattern: "ab*"))
        XCTAssertFalse(solution.match(str: "a", pattern: "ab*a"))
        XCTAssertTrue(solution.match(str: "aa", pattern: "aa"))
        XCTAssertTrue(solution.match(str: "aa", pattern: "a*"))
        XCTAssertTrue(solution.match(str: "aa", pattern: ".*"))
        XCTAssertFalse(solution.match(str: "aa", pattern: "."))
        XCTAssertTrue(solution.match(str: "ab", pattern: ".*"))
        XCTAssertTrue(solution.match(str: "aaa", pattern: "aa*"))
        XCTAssertFalse(solution.match(str: "aaa", pattern: "aa.a"))
        XCTAssertTrue(solution.match(str: "aaa", pattern: "a.a"))
        XCTAssertFalse(solution.match(str: "aaa", pattern: ".a"))
        XCTAssertTrue(solution.match(str: "aaa", pattern: "a*a"))
        XCTAssertFalse(solution.match(str: "aaa", pattern: "ab*a"))
        XCTAssertTrue(solution.match(str: "aaa", pattern: "ab*ac*a"))
        XCTAssertTrue(solution.match(str: "aaa", pattern: "ab*a*c*a"))
        XCTAssertTrue(solution.match(str: "aaa", pattern: ".*"))
        XCTAssertTrue(solution.match(str: "aab", pattern: "c*a*b"))
        XCTAssertTrue(solution.match(str: "aaca", pattern: "ab*a*c*a"))
        XCTAssertFalse(solution.match(str: "aaba", pattern: "ab*a*c*a"))
        XCTAssertTrue(solution.match(str: "bbbba", pattern: ".*a*a"))
        XCTAssertFalse(solution.match(str: "bcbbabab", pattern: ".*a*a"))
    }
}

UnitTests.defaultTestSuite.run()







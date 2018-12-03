//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题58（一）：翻转单词顺序
// 题目：输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。
// 为简单起见，标点符号和普通字母一样处理。例如输入字符串"I am a student. "，
// 则输出"student. a am I"。


import Foundation
import XCTest

class Solution {
    
    /**
     翻转单词顺序
     - Parameters:
        - sentence: 翻转前的句子
     - Returns: 翻转之后的句子
     */
    func ReverseSentence(_ sentence: String) -> String {
        var chars:[Character] = Array(sentence)
        chars.reverse()
        let words = chars.split(separator: " ")
        guard words.count > 0 else {
            return String(chars)
        }
        var reversed = words.reduce("") {
            $0 + $1.reversed() + " "
        }
        if reversed.count > 1 {
            reversed.removeLast()
        }
        return reversed
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //多个单词
    func testCase1() {
        let data = "I am a student."
        XCTAssertEqual("student. a am I", solution.ReverseSentence(data))
    }
    //emoji
    func testCase2() {
        let data = "I ❤️ you."
        XCTAssertEqual("you. ❤️ I", solution.ReverseSentence(data))
    }
    //只有一个单词
    func testCase3() {
        let data = "Wonderful"
        XCTAssertEqual("Wonderful", solution.ReverseSentence(data))
    }
    //空字符串
    func testCase4() {
        let data = ""
        XCTAssertEqual("", solution.ReverseSentence(data))
    }
    //空格
    func testCase5() {
        let data = " "
        XCTAssertEqual(data, solution.ReverseSentence(data))
    }
}

UnitTests.defaultTestSuite.run()

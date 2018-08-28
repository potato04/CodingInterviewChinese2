//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题50（二）：字符流中第一个只出现一次的字符
// 题目：请实现一个函数用来找出字符流中第一个只出现一次的字符。例如，当从
// 字符流中只读出前两个字符"go"时，第一个只出现一次的字符是'g'。当从该字
// 符流中读出前六个字符"google"时，第一个只出现一次的字符是'l'。

import Foundation
import XCTest

class Solution {
    
    /**
     - parameters:
        - string: 输入的字符串
     - Returns: 第一个不重复的字符
     解法：利用字典存储各个字符的出现次数
     */
    func getFirstNotRepeatingChar() -> Character? {
        return dict.filter{ $0.value>=0 }.min {a, b in a.value < b.value }?.key
    }
    private var dict = [Character: Int]()
    private var index = 0
    func insert(_ char: Character) {
        if dict[char] == nil {
            dict[char] = index //存储对应的位置
        } else {
            dict[char] = -1 //标记该char已经出现重复情况
        }
        index += 1
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        //g , 第一个只出现一次的字符是 g
        solution.insert("g")
        XCTAssertEqual("g", solution.getFirstNotRepeatingChar())
        //go , 第一个只出现一次的字符是 g
        solution.insert("o")
        XCTAssertEqual("g", solution.getFirstNotRepeatingChar())
        //goo , 第一个只出现一次的字符是 g
        solution.insert("o")
        XCTAssertEqual("g", solution.getFirstNotRepeatingChar())
        //goog , 第一个只出现一次的字符是 nil（两个字符都重复了）
        solution.insert("g")
        XCTAssertEqual(nil, solution.getFirstNotRepeatingChar())
        //googl , 第一个只出现一次的字符是 l
        solution.insert("l")
        XCTAssertEqual("l", solution.getFirstNotRepeatingChar())
        //google , 第一个只出现一次的字符是 l
        solution.insert("e")
        XCTAssertEqual("l", solution.getFirstNotRepeatingChar())
        
    }
}

UnitTests.defaultTestSuite.run()







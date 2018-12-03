//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题58（二）：左旋转字符串
// 题目：字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。
// 请定义一个函数实现字符串左旋转操作的功能。比如输入字符串"abcdefg"和数
// 字2，该函数将返回左旋转2位得到的结果"cdefgab"。
import Foundation
import XCTest

class Solution {
    
    /**
     左旋转字符串
     - Parameters:
        - content: 字符串
        - n: 左旋转的字符个数
     - Returns: 左旋转之后的字符串
     */
    func LeftRotateString(_ content: String, _ n: Int) -> String {
        guard n > 0 && n < content.count  else {
            return content
        }
        var content = Array(content)
        let left = Array(content[0...n-1])
        var right = Array(content[n...])
        right.append(contentsOf: left)
        return String(right)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        let data = "abcdefg"
        XCTAssertEqual("bcdefga", solution.LeftRotateString(data, 1))
    }
    func testCase2() {
        let data = "abcdefg"
        XCTAssertEqual("cdefgab", solution.LeftRotateString(data, 2))
    }
    func testCase4() {
        let data = "abcdefg"
        XCTAssertEqual("gabcdef", solution.LeftRotateString(data, 6))
    }
    func testCase5() {
        let data = "abcdefg"
        XCTAssertEqual("abcdefg", solution.LeftRotateString(data, 0))
    }
    func testCase6() {
        let data = "abcdefg"
        XCTAssertEqual("abcdefg", solution.LeftRotateString(data, 7))
    }
}

UnitTests.defaultTestSuite.run()

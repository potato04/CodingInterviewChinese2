//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题20：表示数值的字符串
// 题目：请实现一个函数用来判断字符串是否表示数值（包括整数和小数）。例如，
// 字符串“+100”、“5e2”、“-123”、“3.1416”及“-1E-16”都表示数值，但“12e”、
// “1a3.14”、“1.2.3”、“+-5”及“12e+5.4”都不是

import Foundation
import XCTest

class Solution {
    
    private let digits: [Character] = ["0","1","2","3","4","5","6","7","8","9"]

    /**
     数字的格式可以用A[.[B]][e|EC]或者.B[e|EC]表示，其中A和C都是
     整数（可以有正负号，也可以没有），而B是一个无符号整数
     - Parameters:
        - str: 字符串
     - Returns: 字符串是否可以表示数值
     */
    func isNumeric(str: String) -> Bool {
        if str == "" {
            return false
        }
        let str = Array(str)
        //查找正负号以及整数部分
        var (numeric, index) = scanInteger(str: str, startIndex: 0)
        
        //如果之后是小数点
        if index < str.count && str[index] == "." {
            index += 1
            //查找小数点之后的数字部分
            let result = scanUnsignedInteger(str: str, startIndex: index)
            numeric = numeric || result.0
            index = result.1
        }
        //如果之后是e或者E
        if index < str.count - 1 && (str[index] == "e" || str[index] == "E") {
            index += 1
            let result = scanInteger(str: str, startIndex: index)
            numeric = numeric && result.0
            index = result.1
        }
        return numeric && (index == str.count)
    }
    /**
     匹配数值字符串中整数部分（可能包含+和-符号）
     - Parameters:
        - str: 字符串
        - startIndex: 当前匹配索引
     - Returns:(是否有整数部分, 整数结束索引)
     */
    private func scanInteger(str: [Character], startIndex: Int) -> (Bool, Int) {
        var startIndex = startIndex
        if str[startIndex] == "+" || str[startIndex] == "-" {
            startIndex += 1
        }
        return scanUnsignedInteger(str: str, startIndex: startIndex)
    }
    /**
     匹配数值字符串中无符号整数部分, A[.[B]][e|EC] 即：其中的A（移除正负符号后）和B
     - Parameters:
        - str: 字符串
        - startIndex: 当前匹配索引
     - Returns: (是否有整数部分, 整数结束索引)
     */
    private func scanUnsignedInteger(str: [Character], startIndex: Int) -> (Bool, Int) {
        var i = startIndex
        while i < str.count && digits.contains(str[i]) {
            i += 1
        }
        return (i > startIndex, i)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1(){
        XCTAssertEqual(solution.isNumeric(str: "100"), true)
        XCTAssertEqual(solution.isNumeric(str: "123.45e+6"), true)
        XCTAssertEqual(solution.isNumeric(str: "+500"), true)
        XCTAssertEqual(solution.isNumeric(str: "5e2"), true)
        XCTAssertEqual(solution.isNumeric(str: "3.1416"), true)
        XCTAssertEqual(solution.isNumeric(str: "600."), true)
        XCTAssertEqual(solution.isNumeric(str: "-.123"), true)
        XCTAssertEqual(solution.isNumeric(str: "-1E-16"), true)
        XCTAssertEqual(solution.isNumeric(str: "1.79769313486232E+308"), true)
        XCTAssertEqual(solution.isNumeric(str: "12e"), false)
        XCTAssertEqual(solution.isNumeric(str: "1a3.14"), false)
        XCTAssertEqual(solution.isNumeric(str: "1+23"), false)
        XCTAssertEqual(solution.isNumeric(str: "1.2.3"), false)
        XCTAssertEqual(solution.isNumeric(str: "+-5"), false)
        XCTAssertEqual(solution.isNumeric(str: "12e+5.4"), false)
        XCTAssertEqual(solution.isNumeric(str: "."), false)
        XCTAssertEqual(solution.isNumeric(str: ".e1"), false)
        XCTAssertEqual(solution.isNumeric(str: "+."), false)
        XCTAssertEqual(solution.isNumeric(str: ""), false)
    }
}

UnitTests.defaultTestSuite.run()

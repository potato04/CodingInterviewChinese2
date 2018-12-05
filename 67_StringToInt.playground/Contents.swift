//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题67：把字符串转换成整数
// 题目：请你写一个函数StrToInt，实现把字符串转换成整数这个功能。当然，不
// 能使用atoi或者其他类似的库函数。

import Foundation
import XCTest

class Solution1 {
    /*
     将字符串转换为整形
     - Parameters:
        - str: 需要转换成数字的字符串
     - Returns: 转换之后的整数
     */
    func StrToInt(str: String) -> Int? {
        var strArray = Array(str)
        guard strArray.count > 0 else {
            return nil
        }
        var minus = false
        if strArray.first == "-" {
            minus = true
            strArray.removeFirst()
        }
        else if strArray.first == "+" {
            strArray.removeFirst()
        }
        var num: UInt = 0
        for item in strArray {
            if let digit = Int(String(item)) {
                num = num * 10 + UInt(digit)
                if num > UInt(Int64.max) && !minus {
                    return nil
                }
                if num > UInt(Int64.max) + 1 && minus {
                    return nil
                }
            }
            else {
                return nil
            }
        }
        if num > Int.max && minus {
            return Int.min
        } else {
            return Int(num) * (minus ? -1 : 1)
        }
    }
}

class UnitTests: XCTestCase {
    let solution1 = Solution1()
    override func setUp() {
        super.setUp()
    }
    func testCase1() {
        XCTAssertEqual(nil, solution1.StrToInt(str: ""))
        XCTAssertEqual(123, solution1.StrToInt(str: "123"))
        XCTAssertEqual(123, solution1.StrToInt(str: "+123"))
        XCTAssertEqual(-123, solution1.StrToInt(str: "-123"))
        XCTAssertEqual(nil, solution1.StrToInt(str: "1a23"))
        XCTAssertEqual(0, solution1.StrToInt(str: "+0"))
        XCTAssertEqual(0, solution1.StrToInt(str: "-0"))
        XCTAssertEqual(0, solution1.StrToInt(str: "+"))
        XCTAssertEqual(0, solution1.StrToInt(str: "-"))
    }
    
    func testCase2() {
        //Int.max =  9223372036854775807
        //Int.min = -9223372036854775808
        XCTAssertEqual(9223372036854775807, solution1.StrToInt(str: "+9223372036854775807"))
        XCTAssertEqual(nil, solution1.StrToInt(str: "+9223372036854775808"))
        XCTAssertEqual(-9223372036854775808, solution1.StrToInt(str: "-9223372036854775808"))
        XCTAssertEqual(nil, solution1.StrToInt(str: "-9223372036854775809"))
    }
}

UnitTests.defaultTestSuite.run()

//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题21：调整数组顺序使奇数位于偶数前面
// 题目：输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有
// 奇数位于数组的前半部分，所有偶数位于数组的后半部分。


import Foundation
import XCTest

class Solution {
    /**
     - parameters:
     - array: 待排序的数组
     - Returns: 排序后的数组
     */
    func ReorderOddEven(array: [Int]) -> [Int] {
        return reorder(array: array, criteria: { ($0 % 2) == 0 ? false : true})
    }
    private func reorder(array: [Int], criteria: (Int) -> Bool) -> [Int] {
        var array = array
        var startIndex = 0
        var endIndex = array.count - 1
        while startIndex < endIndex {
            while startIndex < endIndex && criteria(array[startIndex]) {
                startIndex += 1
            }
            while startIndex < endIndex && !criteria(array[endIndex]) {
                endIndex -= 1
            }
            if startIndex < endIndex {
                let temp = array[startIndex]
                array[startIndex] = array[endIndex]
                array[endIndex] = temp
            }
        }
        return array
    }
    
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1(){
        let result = solution.ReorderOddEven(array: [1,2,3,4,5,6,7])
        XCTAssertEqual(result[0], 1)
        XCTAssertEqual(result[1], 7)
        XCTAssertEqual(result[2], 3)
        XCTAssertEqual(result[3], 5)
        XCTAssertEqual(result[4], 4)
        XCTAssertEqual(result[5], 6)
        XCTAssertEqual(result[6], 2)
    }
    func testCase2(){
        let result = solution.ReorderOddEven(array: [2,4,6,1,3,5,7])
        XCTAssertEqual(result[0], 7)
        XCTAssertEqual(result[1], 5)
        XCTAssertEqual(result[2], 3)
        XCTAssertEqual(result[3], 1)
        XCTAssertEqual(result[4], 6)
        XCTAssertEqual(result[5], 4)
        XCTAssertEqual(result[6], 2)
    }
    func testCase3(){
        let result = solution.ReorderOddEven(array: [1,3,5,7,2,4,6])
        XCTAssertEqual(result[0], 1)
        XCTAssertEqual(result[1], 3)
        XCTAssertEqual(result[2], 5)
        XCTAssertEqual(result[3], 7)
        XCTAssertEqual(result[4], 2)
        XCTAssertEqual(result[5], 4)
        XCTAssertEqual(result[6], 6)
    }
    func testCase4(){
        let result = solution.ReorderOddEven(array: [1])
        XCTAssertEqual(result[0], 1)
    }
    func testCase5(){
        let result = solution.ReorderOddEven(array: [2])
        XCTAssertEqual(result[0], 2)
    }
    
}

UnitTests.defaultTestSuite.run()







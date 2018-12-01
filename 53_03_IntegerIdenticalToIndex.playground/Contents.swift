//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题53（三）：数组中数值和下标相等的元素
// 题目：假设一个单调递增的数组里的每个元素都是整数并且是唯一的。请编程实
// 现一个函数找出数组中任意一个数值等于其下标的元素。例如，在数组{-3, -1,
// 1, 3, 5}中，数字3和它的下标相等。

import Foundation
import XCTest

class Solution {
    /**
     查找数组中数值和下标相等的元素
     - Parameters:
        - data: 递增数组
     - Returns: 数值与下标相等的元素
     解法：二分法，如果当前下标的元素值比下标大，则右边部分元素的值都比各自的下标大，继续查找左边。
     */
    func GetNumberSameAsIndex(in data: [Int]) -> Int? {
        guard data.count > 0 else {
            return nil
        }
        var start = 0
        var end = data.count - 1
        while start <= end {
            let mid = (start + end) / 2
            if data[mid] == mid {
                return mid
            }
            if data[mid] > mid {
                end = mid - 1
            } else {
                start = mid + 1
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
        let data = [-3,-1,1,3,5]
        XCTAssertEqual(3, solution.GetNumberSameAsIndex(in: data))
    }
    func testCase2() {
        let data = [0,1,3,5,6]
        XCTAssertEqual(0, solution.GetNumberSameAsIndex(in: data))
    }
    func testCase3() {
        let data = [-1,0,1,2,4]
        XCTAssertEqual(4, solution.GetNumberSameAsIndex(in: data))
    }
    func testCase4() {
        let data = [-1,0,1,2,5]
        XCTAssertEqual(nil, solution.GetNumberSameAsIndex(in: data))
    }
    func testCase5() {
        let data = [0]
        XCTAssertEqual(0, solution.GetNumberSameAsIndex(in: data))
    }
    func testCase6() {
        let data = [10]
        XCTAssertEqual(nil, solution.GetNumberSameAsIndex(in: data))
    }
    func testCase7() {
        let data:[Int] = []
        XCTAssertEqual(nil, solution.GetNumberSameAsIndex(in: data))
    }
    
}

UnitTests.defaultTestSuite.run()

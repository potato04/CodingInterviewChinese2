//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题53（一）：数字在排序数组中出现的次数
// 题目：统计一个数字在排序数组中出现的次数。例如输入排序数组{1, 2, 3, 3,
// 3, 3, 4, 5}和数字3，由于3在这个数组中出现了4次，因此输出4。

import Foundation
import XCTest

class Solution {
    /**
     - parameters:
        - data: 排序数组
        - k：查找的数字
     - Returns: 在数组中出现的次数
     解法：利用二分法分别查找连续出现数字的第一个和最后一个位置，根据两个位置可得出出现次数
     */
    func GetNumberOfK(in data: [Int], k:Int) -> Int {
        guard data.count > 0 else {
            return 0
        }
        let first = GetFirstK(in: data, k: k, from: 0, to: data.endIndex - 1)
        let last = GetLastK(in: data, k: k, from: 0, to: data.endIndex - 1)
        if first > -1 && last > -1 {
            return last - first + 1
        }
        return 0
    }
    /**
     - parameters:
        - data: 排序数组
        - k：查找的数字
        - startIndex：开始查找的位置
        - endIndex: 结束查找的位置
     - Returns: 在数组中第一次出现的位置（没有返回-1）
     */
    private func GetFirstK(in data: [Int], k: Int, from startIndex:  Int, to endIndex: Int) -> Int {
        var startIndex = startIndex, endIndex = endIndex
        guard endIndex >= startIndex else {
            return -1
        }
        let mid = (startIndex + endIndex) / 2
        
        if data[mid] == k {
            if (mid > 0 && data[mid-1] != k) {
                return mid
            } else if mid == 0 {
                return mid
            } else {
                endIndex = mid - 1
            }
        } else if data[mid] > k {
            endIndex = mid - 1
        } else {
            startIndex = mid + 1
        }
        return GetFirstK(in: data, k: k, from: startIndex, to: endIndex)
    }
    /**
     - parameters:
     - data: 排序数组
     - k：查找的数字
     - startIndex：开始查找的位置
     - endIndex: 结束查找的位置
     - Returns: 在数组中最后一次出现的位置（没有返回-1）
     */
    private func GetLastK(in data: [Int], k: Int, from startIndex:  Int, to endIndex: Int) -> Int {
        var startIndex = startIndex, endIndex = endIndex
        guard endIndex >= startIndex else {
            return -1
        }
        let mid = (startIndex + endIndex) / 2
        if data[mid] == k {
            if mid == data.endIndex - 1 {
                return mid
            } else if (mid > 0 && data[mid+1] != k) {
                return mid
            } else {
                startIndex = mid + 1
            }
        } else if data[mid] < k {
            startIndex = mid + 1
        } else {
            endIndex = mid - 1
        }
        return GetLastK(in: data, k: k, from: startIndex, to: endIndex)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 查找的数字出现在数组的中间
    func testCase1() {
        let data = [1,2,3,3,3,3,4,5]
        XCTAssertEqual(4, solution.GetNumberOfK(in: data, k: 3))
    }
    // 查找的数字出现在数组的开头
    func testCase2() {
        let data = [3,3,3,3,4,5]
        XCTAssertEqual(4, solution.GetNumberOfK(in: data, k: 3))
    }
    // 查找的数字出现在数组的结尾
    func testCase3() {
        let data = [1,2,3,3,3,3]
        XCTAssertEqual(4, solution.GetNumberOfK(in: data, k: 3))
    }
    // 查找的数字不存在
    func testCase4() {
        let data = [1,3,3,3,3,4,5]
        XCTAssertEqual(0, solution.GetNumberOfK(in: data, k: 2))
    }
    // 查找的数字比第一个数字还小，不存在
    func testCase5() {
        let data = [1,2,3,3,3,3,4,5]
        XCTAssertEqual(0, solution.GetNumberOfK(in: data, k: 0))
    }
    // 查找的数字比最后一个数字还大，不存在
    func testCase6() {
        let data = [1,2,3,3,3,3,4,5]
        XCTAssertEqual(0, solution.GetNumberOfK(in: data, k: 6))
    }
    // 数组中的数字从头到尾都是查找的数字
    func testCase7() {
        let data = [3,3,3,3]
        XCTAssertEqual(4, solution.GetNumberOfK(in: data, k: 3))
    }
    // 数组中的数字从头到尾只有一个重复的数字，不是查找的数字
    func testCase8() {
        let data = [3,3,3,3]
        XCTAssertEqual(0, solution.GetNumberOfK(in: data, k: 4))
    }
    // 数组中只有一个数字，是查找的数字
    func testCase9() {
        let data = [3]
        XCTAssertEqual(1, solution.GetNumberOfK(in: data, k: 3))
    }
    // 数组中只有一个数字，不是查找的数字
    func testCase10() {
        let data = [3]
        XCTAssertEqual(0, solution.GetNumberOfK(in: data, k: 4))
    }
    
}
UnitTests.defaultTestSuite.run()







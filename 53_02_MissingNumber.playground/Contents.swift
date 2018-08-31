//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题53（二）：0到n-1中缺失的数字
// 题目：一个长度为n-1的递增排序数组中的所有数字都是唯一的，并且每个数字
// 都在范围0到n-1之内。在范围0到n-1的n个数字中有且只有一个数字不在该数组
// 中，请找出这个数字。

import Foundation
import XCTest

class Solution {
    /**
     - parameters:
        - data: 递增数组
     - Returns: 缺失那个数字
     解法：利用二分法分别查找连续出现数字的第一个和最后一个位置，根据两个位置可得出出现次数
     */
    func GetMissingNumber(in data: [Int]) -> Int? {
        guard data.count > 0 else {
            return nil
        }
        var start = 0
        var end = data.endIndex - 1
        while start <= end {
            let mid = (start + end) / 2
            if data[mid] != mid {
                if mid == 0 || data[mid - 1] == mid - 1 {
                    //说明 mid 就是缺失的那个数
                    return mid
                }
                end = mid - 1 //往左半部分继续找
            } else {
                //data[mid] == mid 说明左边没有缺失，往右半部分继续找
                start = mid + 1
            }
        }
        if start == data.count {
            //查找到最后一个了，说明缺失的是最后一个
            return data.count
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
    
    //缺失第一个数字0
    func testCase1() {
        let data = [1,2,3,4,5]
        XCTAssertEqual(0, solution.GetMissingNumber(in: data))
    }
    //缺失最后一个数字5
    func testCase2() {
        let data = [0,1,2,3,4]
        XCTAssertEqual(5, solution.GetMissingNumber(in: data))
    }
    //缺失中间的数字3
    func testCase3() {
        let data = [0,1,2,4,5]
        XCTAssertEqual(3, solution.GetMissingNumber(in: data))
    }
    //数组只有一个数字，缺失0
    func testCase4() {
        let data = [1]
        XCTAssertEqual(0, solution.GetMissingNumber(in: data))
    }
    //数组只有一个数字，缺失1
    func testCase5() {
        let data = [0]
        XCTAssertEqual(1, solution.GetMissingNumber(in: data))
    }
    //空数组
    func testCase6() {
        let data:[Int] = []
        XCTAssertEqual(nil, solution.GetMissingNumber(in: data))
    }
}
UnitTests.defaultTestSuite.run()







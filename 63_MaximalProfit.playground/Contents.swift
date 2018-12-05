//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题63：股票的最大利润
// 题目：假设把某股票的价格按照时间先后顺序存储在数组中，请问买卖交易该股
// 票可能获得的利润是多少？例如一只股票在某些时间节点的价格为{9, 11, 8, 5,
// 7, 12, 16, 14}。如果我们能在价格为5的时候买入并在价格为16时卖出，则能
// 收获最大的利润11。

import Foundation
import XCTest

class Solution {
    /**
     获取股票的最大利润
     - Parameters:
        - nums：股票价格数组
     - Returns: 最大利益
     */
    func MaxDiff(_ nums:[Int]) -> Int? {
        guard nums.count > 1 else {
            //必须有2个或以上价格
            return nil
        }
        var min = nums[0]
        var maxDiff = nums[1] - min
        for i in 2..<nums.count {
            if nums[i-1] < min {
                min = nums[i-1]
            }
            let currentDiff = nums[i] - min
            if currentDiff > maxDiff {
                maxDiff = currentDiff
            }
        }
        return maxDiff
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //价格随机
    func testCase1() {
        let nums = [4,1,3,2,5]
        XCTAssertEqual(4, solution.MaxDiff(nums))
    }
    //价格递增
    func testCase2() {
        let nums = [1,2,4,7,11,16]
        XCTAssertEqual(15, solution.MaxDiff(nums))
    }
    //价格递减
    func testCase3() {
        let nums = [16,11,7,4,2,1]
        XCTAssertEqual(-1, solution.MaxDiff(nums))
    }
    //价格不变
    func testCase4() {
        let nums = [16,16,16,16,16]
        XCTAssertEqual(0, solution.MaxDiff(nums))
    }
    func testCase5() {
        let nums = [9,11,5,7,16,1,4,2]
        XCTAssertEqual(11, solution.MaxDiff(nums))
    }
    func testCase6() {
        let nums = [2,4]
        XCTAssertEqual(2, solution.MaxDiff(nums))
    }
    func testCase7() {
        let nums = [4,2]
        XCTAssertEqual(-2, solution.MaxDiff(nums))
    }
    func testCase8() {
        let nums = [Int]()
        XCTAssertEqual(nil, solution.MaxDiff(nums))
    }
}

UnitTests.defaultTestSuite.run()

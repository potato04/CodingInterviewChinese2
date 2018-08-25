//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题47：礼物的最大价值
// 题目：在一个m×n的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值
// （价值大于0）。你可以从棋盘的左上角开始拿格子里的礼物，并每次向左或
// 者向下移动一格直到到达棋盘的右下角。给定一个棋盘及其上面的礼物，请计
// 算你最多能拿到多少价值的礼物？

import Foundation
import XCTest

class Solution {
    
    /**
     - parameters:
        - gifts: 礼物的矩阵
     - Returns: 最大值
     解法：从数字的右边往左边进行递归计算，消除重复计算的问题
     */
    func getMaxValue_solution1(_ matrix: [[Int]]) -> Int {
        if matrix.count == 0 { return 0 }
        var maxValues = [[Int]]()
        for (i, gifts) in matrix.enumerated() {
            maxValues.append([Int]())
            for (j, gift) in gifts.enumerated() {
                maxValues[i].append(0)
                var left = 0
                var up = 0
                if i > 0 {
                    up = maxValues[i - 1][j]
                }
                if j > 0 {
                    left = maxValues[i][j-1]
                }
                maxValues[i][j] = max(left, up) + gift
            }
        }
        return maxValues.last!.last!
    }
    
    /**
     - parameters:
     - gifts: 礼物的矩阵
     - Returns: 最大值
     解法：从数字的右边往左边进行递归计算，消除重复计算的问题
     */
    func getMaxValue_solution2(_ matrix: [[Int]]) -> Int {
        if matrix.count == 0 { return 0 }
        var maxValues = [Int]()
        for (i, gifts) in matrix.enumerated() {
            for (j, gift) in gifts.enumerated() {
                if i == 0 { maxValues.append(0) }
                var left = 0
                var up = 0
                if i > 0 {
                    up = maxValues[j]
                }
                if j > 0 {
                    left = maxValues[j-1]
                }
                maxValues[j] = max(left, up) + gift
            }
        }
        return maxValues.last!
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1() {
        let matrix = [[1,2,3],[4,5,6],[7,8,9]]
        XCTAssertEqual(29, solution.getMaxValue_solution1(matrix))
        XCTAssertEqual(29, solution.getMaxValue_solution2(matrix))
    }
    func testCase2() {
        let matrix = [[1,10,3,8],[12,2,9,6],[5,7,4,11],[3,7,16,5]]
        XCTAssertEqual(53, solution.getMaxValue_solution1(matrix))
        XCTAssertEqual(53, solution.getMaxValue_solution2(matrix))
    }
    func testCase3() {
        let matrix = [[1,10,3,8]]
        XCTAssertEqual(22, solution.getMaxValue_solution1(matrix))
        XCTAssertEqual(22, solution.getMaxValue_solution2(matrix))
    }
    func testCase4() {
        let matrix = [[1],[12],[5],[3]]
        XCTAssertEqual(21, solution.getMaxValue_solution1(matrix))
        XCTAssertEqual(21, solution.getMaxValue_solution2(matrix))
    }
    func testCase5() {
        let matrix = [[3]]
        XCTAssertEqual(3, solution.getMaxValue_solution1(matrix))
        XCTAssertEqual(3, solution.getMaxValue_solution2(matrix))
    }
}

UnitTests.defaultTestSuite.run()







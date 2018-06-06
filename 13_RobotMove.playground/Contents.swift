//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题13：机器人的运动范围
// 题目：地上有一个m行n列的方格。一个机器人从坐标(0, 0)的格子开始移动，它
// 每一次可以向左、右、上、下移动一格，但不能进入行坐标和列坐标的数位之和
// 大于k的格子。例如，当k为18时，机器人能够进入方格(35, 37)，因为3+5+3+7=18。
// 但它不能进入方格(35, 38)，因为3+5+3+8=19。请问该机器人能够到达多少个格子？

import Foundation
import XCTest

class Solution {
    /**
     - parameters:
        - rows: 方格行数
        - cols: 方格列数
        - k: 行坐标和列坐标的数位之和限制
      - Returns: 返回能够到达格子数
     */
    func Count(rows: Int, cols: Int, k: Int) -> Int{
        var visited = Array(repeating: Array(repeating: false, count: cols), count: rows)
        return CountCore(&visited, row: 0, col: 0, k: k)
    }
    private func CountCore(_ visited: inout [[Bool]], row: Int, col: Int, k: Int) -> Int {
        var count = 0
        if col >= 0 && row >= 0 &&
            row < visited.count && col < visited[0].count &&
            DigitSum(i: row) + DigitSum(i: col) <= k &&
            !visited[row][col] {
            
            visited[row][col] = true
            count = 1 + CountCore(&visited, row: row - 1, col: col, k: k) +
                CountCore(&visited, row: row, col: col - 1, k: k) +
                CountCore(&visited, row: row + 1, col: col,  k: k) +
                CountCore(&visited, row: row, col: col + 1,  k: k)
        }
        return count
    }
    private func DigitSum(i: Int) -> Int {
        var i = i, sum = 0
        while i > 0 {
            sum += i % 10
            i /= 10
        }
        return sum
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    //10行10列 k为5
    func testCase1() {
        XCTAssertEqual(solution.Count(rows: 10, cols: 10, k: 5), 21)
    }
    //20行20列 k为15
    func testCase2() {
        XCTAssertEqual(solution.Count(rows: 20, cols: 20, k: 15), 359)
    }
    
    //1行100列 k为10
    func testCase3() {
        XCTAssertEqual(solution.Count(rows: 1, cols: 100, k: 10), 29)
    }
    //1行10列 k为10
    func testCase4() {
        XCTAssertEqual(solution.Count(rows: 1, cols: 10, k: 10), 10)
    }
    
    //10行1列 k为15
    func testCase5() {
        XCTAssertEqual(solution.Count(rows: 100, cols: 1, k: 15), 79)
    }
    //100行1列 k为15
    func testCase6() {
        XCTAssertEqual(solution.Count(rows: 10, cols: 1, k: 15), 10)
    }
    
    //1行1列 k为1
    func testCase7() {
        XCTAssertEqual(solution.Count(rows: 1, cols: 1, k: 15), 1)
    }
    //1行1列 k为1
    func testCase8() {
        XCTAssertEqual(solution.Count(rows: 1, cols: 1, k: 0), 1)
    }
    //10行10列 k为负数
    func testCase9() {
        XCTAssertEqual(solution.Count(rows: 10, cols: 10, k: -1), 0)
    }
    
    
}

UnitTests.defaultTestSuite.run()







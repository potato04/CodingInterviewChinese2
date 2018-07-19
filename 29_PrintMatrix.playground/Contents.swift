//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题29：顺时针打印矩阵
// 题目：输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。

import Foundation
import XCTest

class Solution {
    /**
     打印（返回）矩阵顺时针序列
     - parameters:
        - numbers: 矩阵（二维数组）
     - Returns: 顺时针序列
     */
    func PrintMatrixClockwise(_ numbers:[[Int]]) -> [Int]?{
        guard numbers.count > 0 && numbers[0].count > 0 else {
            return nil
        }
        var start = 0
        var result = [Int]()
        while numbers.count > start * 2 && numbers[start].count > start * 2 {
            result.append(contentsOf: PrintMatrixInCircle(numbers, start: start))
            start += 1
        }
        return result
    }
    private func PrintMatrixInCircle(_ numbers:[[Int]], start: Int) -> [Int] {
        let endX = numbers[start].count - 1 - start
        let endY = numbers.count - 1 - start
        var result = [Int]()
        //从左到右打印一行
        for i in stride(from: start, through: endX, by: 1) {
            result.append(numbers[start][i])
        }
        //从上到下打印一列
        if start < endY {
            for i in stride(from: start + 1, through: endY, by: 1) {
                result.append(numbers[i][endX])
            }
        }
        //从右到左打印一行
        if start < endX && start < endY {
            for i in stride(from: endX - 1, through: start, by: -1) {
                result.append(numbers[endY][i])
            }
        }
        //从下到上打印一列
        if start < endX && start < endY - 1 {
            for i in stride(from: endY - 1, through: start + 1, by: -1) {
                result.append(numbers[i][start])
            }
        }
        return result
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    /*
     1
     */
    func testCase1() {
        let matrix:[[Int]] = [[1]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1])
    }
    /*
     1 2
     3 4
     */
    func testCase2() {
        let matrix:[[Int]] = [[1,2],[3,4]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,4,3])
    }
    /*
      1  2  3  4
      5  6  7  8
      9 10 11 12
     13 14 15 16
     */
    func testCase3() {
        let matrix:[[Int]] = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,8,12,16,15,14,13,9,5,6,7,11,10])
    }
    /*
     1  2  3  4  5
     6  7  8  9 10
    11 12 13 14 15
    16 17 18 19 20
    21 22 23 24 25
     */
    func testCase4() {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20],[21,22,23,24,25]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) ==
            [1,2,3,4,5,10,15,20,25,24,23,22,21,16,11,6,7,8,9,14,19,18,17,12,13])
    }
    /*
     1
     2
     3
     4
     5
     */
    func testCase5() {
        let matrix:[[Int]] = [[1],[2],[3],[4],[5]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,5])
    }
    
    /*
     1    2
     3    4
     5    6
     7    8
     9    10
     */
    func testCase6() {
        let matrix:[[Int]] = [[1,2],[3,4],[5,6],[7,8],[9,10]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,4,6,8,10,9,7,5,3])
    }
    /*
     1    2    3
     4    5    6
     7    8    9
     10   11   12
     13   14   15
     */
    func testCase7() {
        let matrix:[[Int]] = [[1,2,3],[4,5,6],[7,8,9],[10,11,12],[13,14,15]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,6,9,12,15,14,13,10,7,4,5,8,11])
    }
    /*
     1    2    3    4
     5    6    7    8
     9    10   11   12
     13   14   15   16
     17   18   19   20
     */
    func testCase8() {
        let matrix:[[Int]] = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16],[17,18,19,20]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,8,12,16,20,19,18,17,13,9,5,6,7,11,15,14,10])
    }
    /*
     1    2    3    4    5
     */
    func testCase9() {
        let matrix:[[Int]] = [[1,2,3,4,5]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,5])
    }
    /*
     1    2    3    4    5
     6    7    8    9    10
     */
    func testCase10() {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,5,10,9,8,7,6])
    }
    
    /*
     1    2    3    4    5
     6    7    8    9    10
     11   12   13   14    15
     */
    func testCase11() {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,5,10,15,14,13,12,11,6,7,8,9])
    }
    /*
     1    2    3    4    5
     6    7    8    9    10
     11   12   13   14   15
     16   17   18   19   20
     */
    func testCase12() {
        let matrix:[[Int]] = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20]]
        XCTAssertTrue(solution.PrintMatrixClockwise(matrix) == [1,2,3,4,5,10,15,20,19,18,17,16,11,6,7,8,9,14,13,12])
    }
}

UnitTests.defaultTestSuite.run()







//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题51：数组中的逆序对
// 题目：在数组中的两个数字如果前面一个数字大于后面的数字，则这两个数字组
// 成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。

import Foundation
import XCTest

class Solution {
    
    /**
     求数组中的逆序对
     - Parameters:
        - data: 输入的数组
     - Returns: pairCount:逆序对的个数 merged 合并后的数组
     解法：利用归并排序算法，left 和 right 部分分别从尾到头进行合并，如果当前合并 left > right，则逆序对的数量记上 right 部分未合并项的数量
     */
    func InversePairs<T: Comparable>(_ data: [T]) -> (pairCount:Int, merged:[T]) {
        guard data.count > 1 else { return (0, data) }
        let mid = data.count / 2
        let leftResult = InversePairs(Array(data[0..<mid]))
        let rightResult = InversePairs(Array(data[mid...]))
        let mergedResult = InversePairsCore(leftResult.merged, rightResult.merged)
        return (leftResult.pairCount + rightResult.pairCount + mergedResult.pairCount, mergedResult.merged)
    }
    /**
     合并左右两个数组，并排序
     - Parameters:
        - leftPile: 左数组
        - rightPile: 右数组
     - Returns: pairCount:逆序对的个数 merged 合并后的数组
     */
    func InversePairsCore<T: Comparable>(_ leftPile: [T], _ rightPile:[T]) -> (pairCount:Int, merged:[T]) {
        var leftIndex = leftPile.endIndex - 1
        var rightIndex = rightPile.endIndex - 1
        var orderedPile:[T] = []
        var count = 0
        if orderedPile.capacity < leftPile.count + rightPile.count {
            orderedPile.reserveCapacity(leftPile.count + rightPile.count)
        }
        while true {
            guard leftIndex >= 0 else {
                for i in stride(from: rightIndex, through: 0, by: -1) {
                    orderedPile.insert(rightPile[i], at: 0)
                }
                break
            }
            guard rightIndex >= 0 else {
                for i in stride(from: leftIndex, through: 0, by: -1) {
                    orderedPile.insert(leftPile[i], at: 0)
                }
                break
            }
            if leftPile[leftIndex] > rightPile[rightIndex] {
                orderedPile.insert(leftPile[leftIndex], at: 0)
                leftIndex -= 1
                count = count + rightIndex + 1
            } else {
                orderedPile.insert(rightPile[rightIndex], at: 0)
                rightIndex -= 1
            }
        }
        return (count, orderedPile)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        let data = [1,2,3,4,7,6,5]
        XCTAssertEqual(3, solution.InversePairs(data).pairCount)
    }
    func testCase2() {
        let data = [6,5,4,3,2,1]
        XCTAssertEqual(15, solution.InversePairs(data).pairCount)
    }
    func testCase3() {
        let data = [1,2,3,4,5,6]
        XCTAssertEqual(0, solution.InversePairs(data).pairCount)
    }
    func testCase4() {
        let data = [1]
        XCTAssertEqual(0, solution.InversePairs(data).pairCount)
    }
    func testCase5() {
        let data = [1,2]
        XCTAssertEqual(0, solution.InversePairs(data).pairCount)
    }
    func testCase6() {
        let data = [2,1]
        XCTAssertEqual(1, solution.InversePairs(data).pairCount)
    }
    func testCase7() {
        let data = [1,2,1,2,1]
        XCTAssertEqual(3, solution.InversePairs(data).pairCount)
    }
}

UnitTests.defaultTestSuite.run()

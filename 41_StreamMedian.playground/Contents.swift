//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题41：数据流中的中位数
// 题目：如何得到一个数据流中的中位数？如果从数据流中读出奇数个数值，那么
// 中位数就是所有数值排序之后位于中间的数值。如果从数据流中读出偶数个数值，
// 那么中位数就是所有数值排序之后中间两个数的平均值。

import Foundation
import XCTest

class Solution {
    
    /**
     获取数据流中的中位数
     - Parameters:
        - nums: n个数
     - Returns: 中位数
     */
    func GetMedian(_ nums: [Double]) -> Double? {
        if nums.count == 0 { return nil }
        var maxHeap = Heap<Double>(sort: >)
        var minHeap = Heap<Double>(sort: <)
        //将数据分别插入到最大堆和最小堆中
        for num in nums {
            if (maxHeap.count + minHeap.count) % 2 == 0 {
                //1.两个堆的总数和为偶数，需要将数据插入至最小堆
                //1.1 如果该数比最大堆的数还要小，则需要先插入最大堆，然后把最大堆的最大数（root）插入到最小堆
                //1.2 否则，直接插入最小堆
                var insertToMinHeap = num
                if maxHeap.count > 0 && num < maxHeap.peek()! {
                    insertToMinHeap = maxHeap.peek()!
                    maxHeap.insert(num)
                    maxHeap.remove()
                }
                minHeap.insert(insertToMinHeap)
            } else {
                //2.两个堆的总数和为奇数，需要插入至最大堆
                //2.1 如果该数比最小堆的数还要大，则需要先插入最小堆，然后把最小堆的最小数(root)插入到最大堆
                //2.2 否则，直接插入最大堆
                var insertToMaxHeap = num
                if minHeap.count > 0 && num > minHeap.peek()! {
                    insertToMaxHeap = minHeap.peek()!
                    minHeap.insert(num)
                    minHeap.remove()
                }
                maxHeap.insert(insertToMaxHeap)
            }
        }
        //开始获取中位数
        let size = minHeap.count + maxHeap.count
        if size % 2 == 0 {
            //两堆总数一致,取平均数
            return (minHeap.peek()! + Double(maxHeap.peek()!)) / 2.0
        } else {
            return minHeap.peek()
        }
    }
    
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func testCase1() {
        XCTAssertEqual(solution.GetMedian([5]), 5)
        XCTAssertEqual(solution.GetMedian([5,2]), 3.5)
        XCTAssertEqual(solution.GetMedian([5,2,3]), 3)
        XCTAssertEqual(solution.GetMedian([5,2,3,4]), 3.5)
        XCTAssertEqual(solution.GetMedian([5,2,3,4,1]), 3)
        XCTAssertEqual(solution.GetMedian([5,2,3,4,1,6]), 3.5)
        XCTAssertEqual(solution.GetMedian([5,2,3,4,1,6,7]), 4)
        XCTAssertEqual(solution.GetMedian([5,2,3,4,1,6,7,0]), 3.5)
        XCTAssertEqual(solution.GetMedian([5,2,3,4,1,6,7,0,8]), 4)
    }
}

UnitTests.defaultTestSuite.run()

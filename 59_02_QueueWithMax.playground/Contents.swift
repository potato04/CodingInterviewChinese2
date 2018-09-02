//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题59（二）：队列的最大值
// 题目：定义一个队列，并实现函数 max 得到队列里的最大值
// 要求函数 max、push、pop的时间复杂度都是 O(1)


import Foundation
import XCTest

class Solution {
    private var maximums = [(value: Int, index: Int)]()
    private var data = [(value: Int, index: Int)]()
    private var currentIndex = 0
    
    public func push(_ num: Int) {
        while maximums.count > 0 && num >= maximums.last!.value {
            maximums.removeLast()
        }
        data.append((num, currentIndex))
        maximums.append((num, currentIndex))
        currentIndex += 1
    }
    public func pop() {
        guard data.count > 0 else {
            return
        }
        if maximums.first!.index == data.first!.index {
            maximums.removeFirst()
        }
        data.removeFirst()
    }
    public func max() -> Int? {
        guard maximums.count > 0 else {
            return nil
        }
        return maximums.first!.value
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    func testCase1() {
        //[2]
        solution.push(2)
        XCTAssertEqual(2, solution.max())
        
        //[2,3]
        solution.push(3)
        XCTAssertEqual(3, solution.max())
        
        //[2,3,4]
        solution.push(4)
        XCTAssertEqual(4, solution.max())
        
        //[2,3,4,2]
        solution.push(2)
        XCTAssertEqual(4, solution.max())
        
        //[3,4,2]
        solution.pop()
        XCTAssertEqual(4, solution.max())
        
        //[4,2]
        solution.pop()
        XCTAssertEqual(4, solution.max())
        
        //[2]
        solution.pop()
        XCTAssertEqual(2, solution.max())
        
        //[2,6]
        solution.push(6)
        XCTAssertEqual(6, solution.max())
        
        //[2,6,2]
        solution.push(2)
        XCTAssertEqual(6, solution.max())
        
        //[2,6,2,5]
        solution.push(5)
        XCTAssertEqual(6, solution.max())
        
        //[6,2,5]
        solution.pop()
        XCTAssertEqual(6, solution.max())
        
        //[2,5]
        solution.pop()
        XCTAssertEqual(5, solution.max())
        
        //[5]
        solution.pop()
        XCTAssertEqual(5, solution.max())
        
        //[5,1]
        solution.push(1)
        XCTAssertEqual(5, solution.max())
        
    }
}
UnitTests.defaultTestSuite.run()







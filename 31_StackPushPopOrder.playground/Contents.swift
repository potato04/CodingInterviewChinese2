//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题31：栈的压入、弹出序列
// 题目：输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是
// 否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如序列1、2、3、4、
// 5是某栈的压栈序列，序列4、5、3、2、1是该压栈序列对应的一个弹出序列，但
// 4、3、5、1、2就不可能是该压栈序列的弹出序列。

import Foundation
import XCTest

class Solution {
    func isPopOrder(pushList:[Int], popList:[Int]) -> Bool {
        var result = false
        guard pushList.count == popList.count && pushList.count > 0  else {
            return result
        }
        //辅助栈（用数组替代）
        var tmpArray = [Int]()
        var pushCount = 0
        var popCount = 0
        while popCount < popList.count {
            while tmpArray.isEmpty || tmpArray.last != popList[popCount] {
                if pushCount == pushList.count {
                    break
                }
                tmpArray.append(pushList[pushCount])
                pushCount += 1
            }
            if tmpArray.last != popList[popCount] {
                break
            }
            tmpArray.removeLast()
            popCount += 1
        }
        if tmpArray.isEmpty && popCount ==  popList.count {
            result = true
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

    func testCase1() {
        XCTAssertTrue(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [4,5,3,2,1]))
    }
    func testCase2() {
        XCTAssertTrue(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [3,5,4,2,1]))
    }
    func testCase3() {
        XCTAssertFalse(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [4,3,5,1,2]))
    }
    func testCase4() {
        XCTAssertFalse(solution.isPopOrder(pushList: [1,2,3,4,5], popList: [3,5,4,1,2]))
    }
    func testCase5() {
        XCTAssertFalse(solution.isPopOrder(pushList: [1], popList: [2]))
    }
    func testCase6() {
        XCTAssertTrue(solution.isPopOrder(pushList: [1], popList: [1]))
    }
}

UnitTests.defaultTestSuite.run()







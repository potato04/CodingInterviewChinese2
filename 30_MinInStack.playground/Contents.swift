//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题30：包含min函数的栈
// 题目：定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的min
// 函数。在该栈中，调用min、push及pop的时间复杂度都是O(1)。

import Foundation
import XCTest

struct StackWithMin<T: Comparable> {
    private var dataArray = Array<T>()
    private var minArray = Array<T>() //赋值栈，存放栈的最小元素
    
    mutating func push(_ value: T){
        dataArray.append(value)
        
        //当新元素比之前的最小元素小时，把新元素插入辅助栈里
        //否则把之前的最小元素重复插入辅助栈里
        if minArray.count == 0 || value < minArray.last! {
            minArray.append(value)
        } else {
            minArray.append(minArray.last!)
        }
    }
    
    mutating func pop() -> T? {
        if dataArray.count > 0 && minArray.count > 0 {
            minArray.removeLast()
            return dataArray.removeLast()
        }
        return nil
    }
    func min() -> T? {
        return minArray.last
    }
    func top() -> T? {
        return dataArray.last
    }
    func empty() -> Bool {
        return dataArray.isEmpty
    }
    func size() -> Int {
        return dataArray.count
    }
    
}

class UnitTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testCase1() {
        var stack = StackWithMin<Int>()
        stack.push(3)
        XCTAssertEqual(stack.min(), 3)
        stack.push(4)
        XCTAssertEqual(stack.min(), 3)
        stack.push(2)
        XCTAssertEqual(stack.min(), 2)
        stack.push(3)
        XCTAssertEqual(stack.min(), 2)
        stack.pop()
        XCTAssertEqual(stack.min(), 2)
        stack.pop()
        XCTAssertEqual(stack.min(), 3)
        stack.pop()
        XCTAssertEqual(stack.min(), 3)
        stack.push(0)
        XCTAssertEqual(stack.min(), 0)
    }
}

UnitTests.defaultTestSuite.run()







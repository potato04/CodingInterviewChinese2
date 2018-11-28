//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题30：包含min函数的栈
// 题目：定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的min
// 函数。在该栈中，调用min、push及pop的时间复杂度都是O(1)。

import Foundation
import XCTest

struct StackWithMin<T: Comparable> {
    private var dataArray = Array<T>() //数据栈
    private var minArray = Array<T>() //辅助栈，存放数据栈历次push元素后的最小元素，数据栈pop之后同样也pop该栈的元素
    /**
     元素入栈
     - Parameters:
        - value: 入栈的元素
     */
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
    /**
     元素出栈
     - Returns: 出栈的元素
     */
    mutating func pop() -> T? {
        if dataArray.count > 0 && minArray.count > 0 {
            minArray.removeLast()
            return dataArray.removeLast()
        }
        return nil
    }
    /**
     返回栈的最小值
     - Returns: 最小值的元素
     */
    func min() -> T? {
        return minArray.last
    }
    /**
     获取栈顶的元素
     - Returns: 栈顶元素
     */
    func top() -> T? {
        return dataArray.last
    }
    /**
     判断栈是否为空
     - Returns: 判断栈是否为空
     */
    func empty() -> Bool {
        return dataArray.isEmpty
    }
    /**
     返回栈大小
     - Returns: 栈大小
     */
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

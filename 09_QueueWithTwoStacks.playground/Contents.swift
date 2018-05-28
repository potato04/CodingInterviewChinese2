//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题9：用两个栈实现队列
// 题目：用两个栈实现一个队列。队列的声明如下，请实现它的两个函数appendTail
// 和deleteHead，分别完成在队列尾部插入结点和在队列头部删除结点的功能。
//
// 备注：使用array模拟stack，只用了数组的append和removeLast方法

import Foundation
import XCTest

class MyQueue<T> {
    private var array1 = [T]()
    private var array2 = [T]()
    
    func appendTail(element: T) {
        array1.append(element)
    }
    func deleteHead() -> T? {
        if array2.count > 0 {
          return array2.removeLast()
        } else {
            while array1.count > 0 {
                array2.append(array1.removeLast())
            }
            if array2.count > 0 {
                return array2.removeLast()
            } else {
                return nil
            }
        }
    }
    
}


class UnitTests: XCTestCase {
    var queue: MyQueue<Int>!
    
    override func setUp(){
        super.setUp()
        queue = MyQueue<Int>()
    }
    
    func testCase1() {
        queue.appendTail(element: 1)
        queue.appendTail(element: 2)
        queue.appendTail(element: 3)

        XCTAssertEqual(1, queue.deleteHead()!)
        XCTAssertEqual(2, queue.deleteHead()!)
        
        queue.appendTail(element: 4)
        XCTAssertEqual(3, queue.deleteHead()!)
        
        queue.appendTail(element: 5)
        XCTAssertEqual(4, queue.deleteHead()!)
        
        XCTAssertEqual(5, queue.deleteHead()!)
    }
}
    

UnitTests.defaultTestSuite.run()







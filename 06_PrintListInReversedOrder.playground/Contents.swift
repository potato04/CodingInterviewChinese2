//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题6：从尾到头打印链表
// 题目：输入一个链表的头结点，从尾到头反过来打印出每个结点的值。

// 本代码解法，使用一个栈存储各个节点 😓, 再反向打印
// 其他解法： 比如递归调用，或者修改链表

import Foundation
import XCTest

class ListNode {
    var next: ListNode?
    var value: Int
    
    init(value: Int, next: ListNode?) {
        self.value = value
        self.next = next
    }
}

class Solution {
    /**
     从尾到头打印链表
     - parameters:
     - listnode: 头结点
     - Returns:
     */
    func printListNode(_ node: ListNode){
        var nodes = [ListNode]()
        var currentNode:ListNode? = node
        while currentNode != nil {
            nodes.append(currentNode!)
            currentNode = currentNode!.next
        }
        for node in nodes.reversed() {
            print(node.value)
        }
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    /// 1->2->3->4->5
    func testCase1() {
        let node5 = ListNode(value: 5, next: nil)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        
        solution.printListNode(node1)
    }
    
    ///只有一个节点 1
    func testCase2() {
        let node1 = ListNode(value: 1, next: nil)
        solution.printListNode(node1)
    }
    
}

UnitTests.defaultTestSuite.run()





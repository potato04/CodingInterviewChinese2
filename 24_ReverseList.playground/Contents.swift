//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题24：反转链表
// 题目：定义一个函数，输入一个链表的头结点，反转该链表并输出反转后链表的
// 头结点。


import Foundation
import XCTest

//定义链表节点
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
     
     - parameters:
     - head: 链表的头节点
     - Returns: 返回旋转之后的链表
     */
    func ReverseList(_ head: ListNode?) -> ListNode? {
        var reversedHead: ListNode? = nil
        var node: ListNode? = head
        var prev: ListNode? = nil
        while node != nil {
            let next = node?.next
            if next == nil {
                reversedHead = node
            }
            node?.next = prev
            prev = node
            node = next
        }
        return reversedHead
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //多个节点
    func testCase1(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        let head = solution.ReverseList(node1)
        XCTAssertEqual(head?.value, 5)
        XCTAssertEqual(head?.next?.value, 4)
        XCTAssertEqual(head?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.value, 2)
        XCTAssertEqual(head?.next?.next?.next?.next?.value, 1)
    }
    //1个节点
    func testCase2(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let head = solution.ReverseList(node1)
        XCTAssertEqual(head?.value, 1)
    }
    //空链表
    func testCase3(){
        let head = solution.ReverseList(nil)
        XCTAssertNil(head)
    }
    
}

UnitTests.defaultTestSuite.run()







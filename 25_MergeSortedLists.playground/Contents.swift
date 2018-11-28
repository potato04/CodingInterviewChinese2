//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题25：合并两个排序的链表
// 题目：输入两个递增排序的链表，合并这两个链表并使新链表中的结点仍然是按
// 照递增排序的。例如输入如下链表1和链表2，则合并之后的升序链表如链
// 表3所示。
// 链表1：1->3->5->7
// 链表2：2->4->6->8
// 链表3：1->2->3->4->5->6->7->8

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
     合并两个排序链表，并仍旧有序
     - Parameters:
        - node1: 链表1的头结点
        - node2: 链表2的头结点
     - Returns: 合并后的链表头节点
     */
    func Merge(_ node1: ListNode?, _ node2: ListNode?) -> ListNode? {
        if node1 == nil {
            return node2
        } else if node2 == nil {
            return node1
        }
        var newHead: ListNode? = nil
        if node1!.value < node2!.value {
            newHead = node1
            newHead?.next =  Merge(node1?.next, node2)
        } else {
            newHead = node2
            newHead?.next = Merge(node1, node2?.next)
        }
        return newHead
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //list1: 1->3->5
    //list2: 2->4->6
    func testCase1(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node3
        node3.next = node5
        
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node6:ListNode = ListNode(value: 6, next: nil)
        node2.next = node4
        node4.next = node6
        
        let head = solution.Merge(node1, node2)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 2)
        XCTAssertEqual(head?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.value, 4)
        XCTAssertEqual(head?.next?.next?.next?.next?.value, 5)
        XCTAssertEqual(head?.next?.next?.next?.next?.next?.value, 6)
    }
    //list1: 1->3->5
    //list2: 1->3->5
    func testCase2(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node3
        node3.next = node5
        
        let node2:ListNode = ListNode(value: 1, next: nil)
        let node4:ListNode = ListNode(value: 3, next: nil)
        let node6:ListNode = ListNode(value: 5, next: nil)
        node2.next = node4
        node4.next = node6
        
        let head = solution.Merge(node1, node2)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 1)
        XCTAssertEqual(head?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.next?.next?.value, 5)
        XCTAssertEqual(head?.next?.next?.next?.next?.next?.value, 5)
    }
    //list1: 1
    //list2: 2
    func testCase3(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        
        let node2:ListNode = ListNode(value: 2, next: nil)
        
        let head = solution.Merge(node1, node2)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 2)
    }
    //list1: 1->3->5
    //list2: nil
    func testCase4(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node3
        node3.next = node5
        
        let head = solution.Merge(node1, nil)
        XCTAssertEqual(head?.value, 1)
        XCTAssertEqual(head?.next?.value, 3)
        XCTAssertEqual(head?.next?.next?.value, 5)
    }
    //list1: nil
    //list2: nil
    func testCase5(){
        let head = solution.Merge(nil, nil)
        XCTAssertNil(head)
    }
}

UnitTests.defaultTestSuite.run()

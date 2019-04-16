//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题22：链表中倒数第k个结点
// 题目：输入一个链表，输出该链表中倒数第k个结点。为了符合大多数人的习惯，
// 本题从1开始计数，即链表的尾结点是倒数第1个结点。例如一个链表有6个结点，
// 从头结点开始它们的值依次是1、2、3、4、5、6。这个链表的倒数第3个结点是
// 值为4的结点。

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
     查找链表中的倒数第K个节点
     - Parameters:
        - head: 链表的头节点
     - Returns: 倒数第k个节点（从1开始计数，最后一个即为倒数第1个）
     */
    func FindKthToTail(_ head: ListNode?, k: Int) -> ListNode? {
        if head == nil || k <= 0 {
            return nil
        }
        var pNode1: ListNode? = head
        var pNode2: ListNode = head!
        for _ in 0..<k-1 {
            if pNode1?.next != nil {
                pNode1 = pNode1?.next
            } else {
                return nil
            }
        }
        while pNode1?.next != nil {
            pNode1 = pNode1?.next
            pNode2 = pNode2.next!
        }
        return pNode2
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //1->2->3->4->5 倒数第2个节点值是4
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
        XCTAssertEqual(solution.FindKthToTail(node1, k: 2)?.value, 4)
    }
    //1->2->3->4->5 倒数第1个节点值是5
    func testCase2(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        XCTAssertEqual(solution.FindKthToTail(node1, k: 1)?.value, 5)
    }
    //1->2->3->4->5 倒数第5个节点值是1
    func testCase3(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        XCTAssertEqual(solution.FindKthToTail(node1, k: 5)?.value, 1)
    }
    //测试空链表
    func testCase4(){
        XCTAssertNil(solution.FindKthToTail(nil, k: 5))
    }
    //1->2->3->4->5 k大于节点数
    func testCase5(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        XCTAssertNil(solution.FindKthToTail(node1, k: 6))
    }
    //1->2->3->4->5 k=0
    func testCase6(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        XCTAssertNil(solution.FindKthToTail(node1, k: 0))
    }
    
}

UnitTests.defaultTestSuite.run()

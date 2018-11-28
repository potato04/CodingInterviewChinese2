//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题18（一）：在O(1)时间删除链表结点
// 题目：给定单向链表的头指针和一个结点指针，定义一个函数在O(1)时间删除该
// 结点。

import Foundation
import XCTest

//链表节点
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
     o(1)方式删除链表的给定节点
     - Parameters:
        - head：头节点
        - toBeDeleted: 需要删除的节点
     */
    func deleteNode(_ head: inout ListNode?, _ toBeDeleted: ListNode?){
        if head == nil || toBeDeleted == nil {
            return
        }
        //链表只有1个节点,也就是删除head本身
        if head! === toBeDeleted! {
            head = nil
            return
        }
        //需要删除的节点位于尾部，需要从head开始便利到node前面的节点
        if toBeDeleted!.next === nil {
            var node = head!
            while node.next! !== toBeDeleted! {
                node = node.next!
            }
            node.next = nil //删除
        }else {
            //不位于尾部，只需要toBeDeleted之后的节点ANode内容复制到toBeDeleted
            //然后删除ANode即可
            var node = toBeDeleted!.next
            toBeDeleted!.next = node!.next
            toBeDeleted!.value = node!.value
            node = nil
        }
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!

    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    //1->2->3->4->5 删除3
    func testCase1() {
        let node5:ListNode? = ListNode(value: 5, next: nil)
        let node4:ListNode? = ListNode(value: 4, next: node5)
        let node3:ListNode? = ListNode(value: 3, next: node4)
        let node2:ListNode? = ListNode(value: 2, next: node3)
        var node1:ListNode? = ListNode(value: 1, next: node2)
        solution.deleteNode(&node1, node3)
        XCTAssertEqual(node1!.value, 1)
        XCTAssertEqual(node1!.next?.value, 2)
        XCTAssertEqual(node1!.next?.next?.value,4)
        XCTAssertEqual(node1!.next?.next?.next?.value,5)
    }
    //1->2->3->4->5 删除5
    func testCase2() {
        let node5:ListNode? = ListNode(value: 5, next: nil)
        let node4:ListNode? = ListNode(value: 4, next: node5)
        let node3:ListNode? = ListNode(value: 3, next: node4)
        let node2:ListNode? = ListNode(value: 2, next: node3)
        var node1:ListNode? = ListNode(value: 1, next: node2)
        solution.deleteNode(&node1, node5)
        XCTAssertEqual(node1!.value, 1)
        XCTAssertEqual(node1!.next?.value, 2)
        XCTAssertEqual(node1!.next?.next?.value,3)
        XCTAssertEqual(node1!.next?.next?.next?.value,4)
        XCTAssertNil(node1!.next!.next!.next!.next)
    }
    
    //1->2->3->4->5 删除1
    func testCase3() {
        let node5:ListNode? = ListNode(value: 5, next: nil)
        let node4:ListNode? = ListNode(value: 4, next: node5)
        let node3:ListNode? = ListNode(value: 3, next: node4)
        let node2:ListNode? = ListNode(value: 2, next: node3)
        var node1:ListNode? = ListNode(value: 1, next: node2)
        solution.deleteNode(&node1, node1)
        XCTAssertNil(node1)
    }
    
    //只有1个节点1 删除1
    func testCase4() {
        var node1:ListNode? = ListNode(value: 1, next: nil)
        solution.deleteNode(&node1, node1)
        XCTAssertNil(node1)
    }
}

UnitTests.defaultTestSuite.run()

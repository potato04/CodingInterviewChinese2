//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题18（二）：删除链表中重复的结点
// 题目：在一个排序的链表中，如何删除重复的结点？
// 例如: 1->2->3->3->4->4->5 的重复节点删除之后只剩下 1->2->5


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
     移除排序链表中重复的节点
     - Parameters:
        - head：待删除的头节点
     - Returns: 新的头节点
     */
    func deleteDuplicateNode(_ head: ListNode) -> ListNode? {
        var pNode: ListNode? = head
        var pPreNode: ListNode? = nil
        var newHead: ListNode? = head
        while pNode != nil {
            var pNext = pNode!.next
            var needDeletd = false
            if pNext != nil && pNode?.value == pNext?.value {
                needDeletd = true
            }
            if !needDeletd {
                //prepare for next loop
                pPreNode = pNode
                pNode = pNode?.next
            } else {
                //start to delete
                let value = pNode!.value
                var toBeDel: ListNode? = pNode
                while toBeDel != nil && toBeDel!.value == value {
                    pNext = toBeDel?.next
                    toBeDel = pNext
                }
                if pPreNode == nil {
                    newHead = pNext
                } else {
                    pPreNode?.next = pNext
                }
                pNode = pNext
            }
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
    
    //1->2->3->3->4->4->5 删除后 1->2-5
    func testCase1() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 4, next: nil)
        let node6:ListNode = ListNode(value: 4, next: nil)
        let node7:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertEqual(newHead?.value, node1.value)
        XCTAssertEqual(node1.next?.value, node2.value)
        XCTAssertEqual(node2.next?.value, node7.value)
        XCTAssertNil(node7.next)
    }
    //1->2->3->4->5->6->7 没有重复节点
    func testCase2() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        let node6:ListNode = ListNode(value: 6, next: nil)
        let node7:ListNode = ListNode(value: 7, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertEqual(newHead?.value, node1.value)
        XCTAssertEqual(node1.next?.value, node2.value)
        XCTAssertEqual(node2.next?.value, node3.value)
        XCTAssertEqual(node3.next?.value , node4.value)
        XCTAssertEqual(node4.next?.value, node5.value)
        XCTAssertEqual(node5.next?.value, node6.value)
        XCTAssertEqual(node6.next?.value, node7.value)
    }
    //除了一个结点之外其他所有结点的值都相同
    func testCase3() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 1, next: nil)
        let node4:ListNode = ListNode(value: 1, next: nil)
        let node5:ListNode = ListNode(value: 1, next: nil)
        let node6:ListNode = ListNode(value: 1, next: nil)
        let node7:ListNode = ListNode(value: 2, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertEqual(newHead?.value, 2)
        XCTAssertNil(newHead?.next)
    }
    // 所有结点的值都相同
    func testCase4() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 1, next: nil)
        let node4:ListNode = ListNode(value: 1, next: nil)
        let node5:ListNode = ListNode(value: 1, next: nil)
        let node6:ListNode = ListNode(value: 1, next: nil)
        let node7:ListNode = ListNode(value: 1, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertNil(newHead)
    }
    //所有节点都成对出现
    func testCase5() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 2, next: nil)
        let node4:ListNode = ListNode(value: 2, next: nil)
        let node5:ListNode = ListNode(value: 3, next: nil)
        let node6:ListNode = ListNode(value: 3, next: nil)
        let node7:ListNode = ListNode(value: 4, next: nil)
        let node8:ListNode = ListNode(value: 4, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        node7.next = node8
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertNil(newHead)
    }
    // 除了两个结点之外其他结点都成对出现
    func testCase6() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 1, next: nil)
        let node3:ListNode = ListNode(value: 2, next: nil)
        let node4:ListNode = ListNode(value: 3, next: nil)
        let node5:ListNode = ListNode(value: 3, next: nil)
        let node6:ListNode = ListNode(value: 4, next: nil)
        let node7:ListNode = ListNode(value: 5, next: nil)
        let node8:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        node7.next = node8
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertEqual(newHead!.value, 2)
        XCTAssertEqual(newHead?.next?.value, 4)
        XCTAssertNil(newHead?.next?.next)
    }
    // 链表中只有两个不重复的结点
    func testCase7() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        node1.next = node2
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertEqual(newHead!.value, 1)
        XCTAssertEqual(newHead?.next?.value, 2)
        XCTAssertNil(newHead?.next?.next)
    }
    // 结点中只有一个结点
    func testCase8() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertEqual(newHead!.value, 1)
        XCTAssertNil(newHead?.next)
    }
    // 结点中只有两个重复的结点
    func testCase9() {
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 1, next: nil)
        node1.next = node2
        let newHead = solution.deleteDuplicateNode(node1)
        XCTAssertNil(newHead)
    }
}

UnitTests.defaultTestSuite.run()

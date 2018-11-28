//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题23：链表中环的入口结点
// 题目：一个链表中包含环，如何找出环的入口结点？例如，在如图的链表中，
// 环的入口结点是结点3。
//        ↙----¬
// 1->2->3->4->5

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
     如果链表中存在环，则返回环的入口节点
     - Parameters:
        - head: 链表的头节点
     - Returns: 返回环的入口节点
     */
    func EntryNodeOfLoop(_ head: ListNode?) -> ListNode? {
        let meetingNode = MeetingNode(head)
        if meetingNode == nil {
            return nil
        }
        //计算环中的节点数量
        var nodesInLoop = 1
        var temp = meetingNode
        while temp?.next !== meetingNode {
            temp = temp?.next
            nodesInLoop += 1
        }
        //先让快指针移动 nodesInLoop 步
        var node1 = head
        for _ in 1...nodesInLoop {
            node1 = node1?.next
        }
        var node2 = head
        while node1 !== node2 {
            node1 = node1?.next
            node2 = node2?.next
        }
        return node1
    }
    /**
     查找快慢指针相遇的节点：
     定义两个指针：一个慢指针（一次走一步）一个快指针（一次走两步）
     如果快指针追上了慢指针，则链表包含环
     - Parameters:
        - head: 链表的头节点
     - Returns: 返回环中的某个节点，如果为空，则说明不存在环
     */
    func MeetingNode(_ head: ListNode?) -> ListNode? {
        if head == nil {
            return nil
        }
        var slowNode = head?.next
        if slowNode == nil {
            return nil
        }
        var fastNode = slowNode?.next
        while fastNode != nil && slowNode != nil {
            if fastNode! === slowNode! {
                return fastNode
            }
            slowNode = slowNode?.next
            fastNode = fastNode?.next
            if fastNode?.next != nil {
                fastNode = fastNode?.next
            }
        }
        return nil
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //只有一个节点，没有环
    func testCase1(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        XCTAssertNil(solution.EntryNodeOfLoop(node1))
    }
    //只有一个节点，存在环
    func testCase2(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        node1.next = node1
        XCTAssertEqual(solution.EntryNodeOfLoop(node1)?.value, 1)
    }
    
    //多个节点，存在环，入口节点在3
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
        node5.next = node3
        XCTAssertEqual(solution.EntryNodeOfLoop(node1)?.value, 3)
    }
    
    //多个节点，存在环，入口节点在1
    func testCase4(){
        let node1:ListNode = ListNode(value: 1, next: nil)
        let node2:ListNode = ListNode(value: 2, next: nil)
        let node3:ListNode = ListNode(value: 3, next: nil)
        let node4:ListNode = ListNode(value: 4, next: nil)
        let node5:ListNode = ListNode(value: 5, next: nil)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node1
        XCTAssertEqual(solution.EntryNodeOfLoop(node1)?.value, 1)
    }
    
    //多个节点，存在环，入口节点在5
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
        node5.next = node5
        XCTAssertEqual(solution.EntryNodeOfLoop(node1)?.value, 5)
    }
    
    //多个节点，不存在环
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
        XCTAssertNil(solution.EntryNodeOfLoop(node1))
    }
    
}

UnitTests.defaultTestSuite.run()

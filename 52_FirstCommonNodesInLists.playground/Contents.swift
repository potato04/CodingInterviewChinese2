//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题52：两个链表的第一个公共结点
// 题目：输入两个链表，找出它们的第一个公共结点。

import Foundation
import XCTest

class Solution {
    /**
     - parameters:
        - node1: 链表1
        - node2: 链表2
     - Returns: 第一个公共节点
     解法：
     */
    func FindFirstCommonNode(_ node1: ListNode?, _ node2: ListNode?) -> ListNode? {
        let node1Length = GetListLength(node1)
        let node2Length = GetListLength(node2)
        var headLong:ListNode? = node1Length > node2Length ? node1 : node2
        var headShort:ListNode? = node1Length > node2Length ? node2 : node1
        var diff = abs(node1Length - node2Length)
        while diff > 0 {
            headLong = headLong!.next
            diff -= 1
        }
        while headLong != nil && headShort != nil && headLong != headShort {
            headLong = headLong?.next
            headShort = headShort?.next
        }
        return headLong
    }
    private func GetListLength(_ node: ListNode?) -> Int {
        var count = 0
        var head = node
        while head != nil {
            count += 1
            head = head!.next
        }
        return count
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 第一个公共结点在链表中间
    // 1 - 2 - 3 \
    //            6 - 7
    //     4 - 5 /
    func testCase1() {
        let node7 = ListNode(value: 7, next: nil)
        let node6 = ListNode(value: 6, next: node7)
        let node5 = ListNode(value: 5, next: node6)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node6)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        XCTAssertEqual(6, solution.FindFirstCommonNode(node1, node4)?.value)
    }
    
    // 没有公共节点
    // 1 - 2 - 3 - 4
    //
    // 5 - 6 - 7
    func testCase2() {
        let node7 = ListNode(value: 7, next: nil)
        let node6 = ListNode(value: 6, next: node7)
        let node5 = ListNode(value: 5, next: node6)
        let node4 = ListNode(value: 4, next: nil)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        XCTAssertEqual(nil, solution.FindFirstCommonNode(node1, node5)?.value)
    }
    
    // 公共结点是最后一个结点
    // 1 - 2 - 3 - 4 \
    //                7
    //         5 - 6 /
    func testCase3() {
        let node7 = ListNode(value: 7, next: nil)
        let node6 = ListNode(value: 6, next: node7)
        let node5 = ListNode(value: 5, next: node6)
        let node4 = ListNode(value: 4, next: node7)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        XCTAssertEqual(7, solution.FindFirstCommonNode(node1, node5)?.value)
    }
    // 公共结点是第一个结点
    // 1 - 2 - 3 - 4 - 5
    // 两个链表完全重合
    func testCase4() {
        let node5 = ListNode(value: 5, next: nil)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        XCTAssertEqual(1, solution.FindFirstCommonNode(node1, node1)?.value)
    }
    
    // 输入的两个链表有一个空链表
    func testCase5() {
        let node5 = ListNode(value: 5, next: nil)
        let node4 = ListNode(value: 4, next: node5)
        let node3 = ListNode(value: 3, next: node4)
        let node2 = ListNode(value: 2, next: node3)
        let node1 = ListNode(value: 1, next: node2)
        XCTAssertEqual(nil, solution.FindFirstCommonNode(node1, nil)?.value)
    }
}
UnitTests.defaultTestSuite.run()







//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题36：二叉搜索树与双向链表
// 题目：输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表。要求
// 不能创建任何新的结点，只能调整树中结点指针的指向。

import Foundation
import XCTest

class BinaryTreeNode: Equatable {
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: Int
    
    init(value: Int, left: BinaryTreeNode?, right: BinaryTreeNode?) {
        self.value = value
        self.left = left
        self.right = right
    }
    static func ==(left: BinaryTreeNode, right: BinaryTreeNode) -> Bool {
        return left.value == right.value
    }
}

class Solution {
    /**
     输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表。
     - parameters:
     - root: 二叉搜索根节点
     - Returns: 双向排序链表头节点
     */
    func Convert(_ root: BinaryTreeNode) -> BinaryTreeNode? {
        var lastNodeInList: BinaryTreeNode? = nil
        lastNodeInList = ConvertNode(root, lastNodeInList)
        //lastNodeInList 指向双向链表的尾节点
        //这里需要返回头节点
        var head = lastNodeInList
        while head != nil && head?.left != nil {
            head = head?.left
        }
        return head
    }
    func ConvertNode(_ node: BinaryTreeNode?, _ lastNodeInList: BinaryTreeNode?) -> BinaryTreeNode? {
        guard let node = node else {
            return nil
        }
        let current = node
        var lastNodeInList = lastNodeInList
        if current.left != nil {
            lastNodeInList = ConvertNode(current.left!, lastNodeInList)
        }
        current.left = lastNodeInList
        if lastNodeInList != nil {
            lastNodeInList?.right = current
        }
        lastNodeInList = current
        
        
        if current.right != nil {
           lastNodeInList = ConvertNode(current.right!, lastNodeInList)
        }
        return lastNodeInList
    }
}
class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    private func isLinkedListValuesEqual(_ head: BinaryTreeNode?, values:[Int]) -> Bool {
        if head == nil && values.count > 0 {
            return false
        }
        if head == nil && values.count == 0 {
            return true
        }
        var head = head
        var index = 0
        while head?.right != nil {
            if head?.value != values[index] {
                return false
            }
            head = head?.right
            index += 1
        }
        while head != nil {
            if head?.value != values[index] {
                return false
            }
            head = head?.left
            index -= 1
        }
        return true
    }
    
    
    //            10
    //         /      \
    //        6        14
    //       /\        /\
    //      4  8     12  16
    func testCase1() {
        let node_10 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node_14 = BinaryTreeNode(value: 14, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 8, left: nil, right: nil)
        let node_12 = BinaryTreeNode(value: 12, left: nil, right: nil)
        let node_16 = BinaryTreeNode(value: 16, left: nil, right: nil)
        node_10.left = node_6
        node_10.right = node_14
        node_6.left = node_4
        node_6.right = node_8
        node_14.left = node_12
        node_14.right = node_16
        let head = solution.Convert(node_10)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [4,6,8,10,12,14,16]))
    }
    //               5
    //              /
    //             4
    //            /
    //           3
    //          /
    //         2
    //        /
    //       1
    func testCase2() {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_5.left = node_4
        node_4.left = node_3
        node_3.left = node_2
        node_2.left = node_1
        let head = solution.Convert(node_5)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [1,2,3,4,5]))
    }
    // 1
    //  \
    //   2
    //    \
    //     3
    //      \
    //       4
    //        \
    //         5
    func testCase3() {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        let head = solution.Convert(node_1)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [1,2,3,4,5]))
    }
    //1
    func testCase4() {
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        let head = solution.Convert(node_1)
        XCTAssertTrue(isLinkedListValuesEqual(head, values: [1]))
    }
}


UnitTests.defaultTestSuite.run()







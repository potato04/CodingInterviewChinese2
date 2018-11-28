//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题8：二叉树的下一个结点
// 题目：给定一棵二叉树和其中的一个结点，如何找出中序遍历顺序的下一个结点？
// 树中的结点除了有两个分别指向左右子结点的指针以外，还有一个指向父结点的指针。

import Foundation
import XCTest

class BinaryTreeNode: Equatable {
    var parent: BinaryTreeNode?
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: Int
    
    init(value: Int, parent: BinaryTreeNode?, left: BinaryTreeNode?, right: BinaryTreeNode?) {
        self.value = value
        self.parent = parent
        self.left = left
        self.right = right
    }
    
    static func ==(left: BinaryTreeNode, right: BinaryTreeNode) -> Bool {
        return left.value == right.value
    }
}

class Solution {
    /**
     给定一棵二叉树的某节点，查找中序序列该节点的下一节点
     - Parameters:
        - node: 给定节点
     - Returns: 中序序列的下一个节点
     */
    func GetNext(_ node: BinaryTreeNode) -> BinaryTreeNode?{
        var node = node
        if node.right != nil {
            node = node.right!
            while node.left != nil {
                node = node.left!
            }
            return node
        }
        if node.parent == nil {
            return nil
        }
        if node == node.parent?.left {
            return node.parent
        } else {
            node = node.parent!
            while node.parent != nil {
                if node.parent!.left == node {
                    return node.parent
                }
                node = node.parent!
            }
            return nil
        }
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    //            8
    //        6      10
    //       5 7    9  11
    func testCase1_7() {
        let node_8 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, parent: node_8, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_6, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 7, parent: node_6, left: nil, right: nil)
        node_6.left = node_5
        node_6.right = node_7
        let node_10 = BinaryTreeNode(value: 10, parent: node_8, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 9, parent: node_10, left: nil, right: nil)
        let node_11 = BinaryTreeNode(value: 11, parent: node_10, left: nil, right: nil)
        node_10.left = node_9
        node_10.right = node_11
        node_8.left = node_6
        node_8.right = node_10
        XCTAssertEqual(solution.GetNext(node_8)!, node_9)
        XCTAssertEqual(solution.GetNext(node_6)!, node_7)
        XCTAssertEqual(solution.GetNext(node_10)!, node_11)
        XCTAssertEqual(solution.GetNext(node_5)!, node_6)
        XCTAssertEqual(solution.GetNext(node_7)!, node_8)
        XCTAssertEqual(solution.GetNext(node_9)!, node_10)
        XCTAssertEqual(solution.GetNext(node_11), nil)
    }
    //            5
    //          4
    //        3
    //      2
    func testCase8_11() {
        let node_5 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_5, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_4, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        node_5.left = node_4
        node_4.left = node_3
        node_3.left = node_2
        XCTAssertEqual(solution.GetNext(node_5), nil)
        XCTAssertEqual(solution.GetNext(node_4)!, node_5)
        XCTAssertEqual(solution.GetNext(node_3)!, node_4)
        XCTAssertEqual(solution.GetNext(node_2)!, node_3)
    }
    //        2
    //         3
    //          4
    //           5
    func testCase12_15() {
        let node_2 = BinaryTreeNode(value: 2, parent: nil, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        XCTAssertEqual(solution.GetNext(node_5), nil)
        XCTAssertEqual(solution.GetNext(node_4)!, node_5)
        XCTAssertEqual(solution.GetNext(node_3)!, node_4)
        XCTAssertEqual(solution.GetNext(node_2)!, node_3)
    }

    func testCase16() {
        let node_5 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        XCTAssertEqual(solution.GetNext(node_5), nil)
    }
}

UnitTests.defaultTestSuite.run()

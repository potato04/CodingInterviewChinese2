//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题54：二叉搜索树的第k大个结点
// 题目：给定一棵二叉搜索树，请找出其中的第k大的结点。

import Foundation
import XCTest

//二叉树结构
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
    返回二叉搜索树中第K大的节点
     - Parameters:
        - root: 二叉搜索树根节点
        - k：第K大
     - Returns: 第K大的节点
     解法：利用搜索树的中序遍历（元素从小到大）
     */
    func KthNode(_ node: BinaryTreeNode, k: Int) -> (node: BinaryTreeNode?, newK: Int) {
        guard k > 0 else {
            return (nil, k)
        }
        var target: BinaryTreeNode? = nil
        var k = k
        if node.left != nil {
            (target, k) = KthNode(node.left!, k: k)
        }
        if target == nil {
            if k == 1 {
                target = node
            }
            k -= 1
        }
        if target == nil && node.right != nil {
            (target, k) = KthNode(node.right!, k: k)
        }
        return (target, k)
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
    func testCase1() {
        let node_8 = BinaryTreeNode(value: 8, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node_10 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 9, left: nil, right: nil)
        let node_11 = BinaryTreeNode(value: 11, left: nil, right: nil)
        node_8.left = node_6
        node_8.right = node_10
        node_6.left = node_5
        node_6.right = node_7
        node_10.left = node_9
        node_10.right = node_11

        XCTAssertEqual(nil, solution.KthNode(node_8, k: 0).node)
        XCTAssertEqual(node_5, solution.KthNode(node_8, k: 1).node)
        XCTAssertEqual(node_6, solution.KthNode(node_8, k: 2).node!)
        XCTAssertEqual(node_7, solution.KthNode(node_8, k: 3).node!)
        XCTAssertEqual(node_8, solution.KthNode(node_8, k: 4).node!)
        XCTAssertEqual(node_9, solution.KthNode(node_8, k: 5).node!)
        XCTAssertEqual(node_10, solution.KthNode(node_8, k: 6).node!)
        XCTAssertEqual(node_11, solution.KthNode(node_8, k: 7).node!)
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
        
        XCTAssertEqual(nil, solution.KthNode(node_5, k: 0).node)
        XCTAssertEqual(node_1, solution.KthNode(node_5, k: 1).node)
        XCTAssertEqual(node_2, solution.KthNode(node_5, k: 2).node)
        XCTAssertEqual(node_3, solution.KthNode(node_5, k: 3).node)
        XCTAssertEqual(node_4, solution.KthNode(node_5, k: 4).node)
        XCTAssertEqual(node_5, solution.KthNode(node_5, k: 5).node)
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
        
        XCTAssertEqual(nil, solution.KthNode(node_1, k: 0).node)
        XCTAssertEqual(node_1, solution.KthNode(node_1, k: 1).node)
        XCTAssertEqual(node_2, solution.KthNode(node_1, k: 2).node)
        XCTAssertEqual(node_3, solution.KthNode(node_1, k: 3).node)
        XCTAssertEqual(node_4, solution.KthNode(node_1, k: 4).node)
        XCTAssertEqual(node_5, solution.KthNode(node_1, k: 5).node)
    }
    func testCase4() {
        let node_1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        XCTAssertEqual(nil, solution.KthNode(node_1, k: 0).node)
        XCTAssertEqual(node_1, solution.KthNode(node_1, k: 1).node)
        XCTAssertEqual(nil, solution.KthNode(node_1, k: 2).node)
    }
}

UnitTests.defaultTestSuite.run()

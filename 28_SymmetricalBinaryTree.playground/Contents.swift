//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题28：对称的二叉树
// 题目：请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和
// 它的镜像一样，那么它是对称的。

import Foundation
import XCTest

//二叉树结构
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
     判断二叉树是否对称
     - Parameters:
        - root: 树
     - Returns: 是否对称
     */
    func isSymmetrical(_ root: BinaryTreeNode?) -> Bool{
        return isSymmetrical(root, root)
    }
    /**
     递归判断两个节点及其左右子节点是否相同（都为空也等于相同）
     - Parameters:
        - node1: 节点1
        - node2: 节点2
     - Returns: 是否对称
     */
    private func isSymmetrical(_ node1: BinaryTreeNode?, _ node2: BinaryTreeNode?) -> Bool {
        if node1 == nil && node2 == nil {
            return true
        }
        if node1 == nil || node2 == nil {
            return false
        }
        if node1?.value != node2?.value {
            return false
        }
        
        return isSymmetrical(node1?.left, node2?.right) &&
                isSymmetrical(node1?.right, node2?.left)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //       8
    //     /   \
    //    6     6
    //   / \   / \
    //  5   7  7  5
    func testCase1(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 7, parent: node_3, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 5, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        node_3.right = node_7
        XCTAssertTrue(solution.isSymmetrical(node_1))
    }
    //       8
    //     /   \
    //    6     9
    //   / \   / \
    //  5   7  7  5
    func testCase2(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 9, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 7, parent: node_3, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 5, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        node_3.right = node_7
        XCTAssertFalse(solution.isSymmetrical(node_1))
    }
    //            8
    //        6      6
    //       5 7    7
    func testCase3(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 7, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        XCTAssertFalse(solution.isSymmetrical(node_1))
    }
    //               5
    //              / \
    //             3   3
    //            /     \
    //           4       4
    //          /         \
    //         2           2
    //        /             \
    //       1               1
    func testCase4(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 3, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 4, parent: node_3, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 2, parent: node_4, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 2, parent: node_5, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 1, parent: node_6, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 1, parent: node_7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_3.right = node_5
        node_4.left = node_6
        node_5.right = node_7
        node_6.left = node_8
        node_7.right = node_9
        XCTAssertTrue(solution.isSymmetrical(node_1))
    }
    //               5
    //              / \
    //             3   3
    //            /     \
    //           4       4
    //          /         \
    //         6           2
    //        /             \
    //       1               1
    func testCase5(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 3, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 4, parent: node_3, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, parent: node_4, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 2, parent: node_5, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 1, parent: node_6, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 1, parent: node_7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_3.right = node_5
        node_4.left = node_6
        node_5.right = node_7
        node_6.left = node_8
        node_7.right = node_9
        XCTAssertFalse(solution.isSymmetrical(node_1))
    }
    //               5
    //              / \
    //             3   3
    //            /     \
    //           4       4
    //          /         \
    //         2           2
    //                      \
    //                       1
    func testCase6(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 3, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 4, parent: node_3, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 2, parent: node_4, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 2, parent: node_5, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 1, parent: node_7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_3.right = node_5
        node_4.left = node_6
        node_5.right = node_7
        node_7.right = node_9
        XCTAssertFalse(solution.isSymmetrical(node_1))
    }
    // 只有一个结点
    func testCase7(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        XCTAssertTrue(solution.isSymmetrical(node_1))
    }
    //没有节点
    func testCase8(){
        XCTAssertTrue(solution.isSymmetrical(nil))
    }
    
}

UnitTests.defaultTestSuite.run()

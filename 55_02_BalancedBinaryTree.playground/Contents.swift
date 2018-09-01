//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题55（二）：平衡二叉树
// 题目：输入一棵二叉树的根结点，判断该树是不是平衡二叉树。如果某二叉树中
// 任意结点的左右子树的深度相差不超过1，那么它就是一棵平衡二叉树。

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
    判断是否是平衡二叉树
     - parameters:
        - root: 二叉树根节点
     - Returns: 判断结果
     解法：判断各个节点的左右子树的深度相差是否超过1
     */
    func IsBalanced_Solution1(_ root: BinaryTreeNode?) -> Bool {
        guard root != nil else {
            return true
        }
        let leftDepth = TreeDepth(root?.left)
        let rightDepth = TreeDepth(root?.right)
        let diff = abs(leftDepth - rightDepth)
        if diff > 1 { return false }
        return IsBalanced_Solution1(root?.left) && IsBalanced_Solution1(root?.right)
    }
    
    private func TreeDepth(_ node: BinaryTreeNode?) -> Int {
        guard node != nil else {
            return 0
        }
        let leftTreeDepth = TreeDepth(node?.left)
        let rightTreeDepth = TreeDepth(node?.right)
        return leftTreeDepth > rightTreeDepth ? leftTreeDepth + 1 : rightTreeDepth + 1
    }
    
    /**
     判断是否是平衡二叉树
     - parameters:
     - root: 二叉树根节点
     - Returns: 判断结果
     解法：利用后序遍历，重复利用之前的节点深度，避免重复遍历
     */
    func IsBalanced_Solution2(_ root: BinaryTreeNode?) -> Bool {
       return IsBalanced(root).balanced
    }
    private func IsBalanced(_ node: BinaryTreeNode?) -> (balanced: Bool, depth: Int) {
        guard node != nil else {
            return (true, 0)
        }
        let leftResult = IsBalanced(node!.left)
        let rightResult = IsBalanced(node!.right)
        let maxDepth = max(leftResult.depth, rightResult.depth)
        if leftResult.balanced && rightResult.balanced {
            let diff = abs(leftResult.depth - rightResult.depth)
            if diff <= 1 {
                return (true, 1 + maxDepth)
            }
        }
        return (false, 1 + maxDepth)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 完全二叉树
    //             1
    //         /      \
    //        2        3
    //       /\       / \
    //      4  5     6   7
    func testCase1() {
        let node7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: node6, right: node7)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(true, solution.IsBalanced_Solution1(node1))
        XCTAssertEqual(true, solution.IsBalanced_Solution2(node1))
    }
    // 不是完全二叉树，但是平衡二叉树
    //             1
    //         /      \
    //        2        3
    //       /\         \
    //      4  5         6
    //        /
    //       7
    func testCase2() {
        let node7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: node7, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: node6)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(true, solution.IsBalanced_Solution1(node1))
        XCTAssertEqual(true, solution.IsBalanced_Solution2(node1))
    }
    // 不是平衡二叉树
    //             1
    //         /      \
    //        2        3
    //       /\
    //      4  5
    //        /
    //       6
    func testCase3() {
        let node6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node5 = BinaryTreeNode(value: 5, left: node6, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node2 = BinaryTreeNode(value: 2, left: node4, right: node5)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: node3)
        
        XCTAssertEqual(false, solution.IsBalanced_Solution1(node1))
        XCTAssertEqual(false, solution.IsBalanced_Solution2(node1))
    }
    //               1
    //              /
    //             2
    //            /
    //           3
    //          /
    //         4
    //        /
    //       5
    func testCase4() {
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: node5, right: nil)
        let node3 = BinaryTreeNode(value: 3, left: node4, right: nil)
        let node2 = BinaryTreeNode(value: 2, left: node3, right: nil)
        let node1 = BinaryTreeNode(value: 1, left: node2, right: nil)
        XCTAssertEqual(false, solution.IsBalanced_Solution1(node1))
        XCTAssertEqual(false, solution.IsBalanced_Solution2(node1))
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
    func testCase5() {
        let node5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node4 = BinaryTreeNode(value: 4, left: nil, right: node5)
        let node3 = BinaryTreeNode(value: 3, left: nil, right: node4)
        let node2 = BinaryTreeNode(value: 2, left: nil, right: node3)
        let node1 = BinaryTreeNode(value: 1, left: nil, right: node2)
        XCTAssertEqual(false, solution.IsBalanced_Solution1(node1))
        XCTAssertEqual(false, solution.IsBalanced_Solution2(node1))
    }
    //只有1个节点
    func testCase6() {
        let node1 = BinaryTreeNode(value: 1, left: nil, right: nil)
        XCTAssertEqual(true, solution.IsBalanced_Solution1(node1))
        XCTAssertEqual(true, solution.IsBalanced_Solution2(node1))
    }
    //没有节点
    func testCase7() {
        XCTAssertEqual(true, solution.IsBalanced_Solution1(nil))
        XCTAssertEqual(true, solution.IsBalanced_Solution2(nil))
    }
}
UnitTests.defaultTestSuite.run()







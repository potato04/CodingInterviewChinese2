//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题26：树的子结构
// 题目：输入两棵二叉树A和B，判断B是不是A的子结构。

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
     
     - parameters:
        - root1: 树1
        - root2: 树2
     - Returns: 树2是否是树1的子树
     */
    func HasSubtree(_ root1: BinaryTreeNode?, _ root2: BinaryTreeNode?) -> Bool {
        var result = false
        if root1 != nil && root2 != nil {
            if root1 == root2 {
                result = DoseTree1HavaeTree2(root1, root2)
            }
            if !result {
                result = HasSubtree(root1?.left, root2)
            }
            if !result {
                result = HasSubtree(root1?.right, root2)
            }
        }
        return result
    }
    func DoseTree1HavaeTree2(_ root1: BinaryTreeNode?, _ root2: BinaryTreeNode?) -> Bool {
        if root2 == nil {
            return true
        }
        if root1 == nil {
            return false
        }
        if root1! != root2! {
            return false
        }
        return DoseTree1HavaeTree2(root1?.left, root2?.left) &&
            DoseTree1HavaeTree2(root1?.right, root2?.right)
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 树中结点含有分叉，树B是树A的子结构
    //                8          8
    //              /   \       / \
    //             8     7     9   2
    //           /   \
    //          9     2
    //               / \
    //              4   7
    func testCase1(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 8, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 7, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 9, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 2, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 4, parent: node_5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 7, parent: node_5, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_5.left = node_6
        node_5.right = node_7
        
        let node_8 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 9, parent: node_8, left: nil, right: nil)
        let node_10 = BinaryTreeNode(value: 2, parent: node_8, left: nil, right: nil)
        node_8.left = node_9
        node_8.right = node_10
        
        XCTAssertTrue(solution.HasSubtree(node_1, node_8))
    }
    // 树中结点含有分叉，树B不是树A的子结构
    //        8              8
    //      /   \           / \
    //     8     7         9   2
    //   /   \
    //  9     3
    //       / \
    //      4   7
    func testCase2(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 8, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 7, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 9, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 4, parent: node_5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 7, parent: node_5, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_5.left = node_6
        node_5.right = node_7
        
        let node_8 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 9, parent: node_8, left: nil, right: nil)
        let node_10 = BinaryTreeNode(value: 2, parent: node_8, left: nil, right: nil)
        node_8.left = node_9
        node_8.right = node_10
        
        XCTAssertFalse(solution.HasSubtree(node_1, node_8))
    }
    // 树中结点只有左子结点，树B是树A的子结构
    //              8           8
    //             /           /
    //            8           9
    //           /           /
    //          9           2
    //         /
    //        2
    //       /
    //      5
    func testCase3(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 8, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 9, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)

        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 9, parent: node_6, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 2, parent: node_7, left: nil, right: nil)
        node_6.left = node_7
        node_7.left = node_8
        
        XCTAssertTrue(solution.HasSubtree(node_1, node_6))
    }
    // 树中结点只有左子结点，树B不是树A的子结构
    //              8           8
    //             /           /
    //            8           9
    //           /           /
    //          9           3
    //         /
    //        2
    //       /
    //      5
    func testCase4(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 8, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 9, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)
        
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 9, parent: node_6, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 3, parent: node_7, left: nil, right: nil)
        node_6.left = node_7
        node_7.left = node_8
        
        XCTAssertFalse(solution.HasSubtree(node_1, node_6))
    }
    // 树中结点只有右子结点，树B是树A的子结构
    //       8                   8
    //        \                   \
    //         8                   9
    //          \                   \
    //           9                   2
    //            \
    //             2
    //              \
    //               5
    func testCase5(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 8, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 9, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)
        
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 9, parent: node_6, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 2, parent: node_7, left: nil, right: nil)
        node_6.right = node_7
        node_7.right = node_8
        
        XCTAssertTrue(solution.HasSubtree(node_1, node_6))
    }
    // 树A中结点只有右子结点，树B不是树A的子结构
    //       8                   8
    //        \                   \
    //         8                   9
    //          \                 / \
    //           9               3   2
    //            \
    //             2
    //              \
    //               5
    func testCase6(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 8, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 9, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)
        
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        
        let node_6 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 9, parent: node_6, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 9, parent: node_7, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 2, parent: node_7, left: nil, right: nil)
        node_6.right = node_7
        node_7.left = node_8
        node_7.right = node_9
        
        XCTAssertFalse(solution.HasSubtree(node_1, node_6))
    }
    //树A为空
    func testCase7(){
        let node_6 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 9, parent: node_6, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 3, parent: node_7, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 2, parent: node_8, left: nil, right: nil)
        node_6.right = node_7
        node_7.right = node_8
        node_8.right = node_9
        
        XCTAssertFalse(solution.HasSubtree(nil, node_6))
    }
    //树B为空
    func testCase8(){
        let node_6 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 9, parent: node_6, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 3, parent: node_7, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 2, parent: node_8, left: nil, right: nil)
        node_6.right = node_7
        node_7.right = node_8
        node_8.right = node_9
        
        XCTAssertFalse(solution.HasSubtree(node_6, nil))
    }
    //树A和B都为空
    func testCase9(){
        XCTAssertFalse(solution.HasSubtree(nil, nil))
    }
}

UnitTests.defaultTestSuite.run()







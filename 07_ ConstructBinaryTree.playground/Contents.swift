//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题7：重建二叉树
// 题目：输入某二叉树的前序遍历和中序遍历的结果，请重建出该二叉树。假设输
// 入的前序遍历和中序遍历的结果中都不含重复的数字。例如输入前序遍历序列{1,
// 2, 4, 7, 3, 5, 6, 8}和中序遍历序列{4, 7, 2, 1, 5, 3, 8, 6}，则重建出
// 图2.6所示的二叉树并输出它的头结点。

import Foundation
import XCTest

class BinaryTreeNode {
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: Int
    
    init(value: Int, left: BinaryTreeNode?, right: BinaryTreeNode?) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    func preOrder() -> [Int] {
        var result = [Int]()
        preOrderCore(self, result: &result)
        return result
    }
    private func preOrderCore(_ node: BinaryTreeNode?, result: inout [Int]) {
        guard let node = node else {
            return
        }
        result.append(node.value)
        preOrderCore(node.left, result: &result)
        preOrderCore(node.right, result: &result)
    }
    func inOrder() -> [Int] {
        var result = [Int]()
        inOrderCore(self, result: &result)
        return result
    }
    private func inOrderCore(_ node: BinaryTreeNode?, result: inout [Int]) {
        guard let node = node else {
            return
        }
        inOrderCore(node.left, result: &result)
        result.append(node.value)
        inOrderCore(node.right, result: &result)
    }
    
    
}

class Solution {
    /**
     根据前序序列和中序序列构建二叉树
     - parameters:
        - preorder: 前序序列数组
        - inorder: 中序序列数组
     - Returns: BinaryTreeNode 构建好的二叉树根节点
     */
    func Construct(_ preorder: [Int], _ inorder: [Int]) -> BinaryTreeNode?{
        if preorder.count == 0 || inorder.count == 0 || preorder.count != inorder.count {
            return nil
        }
        return ConstructCore(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1)
    }
    func ConstructCore(_ preorder: [Int], _ preStartIndex: Int, _ preEndIndex: Int,
                       _ inorder: [Int], _ inStartIndex: Int, _ inEndIndex: Int) -> BinaryTreeNode? {
        let root = BinaryTreeNode(value: preorder[preStartIndex], left: nil, right: nil)
        var rootIndexInOrder = -1
        for index in inStartIndex...inEndIndex {
            if inorder[index] == preorder[preStartIndex] {
                rootIndexInOrder = index
                break
            }
        }
        if rootIndexInOrder == -1 {
            return nil
        }
        
        let leftTreeElementCount = rootIndexInOrder - inStartIndex
        if preStartIndex + 1 <= preStartIndex + leftTreeElementCount {
            root.left = ConstructCore(preorder, preStartIndex + 1, preStartIndex + leftTreeElementCount,
                                      inorder, inStartIndex, rootIndexInOrder - 1)
        }
        if preStartIndex + leftTreeElementCount + 1 <= preEndIndex {
            root.right = ConstructCore(preorder, preStartIndex + leftTreeElementCount + 1, preEndIndex,
                                       inorder, rootIndexInOrder + 1, inEndIndex)
        }
        return root
    }
}


class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 普通二叉树
    //              1
    //           /     \
    //          2       3
    //         /       / \
    //        4       5   6
    //         \         /
    //          7       8
    func testCase1() {
        let preorder = [1, 2, 4, 7, 3, 5, 6, 8]
        let inorder = [4, 7, 2, 1, 5, 3, 8, 6]
        let result = solution.Construct(preorder, inorder)
        XCTAssertTrue(result?.preOrder() == preorder)
        XCTAssertTrue(result?.inOrder() == inorder)
    }
    // 所有结点都没有右子结点
    //            1
    //           /
    //          2
    //         /
    //        3
    //       /
    //      4
    //     /
    //    5
    func testCase2() {
        let preorder = [1, 2, 3, 4, 5]
        let inorder = [5, 4, 3, 2, 1]
        let result = solution.Construct(preorder, inorder)
        XCTAssertTrue(result?.preOrder() == preorder)
        XCTAssertTrue(result?.inOrder() == inorder)
    }
    // 所有结点都没有左子结点
    //            1
    //             \
    //              2
    //               \
    //                3
    //                 \
    //                  4
    //                   \
    //                    5
    func testCase3() {
        let preorder = [1, 2, 3, 4, 5]
        let inorder = [1, 2, 3, 4, 5]
        let result = solution.Construct(preorder, inorder)
        XCTAssertTrue(result?.preOrder() == preorder)
        XCTAssertTrue(result?.inOrder() == inorder)
    }
    
    // 树中只有一个结点
    func testCase4() {
        let preorder = [1]
        let inorder = [1]
        let result = solution.Construct(preorder, inorder)
        XCTAssertTrue(result?.preOrder() == preorder)
        XCTAssertTrue(result?.inOrder() == inorder)
    }
    
    // 完全二叉树
    //              1
    //           /     \
    //          2       3
    //         / \     / \
    //        4   5   6   7
    func testCase5() {
        let preorder = [1, 2, 4, 5, 3, 6, 7]
        let inorder = [4, 2, 5, 1, 6, 3, 7]
        let result = solution.Construct(preorder, inorder)
        XCTAssertTrue(result?.preOrder() == preorder)
        XCTAssertTrue(result?.inOrder() == inorder)
    }
    
    // 输入的两个序列不匹配
    func testCase6() {
        let preorder = [1, 2, 4, 5, 3, 6, 7]
        let inorder = [4, 2, 8, 1, 6, 3, 7]
        let result = solution.Construct(preorder, inorder)
        XCTAssertFalse(result?.preOrder() == preorder)
        XCTAssertFalse(result?.inOrder() == inorder)
    }
    
}

UnitTests.defaultTestSuite.run()






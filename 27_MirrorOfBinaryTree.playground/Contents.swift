//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题27：二叉树的镜像
// 题目：请完成一个函数，输入一个二叉树，该函数输出它的镜像。

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
     实现二叉树的镜像（递归左右翻转）
     - parameters:
        - root: 树的根节点
     - Returns: 树2是否是树1的子树
     */
    func MirrorRecursively(_ node: BinaryTreeNode?){
        guard let node = node else {
            return
        }
        guard node.left != nil || node.right != nil else {
            return
        }
        
        //exchange left node and right node
        let temp = node.left
        node.left = node.right
        node.right = temp
        
        if node.left != nil {
            MirrorRecursively(node.left)
        }
        if node.right != nil {
            MirrorRecursively(node.right)
        }
    }
    
    /**
     实现二叉树的镜像（循环）
     - parameters:
     - root: 树的根节点
     - Returns: 树2是否是树1的子树
     */
    func MirrorIteratively(_ node: BinaryTreeNode?){
        guard let node = node else {
            return
        }
        var nodes = Array<BinaryTreeNode>()
        nodes.append(node)
        while nodes.count > 0 {
            let lastNode = nodes.removeLast()
            let temp = lastNode.left
            lastNode.left = lastNode.right
            lastNode.right = temp
            
            if lastNode.left != nil {
                nodes.append(lastNode.left!)
            }
            if lastNode.right != nil {
                nodes.append(lastNode.right!)
            }
        }
    }
}

class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    // 完全二叉树：除了叶子节点，其他节点都有2个子节点
    //       8
    //     /   \
    //    6     10
    //   / \   / \
    //  5   7  9  11
    func testCase1(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 10, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 9, parent: node_3, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 11, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        node_3.right = node_7
        
        solution.MirrorRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.left, node_3)
        XCTAssertEqual(node_1.right, node_2)
        XCTAssertEqual(node_3.left, node_7)
        XCTAssertEqual(node_3.right, node_6)
        XCTAssertEqual(node_2.left, node_5)
        XCTAssertEqual(node_2.right, node_4)
    }
    // 测试二叉树：出叶子结点之外，左右的结点都有且只有一个左子结点
    //            8
    //          7
    //        6
    //      5
    //    4
    func testCase2(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 7, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 6, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 4, parent: node_4, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5
        
        solution.MirrorRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.right, node_2)
        XCTAssertEqual(node_2.right, node_3)
        XCTAssertEqual(node_3.right, node_4)
        XCTAssertEqual(node_4.right, node_5)
    }
    // 测试二叉树：出叶子结点之外，左右的结点都有且只有一个右子结点
    //            8
    //             7
    //              6
    //               5
    //                4
    func testCase3(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 7, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 6, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 4, parent: node_4, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        
        solution.MirrorRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
        XCTAssertEqual(node_1.left, node_2)
        XCTAssertEqual(node_2.left, node_3)
        XCTAssertEqual(node_3.left, node_4)
        XCTAssertEqual(node_4.left, node_5)
    }
    // 测试空二叉树：根结点为空指针
    func testCase4(){
        let node_1: BinaryTreeNode? = nil
        solution.MirrorRecursively(node_1)
        XCTAssertNil(node_1)
    }
    // 测试只有一个结点的二叉树
    func testCase5(){
        let node_1 = BinaryTreeNode(value: 8, parent: nil, left: nil, right: nil)
        solution.MirrorRecursively(node_1)
        XCTAssertEqual(node_1.value, 8)
    }
    
}

UnitTests.defaultTestSuite.run()







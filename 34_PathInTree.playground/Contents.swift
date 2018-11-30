//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题34：二叉树中和为某一值的路径
// 题目：输入一棵二叉树和一个整数，打印出二叉树中结点值的和为输入整数的所
// 有路径。从树的根结点开始往下一直到叶结点所经过的结点形成一条路径。

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
     查找二叉树中和为某一值的路径
     - Parameters:
        - root: 树根节点
        - expectedSum: 期待的h和
     - Returns: 路径上所有节点值的和为期待和的所有路径
     */
    func FindPath(_ root: BinaryTreeNode, expectedSum: Int) -> [[BinaryTreeNode]] {
        let allPath = FindAllPath(root)
        
        return allPath.filter {
            $0.reduce(0, { sum, node in return sum + node.value}) == expectedSum
        }
    }
    
    /**
     根据二叉树根节点返回所有根节点到叶子节点的路径
     - Parameters:
        - root: 树根节点
     - Returns: 所有根节点到叶子节点的路径
     */
    private func FindAllPath(_ root: BinaryTreeNode) -> [[BinaryTreeNode]] {
        var results = [[BinaryTreeNode]]()
        var stack = [[BinaryTreeNode]]()
        stack.append([root])
        while !stack.isEmpty {
            let nodes = stack.removeLast()
            if nodes.last!.left == nil && nodes.last!.right == nil {
                results.append(nodes)
            }else {
                let current = nodes.last!
                if current.left != nil {
                    var path = nodes
                    path.append(current.left!)
                    stack.append(path)
                }
                if current.right != nil {
                    var path = nodes
                    path.append(current.right!)
                    stack.append(path)
                }
            }
        }
        return results
    }
}
class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    //            10
    //         /      \
    //        5        12
    //       /\
    //      4  7
    // 有两条路径上的结点和为22
    func testCase1(){
        let node_1 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 5,  left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 12, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        let paths = solution.FindPath(node_1, expectedSum: 22)
        XCTAssertEqual(paths.count, 2)
        XCTAssertEqual(paths[0], [node_1, node_3])
        XCTAssertEqual(paths[1], [node_1, node_2, node_5])

    }
    //            10
    //         /      \
    //        5        12
    //       /\
    //      4  7
    // 没有路径上的结点和为15
    func testCase2(){
        let node_1 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 5,  left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 12, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 7, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        let paths = solution.FindPath(node_1, expectedSum: 15)
        XCTAssertEqual(paths.count, 0)
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
    // 有一条路径上面的结点和为15
    func testCase3(){
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5
        let paths = solution.FindPath(node_1, expectedSum: 15)
        XCTAssertEqual(paths.count, 1)
        XCTAssertEqual(paths[0], [node_1,node_2,node_3,node_4,node_5])
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
    // 没有路径上面的结点和为16
    func testCase4(){
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 1, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        let paths = solution.FindPath(node_1, expectedSum: 16)
        XCTAssertEqual(paths.count, 0)
    }
    // 树中只有1个结点
    func testCase5(){
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let paths = solution.FindPath(node_1, expectedSum: 5)
        XCTAssertEqual(paths.count, 1)
        XCTAssertEqual(paths[0], [node_1])
    }
}

UnitTests.defaultTestSuite.run()

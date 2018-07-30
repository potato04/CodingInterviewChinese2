//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题32（一）：不分行从上往下打印二叉树
// 题目：从上往下打印出二叉树的每个结点，同一层的结点按照从左到右的顺序打印。

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
    func PrintFromTopToBottom(_ root: BinaryTreeNode) -> [Int] {
        var result = [Int]()
        var queue = [BinaryTreeNode]()
        queue.append(root)
        while queue.count > 0 {
            let node = queue.first!
            result.append(node.value)
            
            if node.left != nil {
                queue.append(node.left!)
            }
            if node.right != nil {
                queue.append(node.right!)
            }
            queue.remove(at: 0)
        }
        return result
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
    //        6        14
    //       /\        /\
    //      4  8     12  16
    func testCase1() {
        let node_1 = BinaryTreeNode(value: 10, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 6, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 14, parent: node_1, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_2, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 8, parent: node_2, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 12, parent: node_3, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 16, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_1.right = node_3
        node_2.left = node_4
        node_2.right = node_5
        node_3.left = node_6
        node_3.right = node_7
        XCTAssertEqual(solution.PrintFromTopToBottom(node_1), [10,6,14,4,8,12,16])
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
    func testCase2(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 1, parent: node_4, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        node_4.left = node_5
        XCTAssertEqual(solution.PrintFromTopToBottom(node_1), [5,4,3,2,1])
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
    func testCase3(){
        let node_1 = BinaryTreeNode(value: 1, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, parent: node_3, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, parent: node_4, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        node_4.right = node_5
        XCTAssertEqual(solution.PrintFromTopToBottom(node_1), [1,2,3,4,5])
    }
    // 树中只有1个结点
    func testCase4(){
        let node_1 = BinaryTreeNode(value: 1, parent: nil, left: nil, right: nil)
        XCTAssertEqual(solution.PrintFromTopToBottom(node_1), [1])
    }
}

UnitTests.defaultTestSuite.run()







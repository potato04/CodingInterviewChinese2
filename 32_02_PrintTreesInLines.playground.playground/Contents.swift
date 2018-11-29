//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题32（二）：分行从上到下打印二叉树
// 题目：从上到下按层打印二叉树，同一层的结点按从左到右的顺序打印，每一层
// 打印到一行。

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
     以二维数组的形式分层返回按从上到下从左到右的顺序的二叉树所有节点的值
     二维数组的第一个子数组的元素为根节点，第二个子数组为第二层的所有节点，以此类推
     - Parameters:
        - root: 二叉树根节点
     - Returns: 二叉树的所有节点值
     */
    func Print(_ root: BinaryTreeNode) -> [[Int]] {
        var result = [[Int]]()
        var resultItem = [Int]()
        var queue = [BinaryTreeNode]()
        queue.append(root)
        var nextLevel = 0
        var toBePrinted = 1
        while queue.count > 0 {
            let node = queue.first!
            resultItem.append(node.value)
            if node.left != nil {
                queue.append(node.left!)
                nextLevel += 1
            }
            if node.right != nil {
                queue.append(node.right!)
                nextLevel += 1
            }
            queue.remove(at: 0)
            toBePrinted -= 1
            if toBePrinted == 0 {
                result.append(resultItem)
                resultItem = [Int]()
                toBePrinted = nextLevel
                nextLevel = 0
            }
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
    //            8
    //         /      \
    //        6        10
    //       /\        /\
    //      5  7     9  11
    func testCase1() {
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
        XCTAssertEqual(solution.Print(node_1), [[8],[6,10],[5,7,9,11]])
    }
    //               5
    //              /
    //             4
    //            /
    //           3
    //          /
    //         2
    func testCase2(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        node_1.left = node_2
        node_2.left = node_3
        node_3.left = node_4
        XCTAssertEqual(solution.Print(node_1), [[5],[4],[3],[2]])
    }
    // 5
    //  \
    //   4
    //    \
    //     3
    //      \
    //       2
    func testCase3(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 4, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, parent: node_2, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 2, parent: node_3, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.right = node_4
        XCTAssertEqual(solution.Print(node_1), [[5],[4],[3],[2]])
    }
    // 5
    func testCase4(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        XCTAssertEqual(solution.Print(node_1), [[5]])
    }
    //    100
    //   /
    //  50
    //   \
    //   150
    func testCase5(){
        let node_1 = BinaryTreeNode(value: 100, parent: nil, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 50, parent: node_1, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 150, parent: node_2, left: nil, right: nil)
        node_1.left = node_2
        node_2.right = node_3
        XCTAssertEqual(solution.Print(node_1), [[100],[50],[150]])
    }

}

UnitTests.defaultTestSuite.run()

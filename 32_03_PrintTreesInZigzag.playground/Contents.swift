//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================

// 面试题32（三）：之字形打印二叉树
// 题目：请实现一个函数按照之字形顺序打印二叉树，即第一行按照从左到右的顺
// 序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，
// 其他行以此类推。

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
    func Print(_ root: BinaryTreeNode) -> [Int] {
        var results = [Int]()
        var levels = [Int: [BinaryTreeNode]]()
        levels[0] = [BinaryTreeNode]()
        levels[1] = [BinaryTreeNode]()
        
        var current = 0
        var next = 1
        
        levels[current]?.append(root)
        while !levels[0]!.isEmpty || !levels[1]!.isEmpty {
            let node = levels[current]!.last!
            levels[current]?.removeLast()
            results.append(node.value)
            
            if current == 0 {
                if node.left != nil {
                    levels[next]?.append(node.left!)
                }
                if node.right != nil {
                    levels[next]?.append(node.right!)
                }
            } else {
                if node.right != nil {
                    levels[next]?.append(node.right!)
                }
                if node.left != nil {
                    levels[next]?.append(node.left!)
                }
            }
            
            if levels[current]!.isEmpty {
                current = 1 - current
                next = 1 - next
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
        XCTAssertEqual(solution.Print(node_1), [8,10,6,5,7,9,11])
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
        XCTAssertEqual(solution.Print(node_1), [5,4,3,2])
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
        XCTAssertEqual(solution.Print(node_1), [5,4,3,2])
    }
    // 5
    func testCase4(){
        let node_1 = BinaryTreeNode(value: 5, parent: nil, left: nil, right: nil)
        XCTAssertEqual(solution.Print(node_1), [5])
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
        XCTAssertEqual(solution.Print(node_1), [100,50,150])
    }
}

UnitTests.defaultTestSuite.run()







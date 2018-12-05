//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题68：树中两个结点的最低公共祖先
// 题目：输入两个树结点，求它们的最低公共祖先。

import Foundation
import XCTest

//树结构
class TreeNode: Equatable {
    var children: [TreeNode]
    var value: Int
    
    init(value: Int, children: [TreeNode]) {
        self.value = value
        self.children = children
    }
    static func ==(left: TreeNode, right: TreeNode) -> Bool {
        return left.value == right.value
    }
}

class Solution1 {
    /*
     查找树中两个结点的最低公共祖先
     - Parameters:
        - root: 树的根节点
        - node1: 节点1
        - node2: 节点2
     - Returns: 查找到的公共祖先
     */
    func GetLastCommonParent(root: TreeNode, node1: TreeNode, node2: TreeNode) -> TreeNode? {
        var path1 = [TreeNode](), path2 = [TreeNode]()
        GetNodePath(root: root, node: node1, path: &path1)
        GetNodePath(root: root, node: node2, path: &path2)
        return GetLastCommonNode(path1: path1, path2: path2)
    }
    /*
     返回从node到root所有节点
     - Parameters:
        - root: 树的根节点
        - node: 节点
     - Returns: 是否找到
     */
    func GetNodePath(root: TreeNode, node: TreeNode,  path: inout [TreeNode]) -> Bool {
        if root == node {
            return true
        }
        path.append(root)
        var found = false
        for child in root.children {
            found = GetNodePath(root: child, node: node, path: &path)
            if found {
                break
            }
        }
        if !found {
            path.removeLast()
        }
        return found
    }
    /*
     根据两条路径查找最后公共祖先，两条路径都是从根节点在前
     - Parameters:
        - path1: 路径1
        - path2: 路径2
     - Returns: 查找最后公共祖先
     */
    func GetLastCommonNode(path1: [TreeNode], path2: [TreeNode]) -> TreeNode? {
        var commonNode: TreeNode? = nil
        for i in stride(from: 0, to: path1.count, by: 1) {
            if i < path2.count && path1[i] == path2[i] {
                commonNode = path1[i]
            } else {
                return commonNode
            }
        }
        return commonNode
    }
}

class UnitTests: XCTestCase {
    let solution1 = Solution1()
    override func setUp() {
        super.setUp()
    }
    
    // 形状普通的树
    //            1
    //          /   \
    //         2     3
    //       /   \
    //      4      5
    //     / \    / | \
    //    6   7  8  9  10
    func testCase1() {
        let node10 = TreeNode(value: 10, children: [])
        let node9 = TreeNode(value: 9, children: [])
        let node8 = TreeNode(value: 8, children: [])
        let node7 = TreeNode(value: 7, children: [])
        let node6 = TreeNode(value: 6, children: [])
        let node5 = TreeNode(value: 5, children: [node8,node9,node10])
        let node4 = TreeNode(value: 4, children: [node6,node7])
        let node3 = TreeNode(value: 3, children: [])
        let node2 = TreeNode(value: 2, children: [node4,node5])
        let node1 = TreeNode(value: 1, children: [node2,node3])
        XCTAssertEqual(node2, solution1.GetLastCommonParent(root: node1, node1: node6, node2: node8))
    }
    // 树退化成一个链表
    //               1
    //              /
    //             2
    //            /
    //           3
    //          /
    //         4
    //        /
    //       5
    func testCase2() {
        let node5 = TreeNode(value: 5, children: [])
        let node4 = TreeNode(value: 4, children: [node5])
        let node3 = TreeNode(value: 3, children: [node4])
        let node2 = TreeNode(value: 2, children: [node3])
        let node1 = TreeNode(value: 1, children: [node2])
        XCTAssertEqual(node3, solution1.GetLastCommonParent(root: node1, node1: node4, node2: node5))
    }
    // 树退化成一个链表，一个结点不在树中
    //               1
    //              /
    //             2
    //            /
    //           3
    //          /
    //         4
    //        /
    //       5
    func testCase3() {
        let node5 = TreeNode(value: 5, children: [])
        let node4 = TreeNode(value: 4, children: [node5])
        let node3 = TreeNode(value: 3, children: [node4])
        let node2 = TreeNode(value: 2, children: [node3])
        let node1 = TreeNode(value: 1, children: [node2])
        let node6 = TreeNode(value: 6, children: [])
        XCTAssertEqual(nil, solution1.GetLastCommonParent(root: node1, node1: node4, node2: node6))
    }
}

UnitTests.defaultTestSuite.run()

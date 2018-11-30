//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题37：序列化二叉树
// 题目：请实现两个函数，分别用来序列化和反序列化二叉树。

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
     以中序方式序列化二叉树，
            8
        6      10
      5   7   9  11
     以上二叉树将序列化成 8,6,5,nil,nil,7,nil,nil,10,9,nil,nil,11,nil,nil,
     - Parameters:
        - root: 树的根节点
     - Returns: 序列化之后的字符串
     */
    func Serialize(_ root: BinaryTreeNode?) -> String  {
       return Serialize(root, "")
    }
    /**
     以中序方式序列化二叉树
     - Parameters:
        - node: 树节点
        - result: 初始序列内容
     - Returns: 序列化之后的内容
     */
    private func Serialize(_ node: BinaryTreeNode?, _ result: String) -> String  {
        if node == nil {
            return result + "nil,"
        }
        var result = result
        result += "\(node!.value),"
        result = Serialize(node!.left, result)
        return Serialize(node!.right, result)
    }
    
    /**
     中序序列，反序列化二叉树
     将序列 8,6,5,nil,nil,7,nil,nil,10,9,nil,nil,11,nil,nil, 反序列化为二叉树
            8
        6      10
     5   7    9  11
     - Parameters:
        - serializedString: 序列化内容
     - Returns: 二叉树根节点
     */
    func Deserialize(_ serializedString: String) -> BinaryTreeNode? {
        let serializedString = serializedString
        return DeserializeRecursion(serializedString).node
    }
    /**
     反序列化二叉树
     - Parameters:
        - serializedString: 序列化内容
     - Returns: node:反序列化之后的根节点 serializedString: 剩余未序列化内容
     */
    private func DeserializeRecursion(_ serializedString: String) -> (node: BinaryTreeNode?, serializedString:String) {
        var serializedString = serializedString
        let firstNodeResult = getFirstNode(serializedString)
        serializedString = firstNodeResult.serializedString
        var node: BinaryTreeNode? = nil
        if firstNodeResult.isNumber {
            node = BinaryTreeNode(value: firstNodeResult.value, left: nil, right: nil)
            
            let deserializeLeftResult = DeserializeRecursion(serializedString)
            serializedString = deserializeLeftResult.serializedString
            node?.left = deserializeLeftResult.node
            
            let deserializeRightResult = DeserializeRecursion(serializedString)
            serializedString = deserializeRightResult.serializedString
            node?.right = deserializeRightResult.node
        }
        return (node: node, serializedString: serializedString)
    }
    /**
     根据序列化内容获取第一个节点值（nil或数值）
     - Parameters:
        - serializedString: 序列化内容
     - Returns: isNumber:是否数字 value:值 serializedString:剩余序列化内容
     */
    private func getFirstNode(_ serializedString: String) -> (isNumber: Bool, value: Int, serializedString: String) {
        if serializedString == "" {
            return (isNumber: false, value: -1, serializedString: serializedString)
        }
        var nodes = serializedString.split(separator: ",")
        let node = nodes.remove(at: 0)
        let serializedString = nodes.joined(separator: ",")
        if node != "nil" {
            let value = Int(node)
            return (isNumber: true, value: value!, serializedString: serializedString)
        }
        return (isNumber: false, value: -1, serializedString: serializedString)
    }
}
class UnitTests: XCTestCase {
    var solution: Solution!
    
    override func setUp() {
        super.setUp()
        solution = Solution()
    }
    
    func isBinaryTreeEqual(_ node1: BinaryTreeNode?, _ node2: BinaryTreeNode?) -> Bool {
        if node1 == nil && node2 == nil {
            return true
        }
        if node1 != nil && node2 == nil {
            return false
        }
        if node1 == nil && node2 != nil {
            return false
        }
        if node1?.value != node2?.value  {
            return false
        }
        return isBinaryTreeEqual(node1?.left, node2?.left) &&
            isBinaryTreeEqual(node1?.right, node2?.right)
    }
    
    //            8
    //        6      10
    //       5 7    9  11
    func testCase1() {
        let node_8 = BinaryTreeNode(value: 8, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 6, left: nil, right: nil)
        let node_10 = BinaryTreeNode(value: 10, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 7, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 9, left: nil, right: nil)
        let node_11 = BinaryTreeNode(value: 11, left: nil, right: nil)
        node_8.left = node_6
        node_8.right = node_10
        node_6.left = node_5
        node_6.right = node_7
        node_10.left = node_9
        node_10.right = node_11
        XCTAssertEqual(solution.Serialize(node_8),"8,6,5,nil,nil,7,nil,nil,10,9,nil,nil,11,nil,nil,")
        
        let node = solution.Deserialize("8,6,5,nil,nil,7,nil,nil,10,9,nil,nil,11,nil,nil,")
        solution.Serialize(node)
        XCTAssertTrue(isBinaryTreeEqual(node, node_8))
    }
    //            5
    //          4
    //        3
    //      2
    func testCase2() {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        node_5.left = node_4
        node_4.left = node_3
        node_3.left = node_2
        XCTAssertEqual(solution.Serialize(node_5),"5,4,3,2,nil,nil,nil,nil,nil,")
        
        let node = solution.Deserialize("5,4,3,2,nil,nil,nil,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_5))
    }
    //        5
    //         4
    //          3
    //           2
    func testCase3() {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 4, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 3, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 2, left: nil, right: nil)
        node_5.right = node_4
        node_4.right = node_3
        node_3.right = node_2
        XCTAssertEqual(solution.Serialize(node_5),"5,nil,4,nil,3,nil,2,nil,nil,")
        
        let node = solution.Deserialize("5,nil,4,nil,3,nil,2,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_5))
    }
    
    func testCase4() {
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        XCTAssertEqual(solution.Serialize(node_5),"5,nil,nil,")
        
        let node = solution.Deserialize("5,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_5))
    }
    //        5
    //         5
    //          5
    //         5
    //        5
    //       5 5
    //      5   5
    func testCase5() {
        let node_1 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_2 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_3 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_4 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_5 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_6 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_7 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_8 = BinaryTreeNode(value: 5, left: nil, right: nil)
        let node_9 = BinaryTreeNode(value: 5, left: nil, right: nil)
        node_1.right = node_2
        node_2.right = node_3
        node_3.left = node_4
        node_4.left = node_5
        node_5.left = node_6
        node_5.right = node_7
        node_6.left = node_8
        node_7.right = node_9
        XCTAssertEqual(solution.Serialize(node_1),"5,nil,5,nil,5,5,5,5,5,nil,nil,nil,5,nil,5,nil,nil,nil,nil,")
        
        let node = solution.Deserialize("5,nil,5,nil,5,5,5,5,5,nil,nil,nil,5,nil,5,nil,nil,nil,nil,")
        XCTAssertTrue(isBinaryTreeEqual(node, node_1))
    }
}

UnitTests.defaultTestSuite.run()

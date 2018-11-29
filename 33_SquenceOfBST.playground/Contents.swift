//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题33：二叉搜索树的后序遍历序列
// 题目：输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历的结果。
// 如果是则返回true，否则返回false。假设输入的数组的任意两个数字都互不相同。

import Foundation
import XCTest

class Solution {
    
    /**
     判断输入的数组是否是某二叉搜索树的后序遍历序列
     - Parameters:
        - sequence: 数组
     - Returns: 判断结果
     */
    func VerifySquenceOfBST(_ sequence: [Int]) -> Bool {
        guard sequence.count > 0 else {
            return false
        }
        let root = sequence.last!
        // 二叉搜索树左子树的节点小于根节点
        var i = 0
        while i < sequence.count - 1 {
            if sequence[i] > root {
                break
            }
            i += 1
        }
        // 二叉搜索树右子树的节点大于根节点
        var j = i
        while j < sequence.count - 1 {
            if sequence[j] < root {
                return false
            }
            j += 1
        }
        //递归判断左子树是不是二叉搜索树
        var left = true
        if i > 0 {
            left = VerifySquenceOfBST(Array(sequence[0..<i]))
        }
        //递归判断右子树是不是二叉搜索树
        var right = true
        if i < sequence.count - 1 {
            right = VerifySquenceOfBST(Array(sequence[i..<sequence.count - 1]))
        }
        
        return left && right
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
      XCTAssertEqual(solution.VerifySquenceOfBST([4,8,6,12,16,14,10]), true)
    }
    //           5
    //          / \
    //         4   7
    //            /
    //           6
    func testCase2() {
        XCTAssertEqual(solution.VerifySquenceOfBST([4,6,7,5]), true)
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
    func testCase3() {
        XCTAssertEqual(solution.VerifySquenceOfBST([1,2,3,4,5]), true)
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
    func testCase4() {
        XCTAssertEqual(solution.VerifySquenceOfBST([5,4,3,2,1]), true)
    }
    //5
    func testCase5() {
        XCTAssertEqual(solution.VerifySquenceOfBST([5]), true)
    }
    func testCase6() {
        XCTAssertEqual(solution.VerifySquenceOfBST([7,4,6,5]), false)
    }
    func testCase7() {
        XCTAssertEqual(solution.VerifySquenceOfBST([4,6,12,8,16,14,10]), false)
    }
    
}

UnitTests.defaultTestSuite.run()

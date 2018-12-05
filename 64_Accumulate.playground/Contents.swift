//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题64：求1+2+…+n
// 题目：求1+2+…+n，要求不能使用乘除法、for、while、if、else、switch、case
// 等关键字及条件判断语句（A?B:C）。

import Foundation
import XCTest

/*
 * 方法一
 * 通过 DispatchQueue.concurrentPerform 重复实例化Solution1对象
 * 然后利用 static 变量存储中间值
 */
class Solution1 {
    private static var N:Int = 0
    private static var Sum:Int = 0
    init() {
        Solution1.N = Solution1.N + 1
        Solution1.Sum = Solution1.Sum + Solution1.N
    }
    static func Reset(){
        N = 0
        Sum = 0
    }
    static func GetSum(_ n: Int) -> Int {
        let queue = DispatchQueue(label: "64_Accumulate");
        DispatchQueue.concurrentPerform(iterations: n) { i in
            queue.sync {
                _ = Solution1()
            }
        }
        let result = Sum
        Reset()
        return result
    }
}

/*
 * 方法二
 * 利用数字转成bool，再转成0和1，执行相应的函数（clourse），0的时候递归终止并返回最终的和
 */
class Solution2 {
    typealias sumFunc = (Int) -> Int
    var funs = Array<sumFunc>()
    init() {
        funs.append({(i) in
            return 0
        })
        funs.append({ [unowned self](i) in
            let index = Int(truncating: Bool(truncating: i as NSNumber) as NSNumber)
            return self.funs[index](i - 1) + i
        })
    }
    func GetSum(_ n:Int) -> Int {
        return funs[1](n)
    }
}

class UnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCase1() {
        XCTAssertEqual(1, Solution1.GetSum(1))
        XCTAssertEqual(15, Solution1.GetSum(5))
        XCTAssertEqual(55, Solution1.GetSum(10))
        XCTAssertEqual(0, Solution1.GetSum(0))
    }
    func testCase2() {
        let solution2 = Solution2()
        XCTAssertEqual(1, solution2.GetSum(1))
        XCTAssertEqual(15, solution2.GetSum(5))
        XCTAssertEqual(55, solution2.GetSum(10))
        XCTAssertEqual(0, solution2.GetSum(0))
    }
}

UnitTests.defaultTestSuite.run()

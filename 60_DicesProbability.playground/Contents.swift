//==================================================================
// 《剑指Offer——名企面试官精讲典型编程题》代码
//==================================================================
// 面试题60：n个骰子的点数
// 题目：把n个骰子扔在地上，所有骰子朝上一面的点数之和为s。输入n，打印出s
// 的所有可能的值出现的概率。

import Foundation
import XCTest

class Solution {
    let DiceMaxValue: Int = 6
    
    // 方法一 递归计算出所有可能和的出现次数，最后与总次数相除算出概率
    func PrintProbability_Solution1(_ num: Int) -> [Int: Double]{
        var result = [Int: Double]()
        guard num > 0 else {
            return result
        }
        let maxSum = num * DiceMaxValue
        //num个骰子的和是不会出现 (1到[num-1]) 这几个数字的，所以可能出现的和总数是 maxSum - num + 1
        var probabilities = Array.init(repeating: 0, count: maxSum - num + 1)
        probabilities = Probability(num, probabilities)
        let total = (pow(Decimal(DiceMaxValue), num) as NSDecimalNumber).doubleValue
        for (index, probability) in probabilities.enumerated() {
            result[index + num] = Double(probability) / total
        }
        return result
    }
    private func Probability(_ num: Int, _ probabilities: [Int]) -> [Int] {
        var probabilities = probabilities
        for index in 1...DiceMaxValue {
            probabilities =  Probability(num, num, index, probabilities)
        }
        return probabilities;
    }
    private func Probability(_ original: Int, _ current: Int, _ sum: Int, _ probabilities: [Int] ) -> [Int] {
        var probabilities = probabilities
        if current == 1 {
            probabilities[sum - original] += 1
        } else {
            for index in 1...DiceMaxValue {
                probabilities = Probability(original, current - 1, sum + index, probabilities)
            }
        }
        return probabilities
    }
    
    // 方法二 利用两个数组
    func PrintProbability_Solution2(_ num: Int) -> [Int: Double]  {
        var result = [Int: Double]()
        guard num > 0 else {
            return result
        }
        var probabilities = [[Int]]()
        probabilities.append(Array.init(repeating: 0, count: DiceMaxValue * num + 1 ))
        probabilities.append(Array.init(repeating: 0, count: DiceMaxValue * num + 1 ))
        var flag = 0
        for index in 1...DiceMaxValue {
            probabilities[flag][index] = 1
        }
        for r in 2...num {
            //将另一个数组的小于r的元素都设置为 0 （因为r个骰子的和不会比r小）
            for index in 0..<r {
                probabilities[1-flag][index] = 0
            }
            //开始处理 r 到 最大值（DiceMaxvalue*r）之间的的情况
            for index in r...DiceMaxValue * r {
                probabilities[1-flag][index] = 0
                for j in 1...min(index, DiceMaxValue) {
                    probabilities[1-flag][index] += probabilities[flag][index - j];
                }
            }
            flag = 1 - flag
        }
        let total = (pow(Decimal(DiceMaxValue), num) as NSDecimalNumber).doubleValue
        for (index, probability) in probabilities[flag].enumerated() {
            if index >= num {
                result[index] = Double(probability) / total
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
    //本题目不太好测试 😓
    func testCase1() {
        let result1 = solution.PrintProbability_Solution1(2)
        let result2 = solution.PrintProbability_Solution2(2)
    }
}

UnitTests.defaultTestSuite.run()

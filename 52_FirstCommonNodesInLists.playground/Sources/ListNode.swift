import Foundation

public class ListNode: Equatable {
    public var next: ListNode?
    public var value: Int
    
    public init(value: Int, next: ListNode?) {
        self.value = value
        self.next = next
    }
    
    public static func ==(left: ListNode, right: ListNode) -> Bool {
        return left.value == right.value
    }

}


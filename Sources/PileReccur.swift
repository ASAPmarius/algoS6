protocol TStack {
/// ckeck if stack is empty
/// - returns: `true` if stack is empty
var isEmpty : Bool { get }
var isFull : Bool { get }
/// get the value on the top of the stack
/// - returns: `nil` if the stack is empty, else return value on
/// top of the stack
var top : Int? { get }
/// nombre maximum d'éléments autorisés dans la pile
var capacity: Int { get }
/// nombre d'éléments dans la pile
var count: Int { get }
/// remove top of the stack
/// - precondition: stack must not be empty
/// - returns: new stack with top removed
/// - throws: `fatalerror` if stack was empty
mutating func pop()
/// push a new value on top of the stack
/// - Parameter val: value to be push on top of stack
/// - returns: the new stack with value on top
mutating func push(_ val: Int)
}

class StackRecNonEmpty: CustomStringConvertible {
    private(set) var val: Int
    private(set) var next: StackRecNonEmpty?

    init (val: Int, next:StackRecNonEmpty?){
        self.val = val
        self.next = next ?? nil
    }

    public var description: String {
        return "\(val) -> \(next?.description ?? "nil")"
    }
}

class Stack:TStack {
    private(set) var capacity: Int
    private(set) var count: Int
    private var firstNode:StackRecNonEmpty?

    init(capacity:Int){
        self.capacity = capacity
        self.count = 0
        self.firstNode = nil
    }

    var isEmpty: Bool{
        return firstNode == nil
    }

    var isFull:Bool{
        return count == capacity
    }

    var top: Int?{
        guard let firstNodeNonEmpty: StackRecNonEmpty = self.firstNode else {
            return nil
        }
        return firstNodeNonEmpty.val
    }

    func pop() {
        if isEmpty{
            fatalError("Cannot pop from an empty stack")
        } 
        self.count -= 1
        self.firstNode = self.firstNode?.next
    }

    func push (_ val:Int){
        if isFull{
            return
        }
        if isEmpty{
            self.count += 1
            self.firstNode = StackRecNonEmpty(val:val, next:nil)
        } else {
            self.count += 1
            self.firstNode = StackRecNonEmpty(val:val, next:firstNode)
        }
    }
}
protocol ItListe {
    func next() -> Int?
    func currentNode() -> Int
}

protocol ListChainneT {
    var isEmpty: Bool {get}
    var count: Int {get}
    var first: Int? {get}
    var last: Int? {get}
    func nb_occur(val :Int) -> Int
    mutating func insertFirst(val: Int)
    mutating func insertLast(val: Int)
    mutating func removeFirst()
    mutating func removeLast()
    mutating func insertAfter(_ it: inout ItListe, val: Int)
    // Insère un élément avant l'élément courant ou en premier si pas d'élément courant
    mutating func insertBefore(_ it: inout ItListe, val: Int)
    // Supprime l'élément courant, ne fait rien si pas d'élément courant
    mutating func remove(_ it: inout ItListe,val: Int)
}

class Node {
    public var prev: Node!
    public var next: Node!
    public var val: Int

    init(val: Int) {
        self.val = val
        self.prev = self
        self.next = self
    }
}

class ListChainne:ListChainneT {
    private(set) var count: Int
    fileprivate var head: Node = Node(val: -1) //on accède jamais a la valeur peut importe
    
    init(){
        self.count = 0
        self.head.prev = self.head
        self.head.next = self.head
    }

    public class Iterator: IteratorProtocol,ItListe,Sequence{
        fileprivate var current: Node
        fileprivate var head: Node

        init(start: Node, head: Node){
            self.current = start
            self.head = head
        }

        public func next() -> Int? {
            if self.current === self.head {
                self.current = self.head.next
                return nil
            }
            let value = self.current.val
            self.current = self.current.next
            return value
        }

        public func currentNode() -> Int{
            return current.val
        }

        public func reset(){
            self.current = self.head
        }
    }

    func makeIterator(start: Node) -> Iterator{
        return Iterator(start: start, head: self.head)
    }

    var first: Int?{
        return self.head.next.val
    }

    var last: Int?{
        return self.head.prev.val
    }

    var isEmpty: Bool{
        return count == 0
    }

    func nb_occur(val: Int) -> Int {
        var nb_occur:Int = 0
        let iterator: ListChainne.Iterator = makeIterator(start: self.head.next)
        for currentVal: Int in iterator {
            if currentVal == val{
                nb_occur += 1
            }
        }
        return nb_occur
    }

    func insertFirst(val: Int){
        let newNode:Node = Node(val: val)
        let oldFirst:Node = self.head.next
        newNode.prev = self.head
        newNode.next = oldFirst
        oldFirst.prev = newNode
        self.head.next = newNode
        count+=1
    }

    func insertLast(val: Int) {
        let newNode:Node = Node(val: val)
        let oldLast:Node = self.head.prev
        newNode.next = self.head
        newNode.prev = oldLast
        oldLast.next = newNode
        self.head.prev = newNode
        count+=1
    }

    func removeFirst() {
        guard !isEmpty else { return }
        let firstNode: Node = self.head.next
        let newFirst: Node = firstNode.next
        self.head.next = newFirst
        newFirst.prev = self.head
        count -= 1
    }

    func removeLast() {
        guard !isEmpty else { return }
        let lastNode: Node = self.head.prev
        let newLast: Node = lastNode.prev
        self.head.prev = newLast
        newLast.next = self.head
        count -= 1
    }

    func findNode(val: Int) -> Node? {
        let iterator: ListChainne.Iterator = makeIterator(start: self.head.next)
        guard !isEmpty else { return nil }
        while iterator.current !== self.head {
            if iterator.currentNode() == val {
                return iterator.current
            }
            _ = iterator.next()
        }
        return nil
    }

    func insertAfter(_ it: inout any ItListe, val: Int) {
    let newNode:Node = Node(val: val)
    if let beforeNode: Node = findNode(val: val){
        let afterNode:Node = beforeNode.next
        newNode.next = afterNode
        newNode.prev = beforeNode
        beforeNode.next = newNode
        afterNode.prev = newNode
    } else {
        insertLast(val: val)
        }
    count+=1
    }

    func insertBefore(_ it: inout any ItListe, val: Int) {
    let newNode:Node = Node(val: val)
    if let afterNode: Node = findNode(val: val){
        let beforeNode:Node = afterNode.prev
        newNode.next = afterNode
        newNode.prev = beforeNode
        beforeNode.next = newNode
        afterNode.prev = newNode
    } else {
        insertLast(val: val)
        }
    count+=1
    }

    func remove(_ it: inout ItListe,val: Int){
        if let nodeToDelete: Node = findNode(val: val){
            nodeToDelete.prev.next = nodeToDelete.next
            nodeToDelete.next.prev = nodeToDelete.prev
            count -= 1
        }
    }
}

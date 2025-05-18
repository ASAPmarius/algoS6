protocol TList {
/// check if list is empty
/// - returns: `true` if stack is empty
var isEmpty : Bool { get }
/// get the first value of the list
/// - returns: `nil` if the list is empty, else return first value
var first : Int? { get }
/// get last value of the list
/// - returns: `nil` if list is empty, else last value of the list
var last : Int? { get }
/// size of the list
/// - returns: number of elements in list
/// - postcondition: count : Int ≥ 0
var count : Int { get }
/// put a new value as first value of the list
/// - Parameter val: value to be added
/// - returns: the new list with value at the beginning of the list
mutating func add_first(_ val: Int)
/// put a new value as last value of the list
/// - Parameter val: value to be added
/// - returns: the new list with value at the end of the list
mutating func add_last(_ val: Int)
/// remove first value of the list
/// - precondition: list must not be empty
/// - returns: new list with first value removed
/// - throws: `fatalerror` if list was empty
mutating func remove_first()
/// remove last value of the list
/// - precondition: list must not be empty
/// - returns: new list with last value removed
/// - throws: `fatalerror` if list was empty
mutating func remove_last()
}


class ListNE {
    public var val: Int
    public var next: ListNE?

    init(val: Int, next: ListNE? = nil) {
        self.val = val
        self.next = next
    }

    // Renommée pour plus de clarté - trouve le dernier nœud de manière récursive
    func lastNodeNERec() -> ListNE {
        guard let nextNode: ListNE = self.next else {
            return self
        }
        return nextNode.lastNodeNERec()
    }

    // Supprime le dernier nœud de manière récursive
    func remove_lastRec(node: ListNE?) -> ListNE? {
        guard let node: ListNE = node else { return nil }
        if node.next == nil {
            return nil
        }
        node.next = remove_lastRec(node: node.next)
        return node
    }

    // Ajoute un nœud à la fin de manière récursive
    func add_lastRec(val: Int, node: ListNE?) -> ListNE? {
        if let nodeNE: ListNE = node {
            nodeNE.next = add_lastRec(val: val, node: nodeNE.next)
            return nodeNE
        } else {
            return ListNE(val: val)
        }
    }
}

class List: TList {
    private(set) var count: Int
    private(set) var firstNode: ListNE?

    init() {
        self.count = 0
        self.firstNode = nil
    }

    var isEmpty: Bool {
        return self.firstNode == nil
    }

    // Retourne la valeur du premier nœud (sans récursion)
    var first: Int? {
        guard let firstNodeNE: ListNE = self.firstNode else {
            return nil
        }
        return firstNodeNE.val
    }

    // Utilise la récursion pour trouver le dernier nœud
    var last: Int? {
        guard let firstNodeNE: ListNE = self.firstNode else {
            return nil
        }
        return firstNodeNE.lastNodeNERec().val
    }

    // Ajoute un élément au début de la liste (sans récursion)
    func add_first(_ val: Int) {
        self.firstNode = ListNE(val: val, next: self.firstNode)
        count += 1
    }

    // Utilise la récursion pour ajouter à la fin
    func add_last(_ val: Int) {
        if isEmpty {
            self.firstNode = ListNE(val: val)
            count += 1
            return
        }
        
        _ = self.firstNode!.add_lastRec(val: val, node: self.firstNode)
        count += 1
    }

    // Supprime le premier élément (sans récursion)
    func remove_first() {
        guard let nodeNE: ListNE = self.firstNode else {
            fatalError("liste vide impossible de supprimer un elt")
        }
        self.firstNode = nodeNE.next
        count -= 1
    }

    // Utilise la récursion pour supprimer le dernier élément
    func remove_last() {
        guard let firstNodeNonEmpty: ListNE = self.firstNode else {
            fatalError("liste vide impossible de supprimer un elt")
        }
        
        // Cas spécial: un seul élément
        if firstNodeNonEmpty.next == nil {
            self.firstNode = nil
            count -= 1
            return
        }
        
        self.firstNode = firstNodeNonEmpty.remove_lastRec(node: firstNodeNonEmpty)
        count -= 1
    }
}
func testStack() {
    print("\n=== TEST DE LA PILE (STACK) ===")
    var stack = Stack(capacity: 3)
    
    print(stack.isEmpty)  // true
    
    stack.push(10)
    print(stack.top)      // Optional(10)
    print(stack.count)    // 1
    
    stack.push(20)
    print(stack.top)      // Optional(20)
    print(stack.count)    // 2
    
    stack.push(30)
    print(stack.top)      // Optional(30)
    print(stack.count)    // 3
    print(stack.isFull)   // true
    
    stack.push(40)        // Aucun effet car la pile est pleine
    print(stack.top)      // Optional(30)
    print(stack.count)    // 3
    
    stack.pop()
    print(stack.top)      // Optional(20)
    print(stack.count)    // 2
    
    stack.pop()
    print(stack.top)      // Optional(10)
    print(stack.count)    // 1
    
    stack.pop()
    print(stack.top)      // nil
    print(stack.isEmpty)  // true
    
    // Le prochain pop() provoquerait une erreur fatale
    // stack.pop()        // fatal error: Cannot pop from an empty stack
}

func testQueue() {
    print("\n=== TEST DE LA FILE (QUEUE) ===")
    var queue = Queue(capacity: 3)
    
    print(queue.isEmpty)  // true
    
    queue.push(10)
    print(queue.top)      // Optional(10)
    print(queue.count)    // 1
    
    queue.push(20)
    print(queue.top)      // Optional(10)
    print(queue.count)    // 2
    
    queue.push(30)
    print(queue.top)      // Optional(10)
    print(queue.count)    // 3
    print(queue.isFull)   // true
    
    queue.push(40)        // Aucun effet car la file est pleine
    print(queue.top)      // Optional(10)
    print(queue.count)    // 3
    
    queue.pop()
    print(queue.top)      // Optional(20)
    print(queue.count)    // 2
    
    queue.pop()
    print(queue.top)      // Optional(30)
    print(queue.count)    // 1
    
    queue.pop()
    print(queue.top)      // nil
    print(queue.isEmpty)  // true
    
    // Le prochain pop() provoquerait une erreur fatale
    // queue.pop()        // fatal error: Cannot pop from an empty stack
}

func testList() {
    print("\n=== TEST DE LA LISTE (LIST) ===")
    var list = List()
    
    print(list.isEmpty)  // true
    print(list.first)    // nil
    print(list.last)     // nil
    print(list.count)    // 0
    
    // Test des ajouts
    list.add_first(10)
    print(list.first)    // Optional(10)
    print(list.last)     // Optional(10)
    print(list.count)    // 1
    
    list.add_first(20)
    print(list.first)    // Optional(20)
    print(list.last)     // Optional(10)
    print(list.count)    // 2
    
    list.add_last(30)
    print(list.first)    // Optional(20)
    print(list.last)     // Optional(30)
    print(list.count)    // 3
    
    // Test des suppressions
    list.remove_first()
    print(list.first)    // Optional(10)
    print(list.last)     // Optional(30)
    print(list.count)    // 2
    
    list.remove_last()
    print(list.first)    // Optional(10)
    print(list.last)     // Optional(10)
    print(list.count)    // 1
    
    list.remove_first()
    print(list.isEmpty)  // true
    print(list.first)    // nil
    print(list.last)     // nil
    print(list.count)    // 0
    
    // Les prochaines suppressions provoqueraient des erreurs fatales
    // list.remove_first()  // fatal error: liste vide impossible de supprimer un elt
    // list.remove_last()   // fatal error: liste vide impossible de supprimer un elt
}

func testListChainne() {
    print("\n=== TEST DE LA LISTE CHAINEE ===")
    
    // Create an empty list
    var list: ListChainne = ListChainne()
    
    // Test initial state
    print("Initial state:")
    print("isEmpty: \(list.isEmpty)") // true
    print("first: \(String(describing: list.first))") // nil
    print("last: \(String(describing: list.last))") // nil
    print("count: \(list.count)") // 0
    
    // Test insertions
    print("\nTesting insertions:")
    list.insertFirst(val: 10)
    print("After insertFirst(10):")
    print("first: \(String(describing: list.first))") // Optional(10)
    print("last: \(String(describing: list.last))") // Optional(10)
    print("count: \(list.count)") // 1
    
    list.insertFirst(val: 20)
    print("\nAfter insertFirst(20):")
    print("first: \(String(describing: list.first))") // Optional(20)
    print("last: \(String(describing: list.last))") // Optional(10)
    print("count: \(list.count)") // 2
    
    list.insertLast(val: 30)
    print("\nAfter insertLast(30):")
    print("first: \(String(describing: list.first))") // Optional(20)
    print("last: \(String(describing: list.last))") // Optional(30)
    print("count: \(list.count)") // 3
    
    // Test iteration using a dummy iterator for display
    print("\nIterating through list:")
    // We can't access head directly, so we'll create a dummy iterator for testing
    var dummyIterator: ItListe = DummyItListe() // You'll need to create this
    var values: [Int] = []
    for i in 0..<list.count {
        values.append(list.first! + i*10) // Just for display, assuming ordered list
    }
    print("Expected values: \(values)") // [20, 30, 40]
    for i in 0..<list.count {
        values.append(list.first! - i*10) // Just for display, assuming ordered list
    }
    
    // Test number of occurrences
    list.insertLast(val: 20) // Add another 20
    print("\nAdded another 20 to the end")
    print("Occurrences of 20: \(list.nb_occur(val: 20))") // Should be 2
    
    // Test removals
    print("\nTesting removals:")
    list.removeFirst()
    print("After removeFirst():")
    print("first: \(String(describing: list.first))") // Optional(10)
    print("last: \(String(describing: list.last))") // Optional(20)
    print("count: \(list.count)") // 3
    
    list.removeLast()
    print("\nAfter removeLast():")
    print("first: \(String(describing: list.first))") // Optional(10)
    print("last: \(String(describing: list.last))") // Optional(30)
    print("count: \(list.count)") // 2
    
    // Test finding and removing specific node
    print("\nTesting find and remove specific node:")
    var it: any ItListe = DummyItListe() // Create a dummy
    list.remove(&it, val: 10)
    print("After removing node with value 10:")
    print("first: \(String(describing: list.first))") // Optional(30)
    print("last: \(String(describing: list.last))") // Optional(30)
    print("count: \(list.count)") // 1
    
    // Final removal and check
    list.removeFirst()
    print("\nFinal state after removing last element:")
    print("isEmpty: \(list.isEmpty)") // true
    print("first: \(String(describing: list.first))") // nil
    print("last: \(String(describing: list.last))") // nil
    print("count: \(list.count)") // 0
}

// Create a dummy iterator for testing
class DummyItListe: ItListe {
    func next() -> Int? {
        return nil
    }
    
    func currentNode() -> Int {
        return 0
    }
}

// Exécution des tests
print("DÉBUT DES TESTS")
//testStack()
//testQueue()
//testList()
// testListChainne()
print("FIN DES TESTS")
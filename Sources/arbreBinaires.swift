enum TreeError: Error {
    case emptyTree
}

class ArbreBin {
    public var sag: ArbreBin?
    public var sad: ArbreBin?
    public var val: Int?
    
    // Empty tree constructor
    init() {
        self.val = nil
        self.sag = nil
        self.sad = nil
    }
    
    // Tree with value constructor
    init(value: Int, sag: ArbreBin? = nil, sad: ArbreBin? = nil) {
        self.val = value
        self.sag = sag
        self.sad = sad
    }
    
    func ab_vide() -> Bool {
        return val == nil
    }
    
    func racine() throws -> Int {
        guard let value: Int = val else {
            throw TreeError.emptyTree
        }
        return value
    }
    
    func getSag() throws -> ArbreBin? {
        guard !ab_vide() else {
            throw TreeError.emptyTree
        }
        return sag
    }
    
    func getSad() throws -> ArbreBin? {
        guard !ab_vide() else {
            throw TreeError.emptyTree
        }
        return sad
    }
    
    func creer_ab(val: Int) {
        self.val = val
        self.sag = nil
        self.sad = nil
    }
    
    func enraciner(sag: ArbreBin? = nil, val: Int, sad: ArbreBin? = nil) throws {
        guard !ab_vide() else {
            throw TreeError.emptyTree
        }
        self.val = val
        self.sag = sag
        self.sad = sad
    }
}

extension ArbreBin {
    // MARK: - Horizontal Tree Display
    
    func displayHorizontal() {
        if ab_vide() {
            print("Arbre vide")
            return
        }
        
        let hasLeft = sag != nil && !sag!.ab_vide()
        let hasRight = sad != nil && !sad!.ab_vide()
        
        // For a simple tree with just root and two children
        if hasLeft || hasRight {
            let leftVal = hasLeft ? "\(sag!.val!)" : " "
            let rightVal = hasRight ? "\(sad!.val!)" : " "
            let rootVal = "\(val!)"
            
            // Calculate spacing for centering
            let leftStr = leftVal
            let rightStr = rightVal
            let totalWidth = leftStr.count + rightStr.count + 10 // space for connectors
            
            // Print root centered
            let rootPadding = (totalWidth - rootVal.count) / 2
            print(String(repeating: " ", count: rootPadding) + rootVal)
            
            // Print connector line
            let connector = leftStr + String(repeating: "_", count: 4) + "|" + String(repeating: "_", count: 4) + rightStr
            print(connector)
            
        } else {
            // Just root node
            print("    \(val!)")
        }
    }
}
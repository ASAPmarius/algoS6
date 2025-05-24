class NoeudABR{
    var valeur : Int
    var gauche : NoeudABR?
    var droit : NoeudABR?
    var pere : NoeudABR?
    init(valeur : Int, gauche: NoeudABR?=nil, droit: NoeudABR?=nil , pere : NoeudABR?=nil){
        self.valeur = valeur
        self.gauche = gauche
        self.droit = droit
        self.pere = pere
    }
}

// Définition de la classe pour l'arbre binaire de recherche
class ABR{
    private var root: NoeudABR?
    
    // crée un arbre binaire de recherche vide
    init(){
           root = nil
       }
    
    // retourne True si l’arbre binaire de recherche est vide, False sinon.
    func isEmpty()->Bool{
        return root == nil
    }
    
    // retourne la valeur de l’élément contenu à la racine de l’arbre passé en paramètre ; ERREUR si l’arbre est vide
    func val()->Int{
        guard let r: NoeudABR = root else {fatalError("Erreur fatale : on ne peux chercher une valeur dans un arbre vide.")}
        return r.valeur
    }

    func contain(val:Int) -> Bool {
        return containRec(val: val, node:self.root)
    }

    func containRec(val:Int, node:NoeudABR?) -> Bool{
        if let nonEmptyRoot: NoeudABR = node {
            if nonEmptyRoot.valeur == val{
                return true
            }
            if val < nonEmptyRoot.valeur {
                return containRec(val: val, node: node?.gauche)
            } else {
                return containRec(val: val, node: node?.droit)
            }
        } else {
            return false
        }
    }

    func insert(val:Int){
        if self.contain(val: val){
            print("valeur déjà présente")
            return
        }
        self.root = insertRec(val: val, node: self.root, pere: nil)
    }

    func insertRec(val:Int,node:NoeudABR?, pere:NoeudABR?) -> NoeudABR{
        guard let nonEmptyNode:NoeudABR = node else{
            return NoeudABR(valeur: val, gauche: nil, droit: nil, pere: pere)
        }
        if nonEmptyNode.valeur > val{
            nonEmptyNode.gauche =  insertRec(val: val, node: nonEmptyNode.gauche, pere: nonEmptyNode)
        }
        else if nonEmptyNode.valeur < val{
            nonEmptyNode.droit = insertRec(val: val, node: nonEmptyNode.droit, pere: nonEmptyNode)
        }
        return nonEmptyNode
    }

    func searchNode(val:Int) -> NoeudABR?{
        if !self.contain(val: val){
            print("l'arbre ne contient pas ce noeud")
            return nil
        } else {
            return searchNodeRec(val: val, node:self.root)
        }
    }

    func searchNodeRec(val:Int, node:NoeudABR?)-> NoeudABR{
        guard let nonEmptyNode: NoeudABR = node else{
            fatalError("conficts between contain and search Node")       
        }
        if nonEmptyNode.valeur == val {
            return nonEmptyNode
        }
        if nonEmptyNode.valeur < val{
            return searchNodeRec(val: val, node: nonEmptyNode.droit)
        }
        else{
            return searchNodeRec(val: val, node: nonEmptyNode.gauche)
        }
    }

    func successor(node: NoeudABR) -> NoeudABR? {
        var current: NoeudABR? = node.droit
        while current?.gauche != nil {
            current = current?.gauche
        }
        return current
    }

    func isLeaf(node:NoeudABR) -> Bool{
        return (node.gauche == nil && node.droit == nil)
    }

    func removeElt(_ valeur: Int) {
        guard let noeudASuppr: NoeudABR = searchNode(val: valeur) else {
            print("Erreur : La valeur \(valeur) n'existe pas dans l'arbre.")
            return
        }
        if isLeaf(node: noeudASuppr) {
            print("je suis une feuille")
            if let papa: NoeudABR = noeudASuppr.pere {
                if noeudASuppr.valeur < papa.valeur {
                    papa.gauche = nil
                } else {
                    papa.droit = nil
                }
            } else {
                root = nil
            }
        }
        else if noeudASuppr.droit == nil {
            if let noeudGaucheNonVide: NoeudABR = noeudASuppr.gauche {
                noeudGaucheNonVide.pere = noeudASuppr.pere
                if let papa: NoeudABR = noeudASuppr.pere {
                    if noeudASuppr.valeur < papa.valeur {
                        papa.gauche = noeudGaucheNonVide
                    } else {
                        papa.droit = noeudGaucheNonVide
                    }
                } else {
                    root = noeudGaucheNonVide
                }
            }
        }
        else if noeudASuppr.gauche == nil {
            if let noeudDroitNonVide: NoeudABR = noeudASuppr.droit {
                noeudDroitNonVide.pere = noeudASuppr.pere
                if let papa: NoeudABR = noeudASuppr.pere {
                    if noeudASuppr.valeur < papa.valeur {
                        papa.gauche = noeudDroitNonVide
                    } else {
                        papa.droit = noeudDroitNonVide
                    }
                } else {
                    root = noeudDroitNonVide
                }
            }
        }
        else{
            if let noeudSuccesseur:NoeudABR = successor(node: noeudASuppr){
                removeElt(noeudSuccesseur.valeur)
                noeudASuppr.valeur = noeudSuccesseur.valeur
            }
        }
    }

    // vérifie que le chainage arrière est correct
    func verifierChainage()->Bool{
            return verifierChainageRec(root)
            }
    
      private func verifierChainageRec(_ noeud: NoeudABR?) -> Bool {
            guard let noeud: NoeudABR = noeud else {
                return true
            }
            
            if let gauche: NoeudABR = noeud.gauche {
                if gauche.pere !== noeud {
                    return false
                }
                if !verifierChainageRec(gauche) {
                    return false
                }
            }
            if let droit: NoeudABR = noeud.droit {
                if droit.pere !== noeud {
                    return false
                }
                if !verifierChainageRec(droit) {
                    return false
                }
            }
            return true
        }
    
     /// - returns: a String description of a binary tree
    public var description: String { return descDecalRec(root , dec : "") }

    // Fonction auxiliaire pour faire des décalages horizontaux et montrer les niveaux de l'arbre
    func descDecalRec(_ noeud : NoeudABR?, dec : String) -> String {
        var desc : String = ""
        guard let noeud: NoeudABR = noeud else { return dec+""}
        var g: String = dec + descDecalRec(noeud.gauche,dec: dec+"    ")
        var v: String = String(noeud.valeur)
        var d: String = dec + descDecalRec(noeud.droit, dec: dec+"    ")
        desc = d + "\n"   + dec + v + "\n" + g  + "\n"
        return desc
    }
}
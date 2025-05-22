// sondage quadratique : l’intervalle entre les cases augmente
// linéairement en fonction du carré de l’indice ; on trouve deux
// variantes classiques :
// hi(m) = (h(m) + i + i^2) mod N
// ici N = 100 (a peu près je crois)

//retourne la valeur associée a la lettre
func unicode(of l: Character) -> Int?{
    // récupère le code de la lettre et prend le premier scalaire 
    // (seuls les codes des caractères spéciaux comme les emoj ou les caractères complexes ont plusieurs scalaires) 
    guard let scalar: Unicode.Scalar = l.unicodeScalars.first else { return nil }
    return Int(scalar.value) // Convertir la valeur scalaire en Int
}
// exemple de retour: 
//   'B' : 66
//   'a' : 97
//   'r' : 114
//   'b' : 98
//   'e' : 101

func hashage(word: String) -> Int{
    var sommeRang: Int = 0
    for char: Character in word{
        if let valeurUni: Int = unicode(of: char){
            sommeRang += valeurUni
        }
    }
    return (sommeRang % 97) % 2017
}
//exemple de retour: nom: Garreau -> hashage: 32

protocol TDico {
    //ajoute une nouvelle définition dans le dictionnaire, ERREUR si une donnée est déjà associée à cette clé
    mutating func insert(cle: String, valeur: Int)
    //Vrai si une définition existe pour ce mot
    func appartient (cle: String) -> Bool
    //renvoie la définition d’un mot ou une erreur si ce mot n’appartient pas au dictionnaire
    func recherche(cle: String) -> Int
    // renvoie le dictionnaire duquel on a supprimé l’entrée correspondant au mot, ou le dictionnaire inchangé si le mot n’appartient pas au dictionnaire.
    mutating func supprime(cle:String)
    // modifie la définition du mot donné en paramètre ; erreur si le mot n’appartient pas au dictionnaire.
    mutating func modifie(cle:String, val:Int)
} 

class Alveole {
    public var cle: String
    public var val: Int

    init (cle: String, val:Int){
        self.cle = cle
        self.val = val
    }
}

class Dico{
    var tab: [Alveole?]
    var seuil: Int //exprimé en %
    var count: Int = 0
    var taille: Int

    init(seuil: Int){
        self.tab = Array(repeating: nil, count: 100)
        self.seuil = seuil
        self.taille = 100
    }

    func insert(cle: String, valeur: Int){
        if self.appartient(cle:cle) {
            print("erreur valeur déjà dans le dico")
            return
        } 

        self.count += 1

        if (count * 100) / tab.count > seuil {      //existe il une meilleur option ?
            let oldTab: [Alveole?] = self.tab
            self.taille = self.taille * 2
            print("new taille", self.taille)
            self.tab = Array(repeating: nil, count: self.taille)
            self.count = 0
            for alveole: Alveole? in oldTab {
                if let a: Alveole = alveole {
                    self.insert(cle: a.cle, valeur: a.val)
                }
            }
            print("========== TABLEAU  REDIMENSIONNE ============")
        }

        var hash: Int = hashage(word: cle)
        print("hash de \(cle) : \(hash)")
        let alveole: Alveole = Alveole(cle: cle, val: valeur)

        if self.tab[hash] == nil {
            tab[hash] = alveole
            print("inseré")
        } else {
            var insertBool: Bool = false
            var i: Int = 1
            while !insertBool{
                hash = (hash + i + i * i) % self.taille
                print("essai avec \(hash), essai numéro \(i)")
                if self.tab[hash] == nil {
                    tab[hash] = alveole
                    insertBool = true
                }
                i += 1
            }
        }
    }

    func appartient (cle: String) -> Bool{      
        let hash: Int = hashage(word: cle)
        if let alveloleNonVide: Alveole = self.tab[hash] {      //comment faire si ona une collision et donc que la valeur n'est pas au bon indice ?
            if alveloleNonVide.cle == cle{
                return true
            } 
        }
        return false
    }

    func recherche(cle: String) -> Int{
        if appartient(cle: cle){
            if let alveloleNonVide: Alveole = self.tab[hashage(word: cle)] {
                return alveloleNonVide.val
            }
        }
        print("erreur la cle n'est pas dans le tableau")   //pareil
        return -1
    }

    func supprime(cle:String){
        if appartient(cle: cle){
            self.tab[hashage(word: cle)] = nil
        } else {
           print("erreur la cle n'est pas dans le tableau")   //pareil
        }
    }

    func modifie(cle:String, val:Int){
        if appartient(cle: cle){
            if let alveloleNonVide: Alveole = self.tab[hashage(word: cle)] {
                alveloleNonVide.val = val
            }
        } else {
            print("erreur la cle n'est pas dans le tableau")   //pareil
        }
    }

    //je pense qu'il faut une fonction helper to avoir le vrai indice mais comment faire plus efficace que tt parcourir ?
}

// Ajoute la conformité au protocole CustomStringConvertible pour fournir une description lisible du dictionnaire.
extension Dico: CustomStringConvertible {
    var description: String {
        let elements: String = tab.compactMap { alveole in
            if let a: Alveole = alveole {
                return "\"\(a.cle)\": \(a.val)"
            }
            return nil
        }.joined(separator: ", ")
        return "Dico(taille: \(tab.count), seuil: \(seuil)%) [\(elements)]"
    }
}
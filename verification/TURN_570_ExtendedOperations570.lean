import SFT.Chemistry.ExtendedExtraction
open SFT.Chemistry.ExtendedExtraction SFT.Host.Canonical
def result (v : Value) : Value := match definitionAndNotes v with
 | .error e => .object [("error",.text e)]
 | .ok text => .object [("text",.text text)]
def main : IO Unit := do
 IO.println (render (result (.object [])))
 IO.println (render (result (.object [("definitions",.null)])))
 IO.println (render (result (.object [("definitions",.array [.null])])))
 IO.println (render (result (.object [("definitions",.array [])])))
 IO.println (render (result (.object [("definitions",.array [.object []])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "main"),("notes",.object [("2",.text "second"),("10",.text "tenth"),("1",.text "first")])]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.null),("notes",.array [.text "one",.boolean true,.boolean false,.null,.integer (17),.integer (-3),.array [],.object [],.array [.text "a",.text "b'",.text "c\"",.text "both'\"",.text "\n\u0000​"],.object [("k",.array [.integer (1),.integer (2)])]])]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.text "")]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.integer (0))]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.boolean false)]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.null)]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.boolean true)]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.integer (1))]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.text "invalid")]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.array [])]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "x"),("notes",.object [])]])])))
 IO.println (render (result (.object [("definitions",.array [.object [("text",.text "first"),("notes",.array [.text "a"])],.object [("text",.text "second"),("notes",.object [("z",.text "last"),("a",.text "start")])]])])))

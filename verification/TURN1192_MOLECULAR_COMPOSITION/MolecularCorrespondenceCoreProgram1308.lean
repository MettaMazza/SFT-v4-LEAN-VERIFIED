import SFT.Chemistry.MolecularCorrespondence
open SFT.Host.Canonical SFT.Chemistry.MolecularCorrespondence
open SFT.Physics.CapabilityValues (heldLabel)
def encode : Except String Value → Value
 | .ok value => .array [.text "ok",value]
 | .error error => .array [.text "error",.text error]
def run (family label lawFamily lawLabel : String) (rows : List (String × String)) : Except String Value := do
 let process ← construct (← heldLabel family label) rows (← heldLabel lawFamily lawLabel)
 branchwiseCertificate process
def main : IO Unit := do
 IO.println (render (.array [
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" []),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("a","a")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("a","b")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("a","b"),("b","a")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("b","c"),("a","d")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("","")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("a","b"),("a","c")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("a","b"),("c","b")]),
encode (run "molecular-carrier" "registered" "admitted-chemical-transition-law" "law" [("0","out0"),("1","out1"),("2","out2"),("3","out3"),("4","out4"),("5","out5")]),
encode (run "wrong" "x" "admitted-chemical-transition-law" "law" [("a","b")]),
encode (run "molecular-carrier" "x" "wrong" "law" [("a","b")]),
encode (run "molecular-carrier" "" "admitted-chemical-transition-law" "law" [("a","b")])]))

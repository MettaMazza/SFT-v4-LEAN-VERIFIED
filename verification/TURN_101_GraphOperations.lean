import SFT.Mathematics.GraphOperations
import SFT.Host.Canonical
open SFT.Mathematics.GraphOperations SFT.Host.Canonical

def texts (xs : List String) : Value := .array (xs.map Value.text)
def edgesValue (xs : List Edge) : Value := .array (xs.map (fun e => .array [.text e.1,.text e.2]))
def graphValue : Except String GeneratedGraph → Value
  | .error e => .object [("error",.text e)]
  | .ok g => .object [("ok",.array [texts g.nodes,edgesValue g.edges])]
def cutValue : Except String (List Edge) → Value
  | .error e => .object [("error",.text e)]
  | .ok es => .object [("ok",edgesValue es)]
def carriers : List (List String) := [[],["a"],["a","b"],["b","a"],["a","a"],["a","b","z"]]
def relations : List (List Edge) := [[],[("a","a")],[("a","b")],[("a","a"),("a","b")],[("b","a")],[("a","a"),("b","a")],[("a","b"),("b","a")],[("a","a"),("a","b"),("b","a")],[("b","b")],[("a","a"),("b","b")],[("a","b"),("b","b")],[("a","a"),("a","b"),("b","b")],[("b","a"),("b","b")],[("a","a"),("b","a"),("b","b")],[("a","b"),("b","a"),("b","b")],[("a","a"),("a","b"),("b","a"),("b","b")],[("a","a"),("a","a")],[("a","z")]]
def paths : List (List String) := [[],["a"],["b"],["z"],["a","a"],["a","b"],["a","z"],["b","a"],["b","b"],["b","z"],["z","a"],["z","b"],["z","z"],["a","a","a"],["a","a","b"],["a","a","z"],["a","b","a"],["a","b","b"],["a","b","z"],["a","z","a"],["a","z","b"],["a","z","z"],["b","a","a"],["b","a","b"],["b","a","z"],["b","b","a"],["b","b","b"],["b","b","z"],["b","z","a"],["b","z","b"],["b","z","z"],["z","a","a"],["z","a","b"],["z","a","z"],["z","b","a"],["z","b","b"],["z","b","z"],["z","z","a"],["z","z","b"],["z","z","z"]]
def flows : List (List (List String)) := [[],[[]],[["a"]],[["a","b"]],[[],[]],[[],["a"]],[[],["a","b"]],[["a"],[]],[["a"],["a"]],[["a"],["a","b"]],[["a","b"],[]],[["a","b"],["a"]],[["a","b"],["a","b"]]]
def main : IO Unit := do
  for nodes in carriers do
    for edges in relations do
      IO.println (render (graphValue (makeGraph nodes edges)))
      for path in paths do
        IO.println (render (.array [.boolean (pathIsValid ⟨nodes,edges⟩ path),edgesValue (adjacentPairs path),cutValue (crossingCut ⟨nodes,edges⟩ path)]))
  for incoming in flows do
    for outgoing in flows do
      IO.println (render (.boolean (internalBalance incoming outgoing)))

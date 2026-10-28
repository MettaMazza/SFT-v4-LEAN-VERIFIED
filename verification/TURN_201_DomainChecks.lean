import SFT.Computation.RecognitionDomain
open SFT.Host.Canonical SFT.Computation.RecognitionDomain
def enumerationValue (result : Except String (List (String × String))) : Value := match result with
 | .error e => .object [("error",.text e)]
 | .ok rows => .array (rows.map fun p => .array [.text p.1,.text p.2])
def complementValue (result : Except String String) : Value := match result with
 | .error e => .object [("error",.text e)]
 | .ok s => .text s
def main : IO Unit := do
  IO.println (render (.array [
enumerationValue (completeEnumeration []),
enumerationValue (completeEnumeration ["a"]),
enumerationValue (completeEnumeration ["a","b"]),
enumerationValue (completeEnumeration ["a","a"]),
enumerationValue (completeEnumeration ["a","b","a"]),
enumerationValue (completeEnumeration ["μ","empty-One"]),
enumerationValue (completeEnumeration ["0","1","2","3","4","5","6","7","8","9","10","11"]),
complementValue (selfNegatingBoundary "accept"),
complementValue (selfNegatingBoundary "reject"),
complementValue (selfNegatingBoundary "continue"),
complementValue (selfNegatingBoundary ""),
complementValue (selfNegatingBoundary "Accept"),
complementValue (selfNegatingBoundary "μ")]))

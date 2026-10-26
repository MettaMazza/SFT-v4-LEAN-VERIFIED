import SFT.Foundation.PrimitiveMapGrammar
import SFT.Host.Canonical
open SFT.Foundation.PrimitiveMapGrammar SFT.Foundation.PrimitiveMaps SFT.Host.Canonical

def main : IO Unit := do
  IO.println (render (.array (candidates.map fun c => .object [
    ("candidate_id",.text (candidateId c)),
    ("size",.integer (Int.ofNat (word c).length)),
    ("rank",.integer (Int.ofNat (rank c))),
    ("word",.array ((word c).map fun p => .text (primitiveName p))),
    ("exact_form",.text (exactForm c))])))

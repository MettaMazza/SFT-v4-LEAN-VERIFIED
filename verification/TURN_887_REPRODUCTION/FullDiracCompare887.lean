import SFT.Physics.FullDiracSquare
open SFT.Physics SFT.Host.Canonical FullDiracSquare
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def diff : Difference → Value
 | .empty => .array []
 | .left q => .array [.text "left",fraction q]
 | .right q => .array [.text "right",fraction q]
def main : IO Unit := do
 let r ← IO.ofExcept fullDiracSquare
 IO.println (render (.object [("components",.array (r.components.map fraction)),("direct_square",fraction r.directSquare),("held_equal_differences",.array (r.heldEqualDifferences.map diff)),("polarized_square",fraction r.polarizedSquare)]))
 for (a,b) in [(⟨1,2,by decide,by decide⟩,⟨1,3,by decide,by decide⟩),(⟨1,3,by decide,by decide⟩,⟨1,2,by decide,by decide⟩),(⟨1,3,by decide,by decide⟩,⟨1,3,by decide,by decide⟩)] do
  IO.println (render (diff (heldDifference a b)))

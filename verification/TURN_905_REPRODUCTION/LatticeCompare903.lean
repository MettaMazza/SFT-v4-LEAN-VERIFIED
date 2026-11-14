import SFT.Physics.LatticeCurvature
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String Rat) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok q => fraction q
def showCount (x : Except String Int) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok q => .integer q
def main : IO Unit := do
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,16,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨3,7,by decide,by decide⟩) (.fraction ⟨1,11,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨7,3,by decide,by decide⟩) (.fraction ⟨2,5,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨3,4,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨0,1,by decide,by decide⟩))))
 IO.println (render (showResult (LatticeCurvature.squareLatticeCurvature .nonFraction (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.integer 1) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.integer 2) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.integer 3) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.boolean true) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.boolean false) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.integer 0) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.integer 4) (.fraction ⟨1,8,by decide,by decide⟩))))
 IO.println (render (showCount (LatticeCurvature.latticeLaplacian (.integer (-1)) (.fraction ⟨1,8,by decide,by decide⟩))))

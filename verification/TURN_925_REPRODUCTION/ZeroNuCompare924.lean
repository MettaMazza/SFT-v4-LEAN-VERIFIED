import SFT.Physics.NeutrinolessBounds
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.NeutrinolessBounds
set_option maxRecDepth 20000
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def bracketValue (b : Bracket) : Value := .array [fraction b.1,fraction b.2]
def outcome (r : Except String Bracket) : Value := match r with
 | .error e => .text ("ValueError: " ++ e)
 | .ok b => bracketValue b
#eval do
 let p ← IO.ofExcept zeroNuNoncancellation
 let values : List SFT.Physics.FoldFirstReturn.Input := [.fraction ⟨1,32,by decide,by decide⟩,.fraction ⟨33,32,by decide,by decide⟩,.fraction ⟨3203,96,by decide,by decide⟩,.fraction ⟨1,1,by decide,by decide⟩,.fraction ⟨1,2,by decide,by decide⟩,.fraction ⟨1,4,by decide,by decide⟩,.fraction ⟨1,100,by decide,by decide⟩,.fraction ⟨1,4096,by decide,by decide⟩,.fraction ⟨4,1,by decide,by decide⟩,.fraction ⟨9,4,by decide,by decide⟩,.fraction ⟨100,3,by decide,by decide⟩,.fraction ⟨0,1,by decide,by decide⟩,.fraction ⟨-1,1,by decide,by decide⟩,.nonFraction]
 let halves : List (Except String Bracket) := [bisectSquare (⟨1,8,by decide,by decide⟩,⟨1,4,by decide,by decide⟩) ⟨1,32,by decide,by decide⟩,bisectSquare (⟨1,1,by decide,by decide⟩,⟨2,1,by decide,by decide⟩) ⟨33,32,by decide,by decide⟩,bisectSquare (⟨5,1,by decide,by decide⟩,⟨6,1,by decide,by decide⟩) ⟨3203,96,by decide,by decide⟩,bisectSquare (⟨1,2,by decide,by decide⟩,⟨1,1,by decide,by decide⟩) ⟨9,16,by decide,by decide⟩,bisectSquare (⟨-1,1,by decide,by decide⟩,⟨1,1,by decide,by decide⟩) ⟨0,1,by decide,by decide⟩]
 IO.println (render (.object [("result",.object [("positive_floor_coefficient",fraction p.positiveFloorCoefficient),("ceiling_coefficient",fraction p.ceilingCoefficient),("root_brackets",.array [bracketValue p.rootBrackets.1,bracketValue p.rootBrackets.2.1,bracketValue p.rootBrackets.2.2])]),("sqrt_cases",.array (values.map (fun v => outcome (sqrtBracket v)))),("bisect_cases",.array (halves.map outcome))]))

import SFT.Chemistry.DihedralTorsion
namespace SFT.Chemistry.MolecularIonization
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def orderedIonizationTake (higher lower : Height) : Except String Ratio :=
 match higher with
 | .emptyOne | .otherEmptyOne _ | .invalid => .error "ionization heights must be exact positive ratios"
 | .ratio h => match lower with
  | .emptyOne | .otherEmptyOne _ | .invalid => .error "ionization heights must be exact positive ratios"
  | .ratio l => match barrierTake (.ratio h) (.ratio l) with
   | .ok value => .ok value
   | .error _ => .error "ionization requires a strictly higher separated terminal state"
inductive SupportInput where
 | tuple (values : List Height)
 | other
def ratioLess (a b : Ratio) : Bool := a.numerator.value*b.denominator.value < b.numerator.value*a.denominator.value
-- Python min(key=fraction) retains the first member when exact values tie.
def leastTakeFrom (first : Ratio) : List Ratio → Ratio
 | [] => first
 | next::rest => leastTakeFrom (if ratioLess next first then next else first) rest
def leastAdiabaticTake (initial : Height) (terminals : SupportInput) : Except String Ratio := do
 let rows ← match terminals with
  | .other => throw "adiabatic support requires a nonempty finite generated terminal set"
  | .tuple rows => if rows.isEmpty then throw "adiabatic support requires a nonempty finite generated terminal set" else pure rows
 let takes ← rows.mapM fun terminal => orderedIonizationTake terminal initial
 match takes with
 | [] => throw "adiabatic support requires a nonempty finite generated terminal set"
 | first::rest => pure (leastTakeFrom first rest)
def verticalNotBelowAdiabatic (initial : Height) (terminals : SupportInput) (held : Height) : Except String Bool := do
 let included := match terminals with
  | .other => false
  | .tuple values => values.any (equalHeight held)
 if !included then throw "vertical terminal must belong to the generated ionic support"
 let adiabatic ← leastAdiabaticTake initial terminals
 let vertical ← orderedIonizationTake held initial
 pure (adiabatic.numerator.value*vertical.denominator.value ≤ vertical.numerator.value*adiabatic.denominator.value)
structure Carrier where
 species : HeldLabel
 initialState : HeldLabel
 initialConformation : HeldLabel
 ionicState : HeldLabel
 removed : HeldLabel
 orientation : HeldLabel
 path : HeldLabel
 condition : HeldLabel
def validateCarrier (c : Carrier) : Except String Carrier := do
 if !([(c.species,"molecular-species"),(c.initialState,"initial-molecular-state"),
  (c.initialConformation,"initial-molecular-conformation"),(c.ionicState,"resulting-ionic-state"),
  (c.removed,"removed-carrier"),(c.orientation,"held-removal-orientation"),
  (c.path,"ionization-path"),(c.condition,"measurement-condition")].all
   fun (value,family) => Text.equal value.family family) then
  throw "molecular ionization carrier erased a required held field"
 pure c
theorem orderedTakeExact (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 orderedIonizationTake (.ratio higher) (.ratio lower)=
 .ok (rawRatio (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered)) := by
 dsimp only [orderedIonizationTake]
 rw [barrierTakeExact higher lower ordered]
theorem terminalTakeMagnitude (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 ((fraction higher).numerator*(fraction lower).denominator-(fraction lower).numerator*(fraction higher).denominator)*
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).denominator=
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).numerator*
 ((fraction higher).denominator*(fraction lower).denominator) := barrierMagnitude higher lower ordered
def initial : Height := .ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩
def terminalEight : Height := .ratio ⟨⟨8,by decide⟩,⟨1,by decide⟩⟩
def terminalSix : Height := .ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩
def terminalSeven : Height := .ratio ⟨⟨7,by decide⟩,⟨1,by decide⟩⟩
def terminalNine : Height := .ratio ⟨⟨9,by decide⟩,⟨1,by decide⟩⟩
def terminals : SupportInput := .tuple [terminalEight,terminalSix,terminalSeven]
def ratioPair (r : Ratio) : Nat × Nat := (r.numerator.value,r.denominator.value)
theorem orderedTakeWitness : (orderedIonizationTake terminalEight initial).map ratioPair=.ok (5,1) := rfl
theorem leastWitness : (leastAdiabaticTake initial terminals).map ratioPair=.ok (3,1) := rfl
theorem verticalWitness : verticalNotBelowAdiabatic initial terminals terminalSeven=.ok true := rfl
theorem reverseWitness : orderedIonizationTake initial terminalEight=
 .error "ionization requires a strictly higher separated terminal state" := rfl
theorem absentVerticalWitness : verticalNotBelowAdiabatic initial terminals terminalNine=
 .error "vertical terminal must belong to the generated ionic support" := rfl
end SFT.Chemistry.MolecularIonization

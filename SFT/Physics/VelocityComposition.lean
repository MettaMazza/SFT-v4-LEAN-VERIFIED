import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.VelocityComposition
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Motion where
 | rest
 | speed (value : Rat)
inductive Held where
 | empty
 | part (value : Rat)
structure Pair where
 forward : Rat
 held : Held
def one : Rat := wholeRatio 1
def speed (value : Rat) : Except String Rat :=
 if !zero.blt value || one.blt value then .error "speed magnitude must be an exact positive part of the limiting One" else .ok value
def composeSameDirection : Motion → Motion → Except String Motion
 | .rest,right => .ok right
 | left,.rest => .ok left
 | .speed left,.speed right => do
   let u ← speed left
   let v ← speed right
   pure (.speed (← LeptonRatios.divide (add u v) (add one (multiply u v))))
def heldPair (value : Rat) : Except String Pair := do
 let u ← speed value
 let held := if u.num = u.den then Held.empty else Held.part (subtract one u)
 pure ⟨add one u,held⟩
def composeHeldPairs (left right : Rat) : Except String Pair := do
 let a ← heldPair left
 let b ← heldPair right
 let held := match a.held with
  | .empty => Held.empty
  | .part x => match b.held with
    | .empty => Held.empty
    | .part y => Held.part (multiply x y)
 pure ⟨multiply a.forward b.forward,held⟩
def recoverSpeed (pair : Pair) : Except String Rat :=
 match pair.held with
 | .empty => .ok one
 | .part held =>
   if !held.blt pair.forward then .error "held pair does not encode positive forward motion"
   else LeptonRatios.divide (subtract pair.forward held) (add pair.forward held)
structure BilinearCandidate where
 candidateId : String
 numeratorCross : Bool
 denominatorCross : Bool
 identityForcedTerms : List String
 limitAbsorbing : Bool
def bilinearCandidates : List BilinearCandidate :=
 [false,true].flatMap fun n => [false,true].map fun d =>
  ⟨SFT.Host.Text.join ["numerator-cross-",(if n then "present" else "absent"),"__denominator-cross-",(if d then "present" else "absent")],n,d,["left","right","denominator-One"],!n && d⟩
def candidateValue (left right : Rat) (numeratorCross denominatorCross : Bool) : Except String Rat := do
 let u ← speed left
 let v ← speed right
 let cross := multiply u v
 let numerator := if numeratorCross then add (add u v) cross else add u v
 let denominator := if denominatorCross then add one cross else one
 LeptonRatios.divide numerator denominator
def uniqueBilinearSurvivor : Except String BilinearCandidate :=
 match bilinearCandidates.filter BilinearCandidate.limitAbsorbing with
 | [] => .error "bilinear grammar did not force one velocity operation"
 | row :: tail => match tail with
   | [] => .ok row
   | _ :: _ => .error "bilinear grammar did not force one velocity operation"
def exactClosureGrid : List Rat :=
 [normalize 1 8 (by decide),normalize 1 4 (by decide),normalize 1 3 (by decide),normalize 1 2 (by decide),normalize 2 3 (by decide),normalize 3 4 (by decide),normalize 7 8 (by decide),one]
theorem typedLeftIdentity (m : Motion) : composeSameDirection .rest m = .ok m := rfl
theorem typedRightIdentity (m : Motion) : composeSameDirection m .rest = .ok m := by cases m <;> rfl
theorem bilinearCensusCount : bilinearCandidates.length = 4 := rfl
theorem bilinearUniqueCoordinates : (bilinearCandidates.filter BilinearCandidate.limitAbsorbing).map (fun c => (c.numeratorCross,c.denominatorCross)) = [(false,true)] := rfl
theorem bilinearLimitForcesCoordinates (n d : Bool) : (!n && d) = true → n = false ∧ d = true := by
 cases n <;> cases d <;> decide
def ratEqual (a b : Rat) : Bool := decide (a.num * b.den = b.num * a.den)
def motionEqual (x y : Except String Motion) : Bool :=
 match x with
 | .error _ => false
 | .ok a => match y with
   | .error _ => false
   | .ok b => match a with
     | .rest => match b with
       | .rest => true
       | .speed _ => false
     | .speed u => match b with
       | .rest => false
       | .speed v => ratEqual u v
def composeThreeLeft (u v w : Rat) : Except String Motion := do
 composeSameDirection (← composeSameDirection (.speed u) (.speed v)) (.speed w)
def composeThreeRight (u v w : Rat) : Except String Motion := do
 composeSameDirection (.speed u) (← composeSameDirection (.speed v) (.speed w))
structure Certificate where
 candidateCount : Nat
 survivor : String
 closure : Bool
 associativity : Bool
 pairEquivalence : Bool
 strictSublimit : Bool
 limitingSpeedAbsorbing : Bool
 typedRestIdentity : Bool
 lowSpeedDifferenceExact : Bool
def theoremCertificate : Except String Certificate := do
 let grid := exactClosureGrid
 let sub := grid.take (grid.length-1)
 let closure := grid.all fun u => grid.all fun v =>
  match composeSameDirection (.speed u) (.speed v) with
  | .error _ => false
  | .ok motion => match motion with
    | .rest => false
    | .speed x => zero.blt x && !one.blt x
 let associativity := grid.all fun u => grid.all fun v => grid.all fun w =>
  motionEqual (composeThreeLeft u v w) (composeThreeRight u v w)
 let pairEquivalence := grid.all fun u => grid.all fun v =>
  motionEqual ((composeHeldPairs u v >>= recoverSpeed).map Motion.speed) (composeSameDirection (.speed u) (.speed v))
 let strictSublimit := sub.all fun u => sub.all fun v =>
  match composeSameDirection (.speed u) (.speed v) with
  | .error _ => false
  | .ok motion => match motion with
    | .rest => false
    | .speed x => x.blt one
 let limiting := grid.all fun v => motionEqual (composeSameDirection (.speed one) (.speed v)) (.ok (.speed one))
 let rest := grid.all fun v => motionEqual (composeSameDirection .rest (.speed v)) (.ok (.speed v)) && motionEqual (composeSameDirection (.speed v) .rest) (.ok (.speed v))
 let difference := sub.all fun u => sub.all fun v =>
  match composeSameDirection (.speed u) (.speed v) with
  | .error _ => false
  | .ok motion => match motion with
    | .rest => false
    | .speed x => match LeptonRatios.divide (multiply (multiply u v) (add u v)) (add one (multiply u v)) with
      | .error _ => false
      | .ok y => ratEqual (subtract (add u v) x) y
 pure ⟨bilinearCandidates.length,(← uniqueBilinearSurvivor).candidateId,closure,associativity,pairEquivalence,strictSublimit,limiting,rest,difference⟩
end SFT.Physics.VelocityComposition

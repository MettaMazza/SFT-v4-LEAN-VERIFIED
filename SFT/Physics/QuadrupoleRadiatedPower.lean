import SFT.Physics.GravityWaveTrace
import SFT.Physics.GravitySelfSource
import SFT.Physics.StaticExteriorClockGeneral
namespace SFT.Physics.QuadrupoleRadiatedPower
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def positiveDifferenceRecord (values : List FoldFirstReturn.Input) : Except String (List Rat) := do
 if values.length<2 || !(values.all (fun x => match x with | .nonFraction => false | .fraction q => zero.blt q)) then throw "positive exact carrier sequence required"
 let xs := values.map (fun x => match x with | .nonFraction => zero | .fraction q => q)
 if xs.all (fun x => x==xs.headD zero) then pure [] else do
  let pairs := StaticExteriorClockCertificate.successivePairs xs
  if !(pairs.all (fun p => p.1.blt p.2)) then throw "difference opposition must retain positive orientation"
  pure (pairs.map (fun p => subtract p.2 p.1))
def differenceSteps : Nat → List Rat → Except String (List Rat)
 | 0,values => .ok values
 | n+1,values => if values.isEmpty then .ok [] else do
  let next ← positiveDifferenceRecord (values.map FoldFirstReturn.Input.fraction)
  differenceSteps n next
def generatedDifferenceRecord (values : List FoldFirstReturn.Input) (order : GeneratorOperations.CountInput) : Except String (List Rat) := do
 let order ← match order with
  | .boolean _ => .error "positive generated difference order required"
  | .integer (.negSucc _) => .error "positive generated difference order required"
  | .integer (.ofNat 0) => .error "positive generated difference order required"
  | .integer (.ofNat (n+1)) => .ok (n+1)
 if values.isEmpty then pure [] else do
  let first ← positiveDifferenceRecord values
  differenceSteps (order-1) first
def generatedQuadrupoleTrace (input : FoldFirstReturn.Input := .fraction (normalize 1 1 (by decide)))
 (length : GeneratorOperations.CountInput := .integer 8) : Except String (List Rat) := do
 let amplitude ← match input with
  | .nonFraction => .error "positive exact quadrupole amplitude required"
  | .fraction q => if !zero.blt q then .error "positive exact quadrupole amplitude required" else .ok q
 let length ← match length with
  | .boolean _ => .error "quadrupole trace requires at least four positive ticks"
  | .integer (.negSucc _) => .error "quadrupole trace requires at least four positive ticks"
  | .integer (.ofNat 0) => .error "quadrupole trace requires at least four positive ticks"
  | .integer (.ofNat 1) => .error "quadrupole trace requires at least four positive ticks"
  | .integer (.ofNat 2) => .error "quadrupole trace requires at least four positive ticks"
  | .integer (.ofNat 3) => .error "quadrupole trace requires at least four positive ticks"
  | .integer (.ofNat (n+4)) => .ok (n+4)
 pure ((List.range length).map (fun tick => multiply amplitude (wholeRatio ((tick+1)^3))))
def staticQuadrupoleTrace (length : GeneratorOperations.CountInput := .integer 8) : Except String (List Rat) := do
 let length ← match length with
  | .boolean _ => .error "static trace requires at least four positive ticks"
  | .integer (.negSucc _) => .error "static trace requires at least four positive ticks"
  | .integer (.ofNat 0) => .error "static trace requires at least four positive ticks"
  | .integer (.ofNat 1) => .error "static trace requires at least four positive ticks"
  | .integer (.ofNat 2) => .error "static trace requires at least four positive ticks"
  | .integer (.ofNat 3) => .error "static trace requires at least four positive ticks"
  | .integer (.ofNat (n+4)) => .ok (n+4)
 pure (List.replicate length (normalize 1 1 (by decide)))
def quadrupolePowerRecord (values : List FoldFirstReturn.Input) (coupling : Rat := normalize 1 2 (by decide)) : Except String (Option Rat) := do
 if !(coupling==normalize 1 2 (by decide)) then throw "radiated-power channel requires the admitted binary half-One coupling"
 let third ← generatedDifferenceRecord values (.integer 3)
 match third with
 | [] => pure none
 | first::rest =>
  if !(rest.all (fun q => q==first)) || !zero.blt first then throw "registered power witness requires one retained constant third-rate carrier"
  pure (some (multiply (multiply coupling first) first))
structure CubicIdentity where
 index : Nat
 left : Nat
 right : Nat
 identityHolds : Bool
 successorLeftIncrement : Nat
 successorRightIncrement : Nat
 generatedSuccessorIncrement : Nat
 successorPreservesIdentity : Bool
def cubicOppositionIdentity (input : GeneratorOperations.CountInput) : Except String CubicIdentity := do
 let k ← match input with
  | .boolean _ => .error "positive identity index required"
  | .integer (.negSucc _) => .error "positive identity index required"
  | .integer (.ofNat 0) => .error "positive identity index required"
  | .integer (.ofNat (n+1)) => .ok (n+1)
 let left := (k+3)^3+3*(k+1)^3
 let right := 3*(k+2)^3+k^3+6
 let inc := 12*k^2+48*k+58
 let nextLeft := (k+4)^3+3*(k+2)^3
 let nextRight := 3*(k+3)^3+(k+1)^3+6
 pure ⟨k,left,right,left==right,nextLeft-left,nextRight-right,inc,(nextLeft-left==nextRight-right) && (nextRight-right==inc)⟩
theorem originalThirdRate :
 (do let xs ← generatedQuadrupoleTrace; generatedDifferenceRecord (xs.map FoldFirstReturn.Input.fraction) (.integer 3))=
 .ok (List.replicate 5 (normalize 6 1 (by decide))) := rfl
theorem originalPower :
 (do let xs ← generatedQuadrupoleTrace; quadrupolePowerRecord (xs.map FoldFirstReturn.Input.fraction))=.ok (some (normalize 18 1 (by decide))) := rfl
theorem originalStaticSilence :
 (do let xs ← staticQuadrupoleTrace; quadrupolePowerRecord (xs.map FoldFirstReturn.Input.fraction))=.ok none := rfl
end SFT.Physics.QuadrupoleRadiatedPower

import SFT.Chemistry.AnalyticalAccuracy
import SFT.Foundation.ExactCast
namespace SFT.Chemistry.XrayDiffraction
open SFT.Host SFT.Physics.CapabilityValues
open AnalyticalAccuracy (PositiveRatio rational ratio)
open IsotopeExchange (sameLabel)
inductive ExactSupport where
 | emptyOne
 | positive (value : PositiveRatio)
structure Coordinate where
 carrier : HeldLabel
 coordinateKind : HeldLabel
 coordinate : ExactSupport
 responseKind : HeldLabel
 response : ExactSupport
 side : HeldLabel
 condition : HeldLabel
 position : PositiveCount

def sameSupport : ExactSupport → ExactSupport → Bool
 | .emptyOne,.emptyOne => true
 | .emptyOne,.positive _ => false
 | .positive _,.emptyOne => false
 | .positive a,.positive b => rational a == rational b

def construct (carrier coordinateKind : HeldLabel) (coordinate : ExactSupport)
 (responseKind : HeldLabel) (response : ExactSupport) (side condition : HeldLabel)
 (position : PositiveCount) : Except String Coordinate := do
 if !(Text.equal carrier.family "analytical-carrier" && Text.equal coordinateKind.family "analytical-coordinate-kind" &&
  Text.equal responseKind.family "analytical-response-kind" && Text.equal side.family "held-side" && Text.equal condition.family "analytical-condition") then
  throw "complete held analytical coordinate identity required"
 if !(["higher","lower","preserving","alternating","coincident","unresolved"].any (Text.equal side.label)) then
  throw "analytical held side was not generated"
 if Text.equal side.label "coincident" && !sameSupport coordinate .emptyOne then
  throw "coincident coordinate requires structural EmptyOne"
 return ⟨carrier,coordinateKind,coordinate,responseKind,response,side,condition,position⟩

def exactSideRelation (source terminal : PositiveRatio) : HeldLabel × ExactSupport :=
 let a := source.1.value*terminal.2.value
 let b := terminal.1.value*source.2.value
 if h : a=b then (⟨"held-side","coincident",rfl,rfl⟩,.emptyOne) else
 let denominator : PositiveCount := ⟨source.2.value*terminal.2.value,Nat.mul_pos source.2.positive terminal.2.positive⟩
 if g : a<b then
  (⟨"held-side","higher",rfl,rfl⟩,.positive (⟨b-a,SFT.Foundation.ExactCast.subtractPositive b a g⟩,denominator))
 else
  (⟨"held-side","lower",rfl,rfl⟩,.positive (⟨a-b,SFT.Foundation.ExactCast.subtractPositive a b (Nat.lt_of_le_of_ne (Nat.le_of_not_lt g) (Ne.symm h))⟩,denominator))

def sameKey (a b : Coordinate) : Bool := sameLabel a.coordinateKind b.coordinateKind &&
 sameSupport a.coordinate b.coordinate && sameLabel a.responseKind b.responseKind && sameLabel a.side b.side
def distinctKeys (rows : List Coordinate) : Bool :=
 (rows.foldl (fun acc row => if acc.any (sameKey row) then acc else acc++[row]) []).length == rows.length
def oneBoundary (rows : List Coordinate) : Bool := match rows with
 | [] => false
 | row::rest => rest.all (fun other => sameLabel row.carrier other.carrier && sameLabel row.condition other.condition)
def completeVector (rows : List Coordinate) : Except String (List Coordinate) :=
 if rows.isEmpty || (rows.map (fun row => row.position.value)) != ((List.range rows.length).map (fun i => i+1)) then
  .error "analytical vector must be complete and ordered"
 else if !oneBoundary rows then .error "analytical vector crossed its retained carrier/condition boundary"
 else if !distinctKeys rows then .error "analytical vector duplicated a coordinate-response identity"
 else .ok rows

theorem acceptedVectorExact (rows out : List Coordinate) (accepted : completeVector rows = .ok out) : out=rows := by
 unfold completeVector at accepted
 cases h0 : (rows.isEmpty || (rows.map (fun row => row.position.value)) != ((List.range rows.length).map (fun i => i+1))) with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  cases h1 : !oneBoundary rows with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   cases h2 : !distinctKeys rows with
   | true => rw [h2] at accepted; cases accepted
   | false => rw [h2] at accepted; exact (Except.ok.inj accepted).symm

def sameCoordinate (a b : Coordinate) : Bool := sameLabel a.carrier b.carrier &&
 sameLabel a.coordinateKind b.coordinateKind && sameSupport a.coordinate b.coordinate &&
 sameLabel a.responseKind b.responseKind && sameSupport a.response b.response &&
 sameLabel a.side b.side && sameLabel a.condition b.condition && a.position.value==b.position.value
def sameVector : List Coordinate → List Coordinate → Bool
 | [],[] => true
 | a::as,b::bs => sameCoordinate a b && sameVector as bs
 | [],_::_ | _::_,[] => false
def originalRows : Except String (List Coordinate) := do
 let carrier ← heldLabel "analytical-carrier" "carrier-016"
 let condition ← heldLabel "analytical-condition" "condition-016"
 let (side,coordinate) := exactSideRelation (← ratio 3 1) (← ratio 5 1)
 let a ← construct carrier (← heldLabel "analytical-coordinate-kind" "coordinate-a") coordinate
  (← heldLabel "analytical-response-kind" "response-a") (.positive (← ratio 2 3)) side condition (← count 1)
 let b ← construct carrier (← heldLabel "analytical-coordinate-kind" "coordinate-b") (.positive (← ratio 7 2))
  (← heldLabel "analytical-response-kind" "response-b") .emptyOne (← heldLabel "held-side" "unresolved") condition (← count 2)
 completeVector [a,b]
def witness (index : Nat) : Bool := match originalRows with
 | .error _ => false
 | .ok [] => false
 | .ok (a::rest) => match rest with
  | [] => false
  | b::tail =>
   let rows := a::b::tail
   match index with
   | 0 => rows.all (fun row => sameLabel row.carrier a.carrier)
   | 1 => !sameSupport a.coordinate .emptyOne
   | 2 => match a.response with | .emptyOne => false | .positive q => rational q == (2,3)
   | 3 => Text.equal a.side.label "higher"
   | 4 => sameSupport b.response .emptyOne
   | 5 => rows.all (fun row => sameLabel row.condition a.condition)
   | 6 => rows.length==2
   | _ => match completeVector rows with | .error _ => false | .ok out => sameVector out rows
theorem carrierWitness : witness 0 = true := rfl
theorem probeWitness : witness 1 = true := rfl
theorem supportWitness : witness 2 = true := rfl
theorem coordinateWitness : witness 3 = true := rfl
theorem responseWitness : witness 4 = true := rfl
theorem structureWitness : witness 5 = true := rfl
theorem custodyWitness : witness 6 = true := rfl
theorem extensionWitness : witness 7 = true := rfl
end SFT.Chemistry.XrayDiffraction

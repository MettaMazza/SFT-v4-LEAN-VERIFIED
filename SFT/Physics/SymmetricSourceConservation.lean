import SFT.Physics.GravitonPolarization
import SFT.Physics.LatticeCurvatureProofs
import SFT.Host.Text
namespace SFT.Physics.SymmetricSourceConservation
open SFT.Host
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Coordinate where
 | time | axisOne | axisTwo | axisThree
 deriving BEq,DecidableEq,Repr
def coordinates : List Coordinate := [.time,.axisOne,.axisTwo,.axisThree]
def coordinateName : Coordinate → String
 | .time => "time" | .axisOne => "axis-one" | .axisTwo => "axis-two" | .axisThree => "axis-three"
def coordinateOrder : Coordinate → Nat
 | .time => 1 | .axisOne => 2 | .axisTwo => 3 | .axisThree => 4
def coordinate (s : String) : Option Coordinate := coordinates.find? (fun c => Text.equal (coordinateName c) s)
abbrev Slot := Coordinate × Coordinate
def symmetricSlot (first second : String) : Except String Slot := do
 let a ← (coordinate first).elim (.error "unknown generated coordinate") Except.ok
 let b ← (coordinate second).elim (.error "unknown generated coordinate") Except.ok
 pure (if coordinateOrder a≤coordinateOrder b then (a,b) else (b,a))
def symmetricSlots : List Slot := coordinates.flatMap (fun a => (coordinates.filter (fun b => coordinateOrder a≤coordinateOrder b)).map (fun b => (a,b)))
def sourceComponentKind (slot : List String) : String :=
 if slot.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==["time","time"].map (fun s => s.toUTF8.data.toList.map UInt8.toNat) then "energy"
 else if slot.any (fun s => Text.equal s "time") then "momentum" else "stress"
def sourceComponentLedger : List (String × List Slot) :=
 ["energy","momentum","stress"].map (fun kind => (kind,symmetricSlots.filter (fun p => Text.equal (sourceComponentKind [coordinateName p.1,coordinateName p.2]) kind)))
def insertCoordinate (x : Coordinate) : List Coordinate → List Coordinate
 | [] => [x]
 | y::ys => if coordinateOrder x≤coordinateOrder y then x::y::ys else y::insertCoordinate x ys
def canonicalDerivatives : List Coordinate → List Coordinate
 | [] => []
 | x::xs => insertCoordinate x (canonicalDerivatives xs)
abbrev Term := List Coordinate × Slot
def derivativeTerm (derivatives : List String) (first second : String) : Except String Term := do
 if derivatives.isEmpty then throw "generated derivatives required"
 let ds ← derivatives.mapM (fun s => (coordinate s).elim (.error "generated derivatives required") Except.ok)
 pure (canonicalDerivatives ds,← symmetricSlot first second)
def term (ds : List Coordinate) (first second : Coordinate) : Term :=
 (canonicalDerivatives ds,if coordinateOrder first≤coordinateOrder second then (first,second) else (second,first))
def carriedTerms (direction : Coordinate) : List Term :=
 coordinates.flatMap (fun first => coordinates.flatMap (fun contracted =>
  [term [first,contracted,first] contracted direction,term [first,contracted,direction] contracted first])) ++
 coordinates.flatMap (fun contracted => coordinates.map (fun trace => term [direction,contracted,contracted] trace trace))
def opposedTerms (direction : Coordinate) : List Term :=
 coordinates.flatMap (fun first =>
  coordinates.map (fun contracted => term [first,contracted,contracted] first direction) ++
  coordinates.map (fun trace => term [first,first,direction] trace trace)) ++
 coordinates.flatMap (fun contracted => coordinates.map (fun trace => term [direction,contracted,trace] contracted trace))
def increment (key : Term) : List (Term × Nat) → List (Term × Nat)
 | [] => [(key,1)]
 | (t,n)::rest => if t==key then (t,n+1)::rest else (t,n)::increment key rest
def counter (terms : List Term) : List (Term × Nat) := terms.foldl (fun acc t => increment t acc) []
def countAt (rows : List (Term × Nat)) (key : Term) : Nat :=
 match rows.find? (fun p => p.1==key) with | none => 0 | some p => p.2
def countersEqual (a b : List (Term × Nat)) : Bool :=
 a.all (fun p => p.2==countAt b p.1) && b.all (fun p => p.2==countAt a p.1)
def divergenceLedgers (direction : String) : Except String (List (Term × Nat) × List (Term × Nat)) := do
 let d ← (coordinate direction).elim (.error "generated source direction required") Except.ok
 pure (counter (carriedTerms d),counter (opposedTerms d))
theorem originalSlotCount : symmetricSlots.length=10 := rfl
theorem originalSourcePartition : (sourceComponentLedger.map (fun p => p.2.length))=[1,3,6] := rfl
theorem originalFourBalances : coordinates.all (fun d => countersEqual (counter (carriedTerms d)) (counter (opposedTerms d)))=true := rfl
theorem originalFortyEightTerms : coordinates.all (fun d => (carriedTerms d).length==48 && (opposedTerms d).length==48)=true := rfl
end SFT.Physics.SymmetricSourceConservation

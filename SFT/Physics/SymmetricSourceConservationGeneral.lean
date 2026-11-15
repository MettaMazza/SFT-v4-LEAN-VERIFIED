import SFT.Physics.SymmetricSourceConservation
namespace SFT.Physics.SymmetricSourceConservationGeneral
open SymmetricSourceConservation
set_option maxHeartbeats 100000000
structure Position where
 time : Nat
 axisOne : Nat
 axisTwo : Nat
 axisThree : Nat
 deriving BEq,DecidableEq,Repr
def shift (c : Coordinate) (p : Position) : Position := match c with
 | .time => {p with time:=p.time+1}
 | .axisOne => {p with axisOne:=p.axisOne+1}
 | .axisTwo => {p with axisTwo:=p.axisTwo+1}
 | .axisThree => {p with axisThree:=p.axisThree+1}
theorem generatedShiftsCommute (a b : Coordinate) (p : Position) : shift a (shift b p)=shift b (shift a p) := by cases a <;> cases b <;> rfl
def derivativeWord : List Coordinate → Position → Position
 | [],p => p
 | x::xs,p => shift x (derivativeWord xs p)
private theorem insertActs (x : Coordinate) (xs : List Coordinate) (p : Position) :
 derivativeWord (insertCoordinate x xs) p=shift x (derivativeWord xs p) := by
 induction xs with
 | nil => rfl
 | cons y ys ih =>
  unfold insertCoordinate
  split
  · rfl
  · change shift y (derivativeWord (insertCoordinate x ys) p)=shift x (shift y (derivativeWord ys p))
    rw [ih,generatedShiftsCommute]
theorem canonicalWordPreservesShifts (xs : List Coordinate) (p : Position) :
 derivativeWord (canonicalDerivatives xs) p=derivativeWord xs p := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change derivativeWord (insertCoordinate x (canonicalDerivatives xs)) p=shift x (derivativeWord xs p)
  rw [insertActs,ih]
def appendLayer (layer : Position) (p : Position) : Position :=
 ⟨p.time+layer.time,p.axisOne+layer.axisOne,p.axisTwo+layer.axisTwo,p.axisThree+layer.axisThree⟩
theorem everyAddedLayerPreservesCommutation (a b : Coordinate) (layer p : Position) :
 shift a (shift b (appendLayer layer p))=shift b (shift a (appendLayer layer p)) := generatedShiftsCommute a b _
theorem everyFiniteWordPreservesCanonicalAction (word : List Coordinate) (layer p : Position) :
 derivativeWord (canonicalDerivatives word) (appendLayer layer p)=derivativeWord word (appendLayer layer p) := canonicalWordPreservesShifts word _
end SFT.Physics.SymmetricSourceConservationGeneral

import SFT.Physics.CompositeConfiningGrammar
namespace SFT.Physics.CompositeConfiningAcceptanceCount
open SFT.Physics.CompositeConfiningGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Constructor-level evaluation of exactly the already-proved source criteria. -/
def acceptedCoordinates (c : Candidate) : Bool :=
 (match c.scope with | .admitted => true | .rejected => false) &&
 (match c.support with | .admitted => true | .rejected => false) &&
 (match c.modes with | .admitted => true | .rejected => false) &&
 (match c.action with | .admitted => true | .rejected => false) &&
 (match c.confinement with | .admitted => true | .rejected => false) &&
 (match c.orbits with | .admitted => true | .rejected => false) &&
 (match c.antipodes with | .admitted => true | .rejected => false) &&
 (match c.pair_count with | .admitted => true | .rejected => false) &&
 (match c.coupling with | .admitted => true | .rejected => false) &&
 (match c.comparison with | .admitted => true | .rejected => false) &&
 (match c.extension with | .admitted => true | .rejected => false)
theorem coordinatesUnique (c : Candidate) : acceptedCoordinates c=true ↔ c=survivor := by
 constructor
 · intro h
   cases c with
   | mk scope support modes action confinement orbits antipodes pair_count coupling comparison extension =>
     unfold acceptedCoordinates at h
     cases scope <;> try cases h
     cases support <;> try cases h
     cases modes <;> try cases h
     cases action <;> try cases h
     cases confinement <;> try cases h
     cases orbits <;> try cases h
     cases antipodes <;> try cases h
     cases pair_count <;> try cases h
     cases coupling <;> try cases h
     cases comparison <;> try cases h
     cases extension <;> try cases h
     rfl
 · intro h
   cases h
   rfl
theorem sourceEqualsCoordinates (c : Candidate) : survives c=acceptedCoordinates c := by
 cases hs : survives c with
 | true =>
  have same := (uniqueSurvivor c).mp hs
  exact ((coordinatesUnique c).mpr same).symm
 | false =>
  cases ha : acceptedCoordinates c with
  | false => rfl
  | true =>
   have yes := (uniqueSurvivor c).mpr ((coordinatesUnique c).mp ha)
   rw [hs] at yes
   cases yes
theorem sourceFilter (xs : List Candidate) : xs.filter survives=xs.filter acceptedCoordinates := by
 induction xs with
 | nil => rfl
 | cons c cs ih =>
  change (match survives c with | true => c::cs.filter survives | false => cs.filter survives) =
   (match acceptedCoordinates c with | true => c::cs.filter acceptedCoordinates | false => cs.filter acceptedCoordinates)
  rw [sourceEqualsCoordinates c]
  cases acceptedCoordinates c with
  | false => exact ih
  | true => exact congrArg (List.cons c) ih
theorem fullSourceAcceptedCount : (candidates.filter acceptedCoordinates).length=1 := by decide +kernel
end SFT.Physics.CompositeConfiningAcceptanceCount

import SFT.Physics.CosmicMeasuredRoots
namespace SFT.Physics.CosmicMeasuredResidual
open LeptonIntervals CosmicMeasuredRoots VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Observation where
 redshift : Rat
 observed : Rat
 uncertainty : Rat
structure Row where
 position : Nat
 redshift : Rat
 observed : Rat
 uncertainty : Rat
 e2 : Rat
 root : Bracket

def prepareRows : List Observation → Nat → Except String (List Row)
 | [],_ => .ok []
 | row::rest,position => do
  let e2 ← CosmicComponentTransport.lateSquaredExpansion (add (wholeRatio 1) row.redshift)
  let bracket ← initialRootBracket e2
  let tail ← prepareRows rest (position+1)
  .ok (⟨position,row.redshift,row.observed,row.uncertainty,e2,bracket⟩::tail)

def refineRows (rows : List Row) : List Row :=
 rows.map (fun r => {r with root := refineRootBracket r.e2 r.root})

structure Certificate where
 rowCount : Nat
 refinements : Nat
 meanLower : Rat
 meanUpper : Rat
 passed : Bool
 allRowsContributedOnce : Bool
 rootEnclosuresExact : Bool

def attempt (h0 h0Uncertainty : Rat) (refinements : Nat) (rows : List Row) :
 Except String (Option Certificate) := do
 let bounds ← rows.mapM (fun row => residualBounds row.observed row.uncertainty h0 h0Uncertainty row.e2 row.root)
 let totalLower := bounds.foldl (fun total b => add total b.1) zero
 let totalUpper := bounds.foldl (fun total b => add total b.2) zero
 let meanLower ← LeptonRatios.divide totalLower (wholeRatio bounds.length)
 let meanUpper ← LeptonRatios.divide totalUpper (wholeRatio bounds.length)
 let result := fun passed => some (⟨rows.length,refinements,meanLower,meanUpper,passed,
  rows.length == 32 && rows.map Row.position == (List.range 32).map (fun n => n+1),
  rows.all (fun row => !(row.e2.blt (square row.root.1)) && !((square row.root.2).blt row.e2))⟩ : Certificate)
 if meanUpper.blt (wholeRatio 1) then .ok (result true)
 else if !meanLower.blt (wholeRatio 1) then .ok (result false)
 else .ok none

-- Every finite execution of the source while-loop, with its unchanged stop tests.
-- The execution length is not a coefficient or a refinement precision in the law.
inductive SourceRun (h0 h0Uncertainty : Rat) : Nat → List Row → Certificate → Prop where
 | stop (n : Nat) (rows : List Row) (result : Certificate)
   (decision : attempt h0 h0Uncertainty n rows = .ok (some result)) :
   SourceRun h0 h0Uncertainty n rows result
 | next (n : Nat) (rows : List Row) (result : Certificate)
   (undecided : attempt h0 h0Uncertainty n rows = .ok none)
   (later : SourceRun h0 h0Uncertainty (n+1) (refineRows rows) result) :
   SourceRun h0 h0Uncertainty n rows result

def runWithin (h0 h0Uncertainty : Rat) : Nat → Nat → List Row → Except String (Option Certificate)
 | 0,_,_ => .ok none
 | fuel+1,n,rows => do
  let result ← attempt h0 h0Uncertainty n rows
  match result with
  | some c => .ok (some c)
  | none => runWithin h0 h0Uncertainty fuel (n+1) (refineRows rows)

theorem sourceRunCorrespondence (h0 h0Uncertainty : Rat) (fuel n : Nat) (rows : List Row) (result : Certificate)
 (h : runWithin h0 h0Uncertainty fuel n rows = .ok (some result)) :
 SourceRun h0 h0Uncertainty n rows result := by
 induction fuel generalizing n rows with
 | zero => cases h
 | succ fuel ih =>
  unfold runWithin at h
  cases step : attempt h0 h0Uncertainty n rows with
  | error e => rw [step] at h; cases h
  | ok value =>
   rw [step] at h
   cases value with
   | none => exact .next n rows result step (ih (n+1) (refineRows rows) h)
   | some c =>
    have eq := Option.some.inj (Except.ok.inj h)
    cases eq
    exact .stop n rows result step

#print axioms prepareRows
#print axioms refineRows
#print axioms attempt
#print axioms runWithin
#print axioms sourceRunCorrespondence
end SFT.Physics.CosmicMeasuredResidual

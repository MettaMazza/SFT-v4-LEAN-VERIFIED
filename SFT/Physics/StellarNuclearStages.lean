import SFT.Physics.StellarResponses
import SFT.Physics.VacuumSpectrum
namespace SFT.Physics.StellarNuclearStages
open SFT.Host.Canonical GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def positiveStageCount : CountInput → Except String Nat
 | .integer (.ofNat (n+1)) => .ok (n+1)
 | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error "a stellar nuclear stage count must be a positive whole"
def chargedBoundaryPaths (stage : CountInput) : Except String Nat := do
 let n ← positiveStageCount stage
 pure (n*(n+1))
structure StageRow where
 stage : Nat
 paths : Nat
 firstStage : Bool
 strictSuccessor : Bool
def stageRows (count : Nat) : List StageRow :=
 (List.range count).map (fun i=>⟨i+1,(i+1)*(i+2),i==0,i==0 || i*(i+1)<(i+1)*(i+2)⟩)
def stellarStageChain (count : CountInput) : Except String (List StageRow) := do pure (stageRows (← positiveStageCount count))
def nestedStageSupport (count : CountInput) : Except String (List Nat) := do pure (((List.range (← positiveStageCount count)).map (fun i=>i+1)).reverse)
def rowValue (row : StageRow) : Value := .object [("stage",.integer (.ofNat row.stage)),("charged_boundary_paths",.integer (.ofNat row.paths)),("first_stage",.boolean row.firstStage),("strict_successor",.boolean row.strictSuccessor)]
def adjacentDescending : List Nat → Bool
 | []=>true
 | [_]=>true
 | a::b::rest=>(b<a) && adjacentDescending (b::rest)
def stellarChainCertificate (count : CountInput) : Except String Value := do
 let rows ← stellarStageChain count
 let widths ← nestedStageSupport count
 let n ← positiveStageCount count
 let strict := (List.range n).all (fun i=>(i+1)*(i+2)<(i+2)*(i+3))
 pure (.object [("rows",.array (rows.map rowValue)),("nested_widths",.array (widths.map (fun n=>.integer (.ofNat n)))),("all_access_carriers_strict",.boolean (rows.all StageRow.strictSuccessor)),("all_nested_widths_positive",.boolean (widths.all (fun n=>1≤n))),("strictly_nested",.boolean (adjacentDescending widths)),("depth_independent_successor",.boolean strict)])
theorem everyPositiveStageSuccessor (n : Nat) : (n+1)*(n+2)<(n+2)*(n+3) := by
 have first := Nat.mul_lt_mul_of_pos_right (Nat.lt_succ_self (n+1)) (Nat.zero_lt_succ (n+1))
 exact Nat.lt_trans first (Nat.mul_lt_mul_of_pos_left (Nat.lt_succ_self (n+2)) (Nat.zero_lt_succ (n+1)))
theorem completeStageCount (n : Nat) : (stageRows n).length=n := by
 exact (SFT.Foundation.CommonRefinement.mapLength _ _).trans ((VacuumSpectrum.rangeLoopLength n []).trans (Nat.add_zero n))
#print axioms stellarStageChain
#print axioms stellarChainCertificate
#print axioms everyPositiveStageSuccessor
#print axioms completeStageCount
end SFT.Physics.StellarNuclearStages

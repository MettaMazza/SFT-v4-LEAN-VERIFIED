import SFT.Physics.NuclearBindingTail
namespace SFT.Physics.NuclearBindingCensus
open LeptonIntervals VacuumLedgerProofs GeneratorOperations NuclearBindingCurve NuclearBindingRadius NuclearBindingTail
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- One iteration of possible_mass_maximizers; none means the original loop continues.
def candidateStep (mass : CountInput) (refinements : Nat) : Except String (Option (List Nat)) := do
 let bounds ← continuousVertexEnclosure mass (.integer (.ofNat refinements))
 let quarter ← NuclearResidualForce.residualBoundarySupport
 if !(subtract bounds.2 bounds.1).blt quarter then pure none else
  let binary ← AlphaCovers.binaryCount
  let generator ← FoldFirstReturn.generatorPeriod
  match mass with
  | .boolean _ => throw "mass support begins with the binary composite"
  | .integer a =>
    let lower := bounds.1.num / Int.ofNat bounds.1.den
    let upper := bounds.2.num / Int.ofNat bounds.2.den
    let start := max 1 (lower - Int.ofNat binary)
    let stop := min (a-1) (upper + Int.ofNat generator)
    let rows := (List.range (stop-start+1).toNat).map (fun n => start.toNat+n)
    if rows.isEmpty then throw "concave candidate enclosure is empty"
    pure (some rows)
inductive CandidateRun (mass : CountInput) : Nat → List Nat → Prop where
 | stop (n rows) : candidateStep mass n = .ok (some rows) → CandidateRun mass n rows
 | next (n rows) : candidateStep mass n = .ok none → CandidateRun mass (n+1) rows → CandidateRun mass n rows
-- This evaluator exposes a proof-work bound; CandidateRun certifies every
-- successful output against the source's uncapped refinement loop.
def candidatesWithin (mass : CountInput) : Nat → Nat → Except String (Option (List Nat))
 | 0,_ => .ok none
 | fuel+1,n => do
   let step ← candidateStep mass n
   match step with
   | some rows => pure (some rows)
   | none => candidatesWithin mass fuel (n+1)
theorem candidatesCorrespond (mass : CountInput) (fuel n : Nat) (rows : List Nat)
 (h : candidatesWithin mass fuel n = .ok (some rows)) : CandidateRun mass n rows := by
 induction fuel generalizing n with
 | zero => cases h
 | succ fuel ih =>
   unfold candidatesWithin at h
   cases hs : candidateStep mass n with
   | error message => rw [hs] at h; cases h
   | ok step =>
     cases step with
     | none =>
       rw [hs] at h
       exact .next n rows hs (ih (n+1) h)
     | some values =>
       rw [hs] at h
       have same := Option.some.inj (Except.ok.inj h)
       cases same
       exact .stop n rows hs
-- All actual finite census masses, in the source's ascending range order.
def finitePeakCandidatesWithin (fuel : Nat) : Except String (Option (List (Nat × Nat))) := do
 let binary ← AlphaCovers.binaryCount
 let cutoff ← tailCutoffMass
 let masses := (List.range (cutoff-binary)).map (fun n => binary+n)
 let rec gather : List Nat → Except String (Option (List (Nat × Nat)))
  | [] => pure (some [])
  | a::rest => do
    let row ← candidatesWithin (.integer (.ofNat a)) fuel 1
    match row with
    | none => pure none
    | some charges =>
      let later ← gather rest
      match later with
      | none => pure none
      | some rows => pure (some ((charges.map (fun z => (a,z))) ++ rows))
 gather masses
end SFT.Physics.NuclearBindingCensus

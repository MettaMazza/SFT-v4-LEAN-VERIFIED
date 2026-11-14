import SFT.Physics.NuclearBindingCensus
namespace SFT.Physics.NuclearBindingPeak
open LeptonIntervals VacuumLedgerProofs GeneratorOperations NuclearBindingCurve NuclearBindingRadius NuclearBindingTail NuclearBindingCensus
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Scored where
 mass : Nat
 charge : Nat
 lower : Rat
 upper : Rat
def scoreCandidates (refinements : Nat) (candidates : List (Nat × Nat)) : Except String (List Scored) :=
 candidates.mapM fun (a,z) => do
  let bounds ← bindingScoreEnclosure (.integer (.ofNat a)) (.integer (.ofNat z)) (.integer (.ofNat refinements))
  pure ⟨a,z,bounds.1,bounds.2⟩
-- Strict replacement preserves Python max's first-on-equal ordering.
def bestLower (first : Scored) (rest : List Scored) : Scored :=
 rest.foldl (fun best row => if best.lower.blt row.lower then row else best) first
def sameCoordinate (a b : Scored) : Bool := a.mass == b.mass && a.charge == b.charge
def largestUpper (first : Scored) (rest : List Scored) : Rat :=
 rest.foldl (fun best row => if best.blt row.upper then row.upper else best) first.upper
structure Separation where
 winner : Scored
 rivalUpper : Rat
 refinements : Nat
def separationStep (candidates : List (Nat × Nat)) (refinements : Nat) : Except String (Option Separation) := do
 let scores ← scoreCandidates refinements candidates
 match scores with
 | [] => throw "max() arg is an empty sequence"
 | first::rest =>
   let winner := bestLower first rest
   let rivals := scores.filter (fun row => !sameCoordinate row winner)
   match rivals with
   | [] => throw "max() arg is an empty sequence"
   | first::rest =>
     let upper := largestUpper first rest
     if upper.blt winner.lower then pure (some ⟨winner,upper,refinements⟩)
     else pure none
inductive SeparationRun (candidates : List (Nat × Nat)) : Nat → Separation → Prop where
 | stop (n result) : separationStep candidates n = .ok (some result) → SeparationRun candidates n result
 | next (n result) : separationStep candidates n = .ok none → SeparationRun candidates (n+n) result → SeparationRun candidates n result
def separateWithin (candidates : List (Nat × Nat)) : Nat → Nat → Except String (Option Separation)
 | 0,_ => .ok none
 | fuel+1,n => do
   let step ← separationStep candidates n
   match step with
   | some result => pure (some result)
   | none => separateWithin candidates fuel (n+n)
theorem separationCorrespond (candidates : List (Nat × Nat)) (fuel n : Nat) (result : Separation)
 (h : separateWithin candidates fuel n = .ok (some result)) : SeparationRun candidates n result := by
 induction fuel generalizing n with
 | zero => cases h
 | succ fuel ih =>
   unfold separateWithin at h
   cases hs : separationStep candidates n with
   | error message => rw [hs] at h; cases h
   | ok step =>
     cases step with
     | none => rw [hs] at h; exact .next n result hs (ih (n+n) h)
     | some value =>
       rw [hs] at h
       have same := Option.some.inj (Except.ok.inj h)
       cases same
       exact .stop n result hs
structure Certificate where
 massNumber : Nat
 chargeCount : Nat
 neutronCount : Nat
 scoreLower : Rat
 scoreUpper : Rat
 rivalUpper : Rat
 refinementsUntilSeparation : Nat
 finiteMassCount : Nat
 possibleMaximizerCount : Nat
 tailCutoffMass : Nat
 tailClosed : Bool
def completeCertificate (candidates : List (Nat × Nat)) (result : Separation) : Except String Certificate := do
 let tail ← tailUpperBounds
 if !tail.coulombTailSuccessorMonotone then throw "high-charge tail did not close under positive succession"
 let winner := result.winner
 if !tail.lowChargeUpper.blt winner.lower || !tail.highChargeUpper.blt winner.lower then
  throw "forced tail bound did not remain below the finite winner"
 let neutrons ← NuclearBindingCurve.neutronCount (.integer (.ofNat winner.mass)) (.integer (.ofNat winner.charge))
 let cutoff ← NuclearBindingTail.tailCutoffMass
 let binary ← AlphaCovers.binaryCount
 pure ⟨winner.mass,winner.charge,neutrons,winner.lower,winner.upper,result.rivalUpper,result.refinements,cutoff-binary,candidates.length,cutoff,true⟩
def bindingPeakWithin (censusFuel separationFuel : Nat) : Except String (Option Certificate) := do
 let census ← finitePeakCandidatesWithin censusFuel
 match census with
 | none => pure none
 | some candidates =>
   let separation ← separateWithin candidates separationFuel 1
   match separation with
   | none => pure none
   | some result => return some (← completeCertificate candidates result)
end SFT.Physics.NuclearBindingPeak

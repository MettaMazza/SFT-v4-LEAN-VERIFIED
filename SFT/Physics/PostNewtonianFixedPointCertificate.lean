import SFT.Physics.PostNewtonianFixedPoint
namespace SFT.Physics.PostNewtonianFixedPointCertificate
open PostNewtonianFixedPoint LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 structural : Structural
 fixedCandidates : List Rat
 admissibleFixedPoints : List Rat
 values : List Rat
 errors : List Rat
 corrections : List Rat
 errorFactors : List Rat
 correctionFactors : List Rat
 valuesIncreaseBelowFixed : Bool
 errorsStrictlyShrink : Bool
 correctionsStrictlyShrink : Bool
 allFactorsBelowQuarter : Bool
 generalErrorIdentity : String
 generalCorrectionIdentity : String
def successors : List Rat → List (Rat × Rat)
 | [] => []
 | [_] => []
 | x::y::xs => (x,y)::successors (y::xs)
def convergenceCertificate (depth : GeneratorOperations.CountInput := .integer 8) : Except String Certificate := do
 let values ← iterate depth
 let structural ← structuralValues
 let fixed := structural.fixed
 let errors := values.map (subtract fixed)
 let corrections := (successors values).map (fun p => subtract p.2 p.1)
 let errorFactors ← (successors errors).mapM (fun p => LeptonRatios.divide p.2 p.1)
 let correctionFactors ← (successors corrections).mapM (fun p => LeptonRatios.divide p.2 p.1)
 pure ⟨structural,← fixedPointCandidates,← admissibleFixedPoints,values,errors,corrections,errorFactors,correctionFactors,
  (successors values).all (fun p => p.1.blt p.2 && p.2.blt fixed),
  (successors errors).all (fun p => p.2.blt p.1),
  (successors corrections).all (fun p => p.2.blt p.1),
  (errorFactors++correctionFactors).all (fun f => f.blt (normalize 1 4 (by decide))),
  "e-next=e-times-(fixed-plus-current)-over-two","c-next=c-times-(next-plus-current)-over-two"⟩
def certificateFacts : Except String Bool := do
 let c ← convergenceCertificate
 pure (c.admissibleFixedPoints==[normalize 1 4 (by decide)] && c.valuesIncreaseBelowFixed && c.errorsStrictlyShrink && c.correctionsStrictlyShrink && c.allFactorsBelowQuarter)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.PostNewtonianFixedPointCertificate

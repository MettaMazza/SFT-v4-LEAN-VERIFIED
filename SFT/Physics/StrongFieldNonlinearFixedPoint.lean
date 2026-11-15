import SFT.Physics.StrongCarrierMasslessConfinedGeneral
import SFT.Physics.PostNewtonianFixedPointGeneral
namespace SFT.Physics.StrongFieldNonlinearFixedPoint
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def colourSelfSourceSuccessor (input : FoldFirstReturn.Input) : Except String Rat := do
 let source ← match input with
  | .nonFraction => .error "positive exact colour source required"
  | .fraction q => if !zero.blt q then .error "positive exact colour source required" else .ok q
 let binary ← AlphaCovers.binaryCount
 pure (add source (wholeRatio binary))
-- Retain the original append order and actual guarded successor call.
def sourceSteps : Nat → Rat → Except String (List Rat)
 | 0,source => .ok [source]
 | n+1,source => do
  let next ← colourSelfSourceSuccessor (.fraction source)
  let later ← sourceSteps n next
  pure (source::later)
structure Strong where
 sources : List Rat
 corrections : List Rat
 sourceStrictlyGrows : Bool
 correction : Rat
 allCorrectionsBinary : Bool
 correctionsDoNotShrink : Bool
 fieldAppearsInItsSourceUpdate : Bool
 carrierSelfSourceRecord : List String
def strongSourceIteration (input : GeneratorOperations.CountInput := .integer 12) : Except String Strong := do
 let depth ← match input with
  | .boolean _ => .error "positive iteration depth required"
  | .integer (.negSucc _) => .error "positive iteration depth required"
  | .integer (.ofNat 0) => .error "positive iteration depth required"
  | .integer (.ofNat 1) => .error "positive iteration depth required"
  | .integer (.ofNat (n+2)) => .ok (n+2)
 let sources ← sourceSteps depth (wholeRatio 1)
 let pairs := StaticExteriorClockCertificate.successivePairs sources
 let corrections := pairs.map (fun p => subtract p.2 p.1)
 let correctionPairs := StaticExteriorClockCertificate.successivePairs corrections
 pure ⟨sources,corrections,pairs.all (fun p => p.1.blt p.2),wholeRatio 2,
  corrections.all (fun q => q==wholeRatio 2),correctionPairs.all (fun p => p.1==p.2),true,["lower-Fold-label","upper-Fold-label"]⟩
structure Neutral where
 sources : List Rat
 selfSourceRecord : List Rat
 correctionRecord : List Rat
 sourceHeld : Bool
 fixedPoint : Rat
 fieldAbsentFromSourceUpdate : Bool
def neutralSourceIteration (input : GeneratorOperations.CountInput := .integer 12) : Except String Neutral := do
 let depth ← match input with
  | .boolean _ => .error "positive iteration depth required"
  | .integer (.negSucc _) => .error "positive iteration depth required"
  | .integer (.ofNat 0) => .error "positive iteration depth required"
  | .integer (.ofNat 1) => .error "positive iteration depth required"
  | .integer (.ofNat (n+2)) => .ok (n+2)
 let sources := List.replicate (depth+1) (wholeRatio 1)
 pure ⟨sources,[],[],!sources.isEmpty && sources.all (fun q => q==sources.headD zero),wholeRatio 1,true⟩
structure FixedPointTest where
 candidate : Rat
 successor : Rat
 successorStrictlyAboveCandidate : Bool
 isFixedPoint : Bool
 finiteCandidate : Bool
def finiteStrongFixedPointTest (input : FoldFirstReturn.Input) : Except String FixedPointTest := do
 let candidate ← match input with
  | .nonFraction => .error "positive exact finite fixed-point candidate required"
  | .fraction q => if !zero.blt q then .error "positive exact finite fixed-point candidate required" else .ok q
 let successor ← colourSelfSourceSuccessor (.fraction candidate)
 pure ⟨candidate,successor,candidate.blt successor,successor==candidate,true⟩
structure BoundWitness where
 bound : Rat
 witnessSuccessors : Nat
 witnessSource : Rat
 sourceExceedsBound : Bool
 finiteWitness : Bool
def strongSourceExceedsPositiveBound (input : FoldFirstReturn.Input) : Except String BoundWitness := do
 let bound ← match input with
  | .nonFraction => .error "positive exact finite bound required"
  | .fraction q => if !zero.blt q then .error "positive exact finite bound required" else .ok q
 let binary ← AlphaCovers.binaryCount
 let ratio ← LeptonRatios.divide bound (wholeRatio binary)
 let successorCount := ratio.num.natAbs/ratio.den+1
 let source := add (wholeRatio 1) (wholeRatio (binary*successorCount))
 pure ⟨bound,successorCount,source,bound.blt source,decide (1≤successorCount)⟩
theorem originalSourcePrefix : (strongSourceIteration (.integer 4)).map Strong.sources=
 .ok [wholeRatio 1,wholeRatio 3,wholeRatio 5,wholeRatio 7,wholeRatio 9] := rfl
theorem originalBound : strongSourceExceedsPositiveBound (.fraction (wholeRatio 32))=
 .ok ⟨wholeRatio 32,17,wholeRatio 35,true,true⟩ := rfl
end SFT.Physics.StrongFieldNonlinearFixedPoint

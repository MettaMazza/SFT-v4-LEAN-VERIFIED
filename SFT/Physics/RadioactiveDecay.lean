import SFT.Physics.NuclearResidualForceProofs
namespace SFT.Physics.RadioactiveDecay
open GeneratorOperations LeptonIntervals VacuumLedgerProofs
structure PrimitiveTransition where
 name : String
 supportRelation : String
 chargeRelation : String
 recurrenceRelation : String
def release : PrimitiveTransition := ⟨"boundary-release-or-decomposition","released-to-named-output-support","retained-across-complete-products","product-recurrences-close"⟩
def conversion : PrimitiveTransition := ⟨"held-label-conversion","constituent-count-retained","charge-label-converted-with-lepton-records","daughter-recurrence-closes"⟩
def deexcitation : PrimitiveTransition := ⟨"internal-level-deexcitation","constituent-count-retained","charge-label-retained","lower-recurrence-plus-radiative-record"⟩
def primitiveTransitionClasses : List PrimitiveTransition := [release,conversion,deexcitation]
def classifyPrimitiveTransition (releasesSupport convertsChargeLabel lowersRecurrence : Bool) : Except String PrimitiveTransition :=
 if releasesSupport then .ok release else if convertsChargeLabel then .ok conversion
 else if lowersRecurrence then .ok deexcitation
 else .error "an identity or unrecorded disappearance is not radioactive decay"
structure AlphaRepresentative where
 clusterMassCount : Nat
 clusterChargeCount : Nat
 primitiveClass : String
def alphaRepresentative : Except String AlphaRepresentative := do
 let fibre ← AlphaCovers.binaryCount
 let mass ← AlphaCovers.positivePower (.integer (.ofNat fibre)) (.integer (.ofNat fibre))
 let transition ← classifyPrimitiveTransition true false false
 pure ⟨mass,fibre,transition.name⟩
structure BetaRepresentative where
 heldChargeOrientations : Nat
 leptonRecordCount : Nat
 primitiveClass : String
def betaRepresentative : Except String BetaRepresentative := do
 let transition ← classifyPrimitiveTransition false true false
 let binary ← AlphaCovers.binaryCount
 pure ⟨binary,binary,transition.name⟩
structure GammaRepresentative where
 levelRelationCount : Nat
 radiativeRecordCount : Nat
 primitiveClass : String
def gammaRepresentative : Except String GammaRepresentative := do
 let transition ← classifyPrimitiveTransition false false true
 let binary ← AlphaCovers.binaryCount
 pure ⟨binary,1,transition.name⟩
def compositeTransitionTrace (names : List String) : Except String (List String) := do
 if names.isEmpty then throw "a composite decay trace requires positive transition support"
 if names.any (fun name => !(primitiveTransitionClasses.any (fun row => row.name == name))) then
  throw "composite decay contains an ungenerated primitive"
 pure names
def positiveCount (message : String) : CountInput → Except String Nat
 | .boolean _ => .error message
 | .integer (.negSucc _) => .error message
 | .integer (.ofNat 0) => .error message
 | .integer (.ofNat (n+1)) => .ok (n+1)
def survivalPart (count : CountInput) : Except String Rat := do
 let k ← positiveCount "survival count must be a positive exact count" count
 let binary ← AlphaCovers.binaryCount
 let paths ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat k))
 LeptonRatios.divide (wholeRatio 1) (wholeRatio paths)
def releasedPart (count : CountInput) : Except String Rat := do
 let survival ← survivalPart count
 RunningConvergence.positiveTake (wholeRatio 1) survival
def survivalTrace (length : CountInput) : Except String (List Rat) := do
 let n ← positiveCount "survival trace requires positive length" length
 (List.range n).mapM (fun rank => survivalPart (.integer (.ofNat (rank+1))))
structure Transport where
 halfLifeCount : Nat
 elapsedTime : Rat
 survivalPart : Rat
 releasedPart : Rat
def transportHalfLife (time : FoldFirstReturn.Input) (count : CountInput) : Except String Transport := do
 let time ← match time with
  | .nonFraction => .error "a dimensional half-life must be exact and positive"
  | .fraction t => if zero.blt t then .ok t else .error "a dimensional half-life must be exact and positive"
 let k ← positiveCount "half-life transport count must be positive" count
 let survival ← survivalPart count
 let released ← releasedPart count
 pure ⟨k,multiply time (wholeRatio k),survival,released⟩
structure Partition where
 completePathCount : Nat
 retainedPathCount : Nat
 releasedPathCount : Int
 retainedShare : Rat
def deterministicHalvingPartition (depth : CountInput) : Except String Partition := do
 let n ← positiveCount "path depth must be positive" depth
 let binary ← AlphaCovers.binaryCount
 let complete ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (n+1)))
 let retained ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat n))
 let released ← RunningConvergence.positiveTake (wholeRatio complete) (wholeRatio retained)
 let share ← LeptonRatios.divide (wholeRatio retained) (wholeRatio complete)
 pure ⟨complete,retained,released.num,share⟩
theorem releaseClassification (charge recurrence : Bool) : classifyPrimitiveTransition true charge recurrence = .ok release := rfl
theorem conversionClassification (recurrence : Bool) : classifyPrimitiveTransition false true recurrence = .ok conversion := rfl
theorem deexcitationClassification : classifyPrimitiveTransition false false true = .ok deexcitation := rfl
theorem identityRejected : classifyPrimitiveTransition false false false = .error "an identity or unrecorded disappearance is not radioactive decay" := rfl
theorem completeClassification (support charge recurrence : Bool) (result : PrimitiveTransition)
 (h : classifyPrimitiveTransition support charge recurrence = .ok result) : result ∈ primitiveTransitionClasses := by
 cases support <;> cases charge <;> cases recurrence <;> cases h
 all_goals first | exact .head _ | exact .tail _ (.head _) | exact .tail _ (.tail _ (.head _))
theorem originalAlpha : alphaRepresentative = .ok ⟨4,2,release.name⟩ := rfl
theorem originalBeta : betaRepresentative = .ok ⟨2,2,conversion.name⟩ := rfl
theorem originalGamma : gammaRepresentative = .ok ⟨2,1,deexcitation.name⟩ := rfl
end SFT.Physics.RadioactiveDecay

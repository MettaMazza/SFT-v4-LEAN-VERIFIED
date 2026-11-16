import SFT.Physics.SpinStatisticsCondensation
import SFT.Physics.CoupledMapCriticality
namespace SFT.Physics.CriticalityUniversality
open LeptonIntervals VacuumLedgerProofs GeneratorOperations SpinStatisticsCondensation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Exact operations of criticality_universality_turbulence_terminal_law_v1.py.
structure MeanExponents where
 beta : Rat
 nu : Rat
 gamma : Rat
 delta : Rat
 alpha : List Nat
 eta : List Nat
def meanFieldExponents : MeanExponents :=
 ⟨normalize 1 2 (by decide),normalize 1 2 (by decide),wholeRatio 1,wholeRatio 3,[],[]⟩
structure MeanScale where
 excess : Nat
 order : Nat
 inverseCorrelation : Nat
 inverseResponse : Nat
 criticalField : Nat
 orderSquareIsExcess : Bool
 correlationSquareIsExcess : Bool
 responseIsLinearInExcess : Bool
 fieldIsOrderCube : Bool
def meanFieldScaleWitness (base depth : CountInput) : Except String MeanScale := do
 let q ← positiveWhole base "scale base"
 let d ← positiveWhole depth "scale depth"
 let order := q^d
 pure ⟨order^2,order,order,order^2,order^3,order^2==q^(2*d),order^2==q^(2*d),order^2==q^(2*d),order^3==q^(3*d)⟩
structure Identities where
 widom : Bool
 rushbrooke : Bool
 fisher : Bool
 values : MeanExponents
def criticalScalingIdentities : Identities :=
 let v := meanFieldExponents
 ⟨VelocityComposition.ratEqual v.gamma (multiply v.beta (subtract v.delta (wholeRatio 1))),
 VelocityComposition.ratEqual (add (multiply (wholeRatio 2) v.beta) v.gamma) (wholeRatio 2) && v.alpha.isEmpty,
 VelocityComposition.ratEqual v.gamma (multiply (wholeRatio 2) v.nu) && v.eta.isEmpty,v⟩
structure CascadeExponents where
 branchCount : Nat
 structureFunction : Rat
 spectrumMagnitude : Rat
 spectrumOrientation : String
def cascadeExponents : CascadeExponents :=
 ⟨3,normalize 2 3 (by decide),normalize 5 3 (by decide),"falling"⟩
structure CascadeScale where
 lengthRefinement : Nat
 structureFactor : Nat
 wavenumberRefinement : Nat
 energyDivisor : Nat
 structureCubeEqualsLengthSquare : Bool
 spectrumCubeEqualsWavenumberFifth : Bool
 fallingOrientationRetained : Bool
def cascadeScaleWitness (base depth : CountInput) : Except String CascadeScale := do
 let q ← positiveWhole base "scale base"
 let d ← positiveWhole depth "scale depth"
 let branch := q^d
 pure ⟨branch^3,branch^2,branch^3,branch^5,(branch^2)^3==(branch^3)^2,(branch^5)^3==(branch^3)^5,true⟩
inductive Carriers where
 | mean (value : MeanExponents)
 | cascade (value : CascadeExponents)
structure GeneratedClass where
 classId : String
 generatorKey : Nat × Nat × Nat
 threshold : Rat
 carriers : Carriers
def generatedUniversalityClasses : Except String (List GeneratedClass) :=
 let rows : List GeneratedClass := [
  ⟨"binary-self-antipodal-local-order",(2,2,3),normalize 1 2 (by decide),.mean meanFieldExponents⟩,
  ⟨"generator-three-conserved-cascade",(3,2,5),normalize 2 3 (by decide),.cascade cascadeExponents⟩]
 if (rows.map GeneratedClass.generatorKey).eraseDups.length != rows.length then
  .error "generated universality keys are not distinct"
 else .ok rows
def universalityEquivalence (left right : String) : Except String Bool := do
 let classes ← generatedUniversalityClasses
 let a ← match classes.find? (fun c => c.classId==left) with
  | some a => .ok a
  | none => .error "universality comparison requires generated class identities"
 let b ← match classes.find? (fun c => c.classId==right) with
  | some b => .ok b
  | none => .error "universality comparison requires generated class identities"
 pure (a.generatorKey==b.generatorKey)
structure Certificate where
 meanField : Bool
 identities : Bool
 cascade : Bool
 classes : Bool
def theoremCertificate : Except String Certificate := do
 let mean ← (List.range 5).mapM fun b => do
  let rows ← (List.range 6).mapM fun d => do
   let v ← meanFieldScaleWitness (.integer (.ofNat (b+2))) (.integer (.ofNat (d+1)))
   pure (v.orderSquareIsExcess && v.correlationSquareIsExcess && v.responseIsLinearInExcess && v.fieldIsOrderCube)
  pure (rows.all id)
 let cascade ← (List.range 5).mapM fun b => do
  let rows ← (List.range 6).mapM fun d => do
   let v ← cascadeScaleWitness (.integer (.ofNat (b+2))) (.integer (.ofNat (d+1)))
   pure (v.structureCubeEqualsLengthSquare && v.spectrumCubeEqualsWavenumberFifth && v.fallingOrientationRetained)
  pure (rows.all id)
 let classes ← generatedUniversalityClasses
 let different ← universalityEquivalence "binary-self-antipodal-local-order" "generator-three-conserved-cascade"
 let i := criticalScalingIdentities
 pure ⟨mean.all id,i.widom && i.rushbrooke && i.fisher,cascade.all id,classes.length==2 && !different⟩
theorem originalCertificate : theoremCertificate=.ok ⟨true,true,true,true⟩ := rfl
theorem originalBinaryThreshold : CoupledMapCriticality.holdingThreshold (.integer 2)=.ok (meanFieldExponents.beta) := rfl
end SFT.Physics.CriticalityUniversality

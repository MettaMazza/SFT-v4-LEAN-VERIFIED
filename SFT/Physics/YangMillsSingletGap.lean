import SFT.Physics.InteractionUnification
import SFT.Physics.StrongCarrierMasslessConfinedGeneral
namespace SFT.Physics.YangMillsSingletGap
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := wholeRatio 1
def foldPart : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "Fold action requires one positive exact part of the One"
 | .fraction q => if !zero.blt q || one.blt q then
   .error "Fold action requires one positive exact part of the One"
  else .ok (InteractionUnification.foldPart q)
structure Partition where
 coupling : Rat
 gap : Rat
 complete : Bool
 gapToCoupling : Bool
 couplingToGap : Bool
 firstReturnPeriod : Nat
def strongGapPartition : Except String Partition := do
 let table ← InteractionUnification.baseSectorTable (.integer 3)
 let gapFold ← foldPart (.fraction table.massShortfall)
 let couplingFold ← foldPart (.fraction table.coupling)
 pure ⟨table.coupling,table.massShortfall,equalRat (add table.coupling table.massShortfall) one,
 equalRat gapFold table.coupling,equalRat couplingFold table.massShortfall,2⟩
structure SingletSupport where
 leastSingletConstituents : Nat
 completeFibreConstituents : Nat
 singletSupports : List Nat
 leastSingletIsNonemptyComposite : Bool
 isolatedColourObservationRecord : List Rat
 vacuumExcitationRecord : List Rat
def physicalSingletSupport : Except String SingletSupport := do
 let pair ← SectorInventory.antipodalPairCount (.integer 3)
 let fibre ← SectorInventory.singletConstituentCount (.integer 3)
 pure ⟨pair,fibre,[pair,fibre],decide (1<pair),[],[]⟩
structure Row where
 depth : Nat
 normalizedSingletGap : Rat
 confinementWork : Rat
 physicalSupport : Nat
def gapRows (depth : Nat) (partition : Partition) (singlet : SingletSupport) : List Row :=
 (List.range depth).map (fun i => ⟨i+1,partition.gap,multiply partition.coupling (wholeRatio (i+1)),singlet.leastSingletConstituents⟩)
def distinctGaps : List Row → Bool
 | [] => false
 | row::rows => rows.all (fun r => equalRat r.normalizedSingletGap row.normalizedSingletGap)
structure Trace where
 rows : List Row
 gap : Rat
 coupling : Rat
 allGapsPositive : Bool
 gapDepthInvariant : Bool
 workPositiveAndIncreasing : Bool
 leastPhysicalStateIsSinglet : Bool
 isolatedColourObservationRecord : List Rat
 vacuumExcitationRecord : List Rat
 localCarrierMassLabel : List Rat
 localCarrierOneSpeed : Bool
 localCarrierConfined : Bool
 localMasslessnessNotPhysicalGaplessness : Bool
 completedInfinityUsed : Bool
 fittedOrMeasuredValueUsed : Bool
def singletGapTrace (input : CountInput := .integer 16) : Except String Trace := do
 let depth ← match input with
  | .boolean _ => .error "positive finite depth required"
  | .integer (.negSucc _) => .error "positive finite depth required"
  | .integer (.ofNat 0) => .error "positive finite depth required"
  | .integer (.ofNat (n+1)) => .ok (n+1)
 let partition ← strongGapPartition
 let singlet ← physicalSingletSupport
 let tube ← StrongCarrierMasslessConfined.confiningTubeTrace (.integer (.ofNat (max 2 depth)))
 let localTrace ← StrongCarrierMasslessConfined.masslessCausalTrace (.integer (.ofNat (max 2 depth)))
 let rows := gapRows depth partition singlet
 pure ⟨rows,partition.gap,partition.coupling,rows.all (fun r => zero.blt r.normalizedSingletGap),
 distinctGaps rows,rows.all (fun r => zero.blt r.confinementWork) &&
 (StaticExteriorClockCertificate.successivePairs rows).all (fun p => p.1.confinementWork.blt p.2.confinementWork),
 singlet.leastSingletIsNonemptyComposite,singlet.isolatedColourObservationRecord,singlet.vacuumExcitationRecord,
 localTrace.massLabel,localTrace.allIncrementsOne,tube.isolatedColourCarrierRecord.isEmpty && tube.workStrictlyIncreases,
 localTrace.massLabel.isEmpty && singlet.leastSingletIsNonemptyComposite && zero.blt partition.gap,false,false⟩
theorem originalPartition : strongGapPartition=.ok ⟨normalize 2 3 (by decide),normalize 1 3 (by decide),true,true,true,2⟩ := rfl
theorem originalSupport : physicalSingletSupport=.ok ⟨2,3,[2,3],true,[],[]⟩ := rfl
def originalRow (k : Nat) : Row :=
 ⟨k+1,normalize 1 3 (by decide),multiply (normalize 2 3 (by decide)) (wholeRatio (k+1)),2⟩
theorem originalEveryRows (n : Nat) :
 (singletGapTrace (.integer (.ofNat (n+1)))).map Trace.rows=.ok ((List.range (n+1)).map originalRow) := by
 cases n with
 | zero => rfl
 | succ n =>
  unfold singletGapTrace
  dsimp only [Bind.bind,Except.bind]
  rw [Nat.max_eq_right (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le n)))]
  rfl
theorem originalRowGapPositive (k : Nat) : zero.blt (originalRow k).normalizedSingletGap=true := rfl
theorem originalRowGapInvariant (k : Nat) :
 (originalRow (k+1)).normalizedSingletGap=(originalRow k).normalizedSingletGap := rfl
theorem originalRowSupport (k : Nat) : (originalRow k).physicalSupport=2 := rfl
theorem originalRowWorkPositive (k : Nat) : zero.blt (originalRow k).confinementWork=true := by
 change zero.blt (multiply (normalize 2 3 (by decide)) (wholeRatio (k+1)))=true
 rw [StrongCarrierMasslessConfinedGeneral.originalWorkRepresentation]
 exact VacuumScaleProofs.positiveNormalized _ _ (Nat.mul_pos (by decide) (Nat.zero_lt_succ _)) (by decide)
theorem originalRowWorkSuccessor (k : Nat) :
 (originalRow (k+1)).confinementWork=add (originalRow k).confinementWork (normalize 2 3 (by decide)) :=
 StrongCarrierMasslessConfinedGeneral.originalConfinementSuccessor k
theorem originalRowWorkIncreases (k : Nat) :
 (originalRow k).confinementWork.blt (originalRow (k+1)).confinementWork=true :=
 StrongCarrierMasslessConfinedGeneral.originalWorkStrictlyIncreases k
theorem originalEveryEmptyBoundary (n : Nat) :
 (singletGapTrace (.integer (.ofNat (n+1)))).map (fun t =>
 (t.isolatedColourObservationRecord,t.vacuumExcitationRecord,t.localCarrierMassLabel,t.leastPhysicalStateIsSinglet,
 t.localMasslessnessNotPhysicalGaplessness,t.completedInfinityUsed,t.fittedOrMeasuredValueUsed))=
 .ok ([],[],[],true,true,false,false) := by
 cases n with
 | zero => rfl
 | succ n =>
  unfold singletGapTrace
  dsimp only [Bind.bind,Except.bind]
  rw [Nat.max_eq_right (Nat.succ_le_succ (Nat.succ_le_succ (Nat.zero_le n)))]
  rfl
end SFT.Physics.YangMillsSingletGap

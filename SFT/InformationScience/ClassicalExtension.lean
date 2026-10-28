import SFT.InformationScience.ClassicalClosure
import SFT.InformationScience.EntropyExtension
namespace SFT.InformationScience.ClassicalExtension
open ClassicalSupport ClassicalLedger ClassicalWhole ClassicalClosure
open SFT.Mathematics.ProbabilityObservations

theorem singletonValid (state label : String) : validateProbability [state] [(state,label)] = .ok [(state,label)] :=
  (probabilityMeaning _ _ _).mpr ((MutualObservation.validationMeaning _ _ _).mp
    (MutualObservation.validationFromPartition _ _ (EntropyExtension.singletonValid state label)))

theorem singletonClassical (state : String) : classicalState [state] state = .ok ⟨state,[state]⟩ :=
  (classicalMeaning _ _ _).mpr ⟨rfl,List.Mem.head [],rfl⟩

theorem singletonLedger (state label : String) :
    ∃ rows, probabilityLedger [state] [(state,label)] = .ok rows ∧
      rows.map (fun row => (row.observedLabel,row.microstates)) = [(label,[state])] ∧ probabilityWhole rows = true := by
  have valid := singletonValid state label
  obtain ⟨original,ho⟩ := admittedLedgerExists _ _ valid
  have out := probabilityOutput _ _ _ valid ho
  refine ⟨original.map probabilityRow,out,?_,probabilityExactWhole _ _ _ valid out⟩
  rw [probabilityProjection,EntropyLedger.entropyProvenance _ _ _ ho,EntropyExtension.singletonClasses]

theorem validSuccessor (support : List String) (observation : Observation) (fresh value : String)
    (valid : validateProbability support observation = .ok observation) (new : ¬ fresh ∈ support) :
    validateProbability (support ++ [fresh]) (observation ++ [(fresh,value)]) = .ok (observation ++ [(fresh,value)]) := by
  have prior := (MutualObservation.validationMeaning _ _ _).mpr ((probabilityMeaning _ _ _).mp valid)
  have extended := EntropyExtension.validSuccessor support observation fresh value (MutualObservation.partitionValidity _ _ _ prior) new
  exact (probabilityMeaning _ _ _).mpr ((MutualObservation.validationMeaning _ _ _).mp
    (MutualObservation.validationFromPartition _ _ extended))

theorem changedClass (support : List String) (observation : Observation) (fresh value : String)
    (new : ¬ fresh ∈ support) :
    fibre (support ++ [fresh]) (observation ++ [(fresh,value)]) value = fibre support observation value ++ [fresh] :=
  EntropyExtension.changedClass _ _ _ _ new

theorem otherClass (support : List String) (observation : Observation) (fresh value label : String)
    (new : ¬ fresh ∈ support) (different : value ≠ label) :
    fibre (support ++ [fresh]) (observation ++ [(fresh,value)]) label = fibre support observation label :=
  EntropyExtension.otherClass _ _ _ _ _ new different

theorem successorLedgerWhole (support : List String) (observation : Observation) (fresh value : String)
    (valid : validateProbability support observation = .ok observation) (new : ¬ fresh ∈ support) :
    ∃ rows, probabilityLedger (support ++ [fresh]) (observation ++ [(fresh,value)]) = .ok rows ∧ probabilityWhole rows = true := by
  have extended := validSuccessor support observation fresh value valid new
  obtain ⟨original,ho⟩ := admittedLedgerExists _ _ extended
  have out := probabilityOutput _ _ _ extended ho
  exact ⟨original.map probabilityRow,out,probabilityExactWhole _ _ _ extended out⟩

theorem successorPartValue (support : List String) (observation : Observation) (fresh value : String)
    (records : List EntropyLedger.Record)
    (h : EntropyLedger.entropyLedger (support ++ [fresh]) (observation ++ [(fresh,value)]) = .ok records)
    (new : ¬ fresh ∈ support) (row : ProbabilityRow) (member : row ∈ records.map probabilityRow) :
    (fibre support observation row.observedLabel ++ (if value = row.observedLabel then [fresh] else [])).length *
      row.exactSupportPart.denominator = row.exactSupportPart.numerator * (support.length+1) := by
  obtain ⟨original,hm,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage probabilityRow row records member
  cases eq
  exact EntropyExtension.successorPartValue _ _ _ _ _ h new original hm

end SFT.InformationScience.ClassicalExtension

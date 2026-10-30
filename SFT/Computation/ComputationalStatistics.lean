import SFT.InformationScience.EntropyExtension
import SFT.InformationScience.ConservationComposition
namespace SFT.Computation.ComputationalStatistics
open SFT.InformationScience.EntropyPartition SFT.InformationScience.EntropyLedger
open SFT.Mathematics.ProbabilityObservations

structure Model where
  support : List String
  statistic : Observation
  admitted : partitionValid support statistic = true

def summarize (model : Model) : Except String (List Record) :=
  entropyLedger model.support model.statistic

theorem summaryExists (model : Model) : ∃ records, summarize model = .ok records := by
  have p := partitionExists model.support model.statistic model.admitted
  exact ⟨_,ledgerOutput model.support model.statistic _ p⟩

theorem exactStatisticClasses (model : Model) (records : List Record)
    (accepted : summarize model = .ok records) :
    records.map (fun row => (row.observation,row.microstates)) = classRows model.support model.statistic :=
  entropyProvenance model.support model.statistic records accepted

theorem completeSampleSupport (model : Model) (state : String) (held : state ∈ model.support) :
    ∃ label members, (label,members) ∈ classRows model.support model.statistic ∧ state ∈ members :=
  partitionCovers model.support model.statistic _
    (partitionExists model.support model.statistic model.admitted) state held

theorem exactUncertaintyLedger (model : Model) (records : List Record)
    (accepted : summarize model = .ok records) (record : Record) (member : record ∈ records) :
    record.unresolvedDistinctions = unresolvedPairs record.microstates :=
  rowUncertainty model.support model.statistic records accepted record member

theorem exactCountRelation (model : Model) (records : List Record)
    (accepted : summarize model = .ok records) (record : Record) (member : record ∈ records) :
    record.microstates.length * record.exactSupportPart.denominator =
      record.exactSupportPart.numerator * model.support.length :=
  rowExactPart model.support model.statistic records accepted record member

theorem statisticFibre (model : Model) (records : List Record)
    (accepted : summarize model = .ok records) (record : Record) (member : record ∈ records) :
    record.microstates = fibre model.support model.statistic record.observation :=
  ((rowMembership _ _ _ _).mp (recordClass model.support model.statistic records accepted record member)).2

theorem statisticClassesDisjoint (model : Model) (records : List Record)
    (accepted : summarize model = .ok records) (left right : Record)
    (leftRow : left ∈ records) (rightRow : right ∈ records)
    (state : String) (inLeft : state ∈ left.microstates) (inRight : state ∈ right.microstates) :
    left.observation = right.observation := by
  rw [statisticFibre model records accepted left leftRow] at inLeft
  rw [statisticFibre model records accepted right rightRow] at inRight
  exact fibreDisjoint model.support model.statistic left.observation right.observation state inLeft inRight

theorem exactSupportPartBound (model : Model) (records : List Record)
    (accepted : summarize model = .ok records) (record : Record) (member : record ∈ records) :
    record.exactSupportPart.numerator ≤ record.exactSupportPart.denominator :=
  rowPartThroughOne model.support model.statistic records accepted record member

open SFT.Mathematics.GeometryTopology

inductive ClassificationTrace (statistic : Observation) : List String → List String → Prop where
  | nil : ClassificationTrace statistic [] []
  | cons {state label : String} {rest labels : List String} :
      image statistic state = some label → ClassificationTrace statistic rest labels →
      ClassificationTrace statistic (state :: rest) (label :: labels)

theorem classificationReplay (statistic : Observation) (support labels : List String)
    (trace : ClassificationTrace statistic support labels) : observedValues statistic support = labels := by
  induction trace with
  | nil => rfl
  | cons lookup tail ih =>
    change (match image statistic _ with | none => observedValues statistic _ | some label => label :: observedValues statistic _) = _
    rw [lookup,ih]

theorem classificationComplete (statistic : Observation) (support : List String)
    (total : ∀ state, state ∈ support → ∃ label, image statistic state = some label) :
    ClassificationTrace statistic support (observedValues statistic support) := by
  induction support with
  | nil => exact .nil
  | cons state rest ih =>
    obtain ⟨label,lookup⟩ := total state (List.Mem.head rest)
    change ClassificationTrace statistic (state :: rest)
      (match image statistic state with | none => observedValues statistic rest | some value => value :: observedValues statistic rest)
    rw [lookup]
    exact .cons lookup (ih (fun other member => total other (List.Mem.tail state member)))

theorem modelClassificationTrace (model : Model) :
    ClassificationTrace model.statistic model.support (observedValues model.statistic model.support) :=
  classificationComplete model.statistic model.support
    (admittedImage model.support model.statistic ((validityMeaning _ _).mp model.admitted).2.2.2)

theorem classificationCount (statistic : Observation) (support labels : List String)
    (trace : ClassificationTrace statistic support labels) : labels.length = support.length := by
  induction trace with
  | nil => rfl
  | cons _ _ ih => exact congrArg Nat.succ ih

theorem classificationComposition (statistic : Observation) (left right before after : List String)
    (first : ClassificationTrace statistic left before) (second : ClassificationTrace statistic right after) :
    ClassificationTrace statistic (left ++ right) (before ++ after) := by
  induction first with
  | nil => exact second
  | cons lookup tail ih => exact .cons lookup ih

def extend (model : Model) (fresh value : String) (new : ¬ fresh ∈ model.support) : Model :=
  ⟨model.support ++ [fresh],model.statistic ++ [(fresh,value)],
    SFT.InformationScience.EntropyExtension.validSuccessor _ _ _ _ model.admitted new⟩

theorem successorClasses (model : Model) (fresh value label : String) (new : ¬ fresh ∈ model.support) :
    fibre (extend model fresh value new).support (extend model fresh value new).statistic label =
      fibre model.support model.statistic label ++ (if value = label then [fresh] else []) :=
  SFT.InformationScience.EntropyExtension.fibreSuccessor _ _ _ _ _ new

theorem successorTrace (model : Model) (fresh value : String) (new : ¬ fresh ∈ model.support) :
    observedValues (extend model fresh value new).statistic (extend model fresh value new).support =
      observedValues model.statistic model.support ++ [value] :=
  SFT.InformationScience.EntropyExtension.observedSuccessor _ _ _ _ new

theorem successorUncertainty (model : Model) (fresh value : String) (new : ¬ fresh ∈ model.support) :
    uncertaintyPairs (unresolvedPairs
      (fibre (extend model fresh value new).support (extend model fresh value new).statistic value)) =
        SFT.InformationScience.EntropyExtension.extendedPairs fresh (fibre model.support model.statistic value) :=
  SFT.InformationScience.EntropyExtension.classPairSuccessor _ _ _ _ new

theorem successorCountRelation (model : Model) (fresh value : String) (new : ¬ fresh ∈ model.support)
    (records : List Record) (accepted : summarize (extend model fresh value new) = .ok records)
    (record : Record) (member : record ∈ records) :
    (fibre model.support model.statistic record.observation ++
      (if value = record.observation then [fresh] else [])).length * record.exactSupportPart.denominator =
      record.exactSupportPart.numerator * (model.support.length + 1) :=
  SFT.InformationScience.EntropyExtension.successorPartValue _ _ _ _ records accepted new record member

def singletonModel (state label : String) : Model :=
  ⟨[state],[(state,label)],SFT.InformationScience.EntropyExtension.singletonValid state label⟩

theorem singletonSummary (state label : String) :
    exactPartition (singletonModel state label).support (singletonModel state label).statistic =
      .ok [(label,[state])] := SFT.InformationScience.EntropyExtension.singletonBase state label

theorem composedStatistic (model : Model) (downstream : Observation) (state middle output : String)
    (held : state ∈ model.support) (first : image model.statistic state = some middle)
    (second : image downstream middle = some output) :
    image (SFT.InformationScience.ConservationComposition.composedRows model.support model.statistic downstream) state = some output := by
  rw [SFT.InformationScience.ConservationComposition.composedImage _ _ _ _ held,
    SFT.InformationScience.ConservationComposition.valueExact _ _ _ first,
    SFT.InformationScience.ConservationComposition.valueExact _ _ _ second]

theorem closedDistinctionsPersist (model : Model) (downstream : Observation) (pair : String × String)
    (closed : pair ∈ SFT.InformationScience.ConservationLedger.closed model.support model.statistic) :
    pair ∈ SFT.InformationScience.ConservationLedger.closed model.support
      (SFT.InformationScience.ConservationComposition.composedRows model.support model.statistic downstream) :=
  SFT.InformationScience.ConservationComposition.closedPersists _ _ _ _ closed

theorem retainedDistinctionsSubset (model : Model) (downstream : Observation) (pair : String × String)
    (retained : pair ∈ SFT.InformationScience.ConservationLedger.retained model.support
      (SFT.InformationScience.ConservationComposition.composedRows model.support model.statistic downstream)) :
    pair ∈ SFT.InformationScience.ConservationLedger.retained model.support model.statistic :=
  SFT.InformationScience.ConservationComposition.retainedSubset _ _ _ _ retained

end SFT.Computation.ComputationalStatistics

import SFT.Chemistry.PolymerChain
import SFT.Mathematics.FoldScalar
namespace SFT.Chemistry.PolymerDistribution
open SFT.Foundation.Count.TraceDerivation
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar
open SFT.Mathematics.ExactRatioRelations

-- Resolved source observations retain their complete chain and measurement record.
structure Row (Word Cell : Type) where
 unit : Functional.Group
 chain : PolymerChain.Chain unit Word Cell
 multiplicity : SFT.Physics.CapabilityValues.PositiveCount
 molarMass : PositiveFraction
 observation : SFT.Host.Canonical.Value

def length {Word Cell : Type} (row : Row Word Cell) := PolymerChain.extent row.chain.incidence

def numberWeight {Word Cell : Type} (row : Row Word Cell) : PositiveFraction :=
 normalizePositive row.multiplicity.value 1 row.multiplicity.positive (by decide)

def massWeight {Word Cell : Type} (row : Row Word Cell) : PositiveFraction :=
 compose (numberWeight row) row.molarMass

structure Population (Word Cell : Type) where
 first : Row Word Cell
 rest : List (Row Word Cell)
 sample : SFT.Host.Canonical.Value
 method : SFT.Host.Canonical.Value

def rows {Word Cell : Type} (p : Population Word Cell) := p.first::p.rest

def accumulate {Word Cell : Type} (weight : Row Word Cell → PositiveFraction)
 (initial : PositiveFraction) : List (Row Word Cell) → PositiveFraction
 | [] => initial
 | row::rest => accumulate weight (sumMagnitude initial (weight row)) rest

def total {Word Cell : Type} (weight : Row Word Cell → PositiveFraction) (p : Population Word Cell) :=
 accumulate weight (weight p.first) p.rest

def numberFraction {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :=
 quotientMagnitude (numberWeight row) (total numberWeight p)
def massFraction {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :=
 quotientMagnitude (massWeight row) (total massWeight p)

def append {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) : Population Word Cell :=
 {p with rest:=p.rest++[row]}

def lengthCensus {Word Cell : Type} (p : Population Word Cell) :=
 (rows p).map (fun row => (length row,row.multiplicity.value))

-- The internal empty tally is the identity of finite counting; exported
-- absent classes use none rather than a zero-valued scientific count.
def tally {Word Cell : Type} (target : Nat) : List (Row Word Cell) → Nat
 | [] => 0
 | row::rest => (if length row=target then row.multiplicity.value else 0)+tally target rest

def multiplicityAt {Word Cell : Type} (p : Population Word Cell) (target : Nat) :
 Option SFT.Physics.CapabilityValues.PositiveCount :=
 if h : 0<tally target (rows p) then some ⟨tally target (rows p),h⟩ else none

theorem exactRowOrder {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :
 rows (append p row)=rows p++[row] := rfl

theorem allRowsRetained {Word Cell : Type} (p : Population Word Cell) (new old : Row Word Cell)
 (held : old∈rows p) : old∈rows (append p new) := memAppendLeft _ _ _ held

theorem everyLengthRetained {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell)
 (held : row∈rows p) : (length row,row.multiplicity.value)∈lengthCensus p := memMap _ _ _ held

theorem completeLengthCensus {Word Cell : Type} (p : Population Word Cell) (pair : Nat×Nat)
 (held : pair∈lengthCensus p) :
 ∃ row∈rows p, (length row,row.multiplicity.value)=pair := memMapPreimage _ _ _ held

theorem appendCensus {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :
 lengthCensus (append p row)=lengthCensus p++[(length row,row.multiplicity.value)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (fun r : Row Word Cell => (length r,r.multiplicity.value)) (rows p) [row]

theorem tallyAppend {Word Cell : Type} (target : Nat) (prior : List (Row Word Cell)) (row : Row Word Cell) :
 tally target (prior++[row])=tally target prior+(if length row=target then row.multiplicity.value else 0) := by
 induction prior with
 | nil => exact (Nat.add_zero _).trans (Nat.zero_add _).symm
 | cons first rest ih =>
   change _+tally target (rest++[row])=(_+tally target rest)+_
   rw [ih,Nat.add_assoc]

theorem appendedClassIncrement {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :
 tally (length row) (rows (append p row))=tally (length row) (rows p)+row.multiplicity.value := by
 rw [exactRowOrder,tallyAppend,ite_eq_left rfl]

theorem otherClassUnchanged {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell)
 (target : Nat) (different : length row≠target) :
 tally target (rows (append p row))=tally target (rows p) := by
 rw [exactRowOrder,tallyAppend,ite_eq_right different,Nat.add_zero]

theorem representedClassPositive {Word Cell : Type} (rs : List (Row Word Cell)) (row : Row Word Cell)
 (held : row∈rs) : 0<tally (length row) rs := by
 induction held with
 | head =>
   change 0<(if length row=length row then row.multiplicity.value else 0)+_
   rw [ite_eq_left rfl]
   exact Nat.lt_of_lt_of_le row.multiplicity.positive (Nat.le_add_right _ _)
 | tail first held ih => exact Nat.lt_of_lt_of_le ih (Nat.le_add_left _ _)

theorem noInventedClass {Word Cell : Type} (target : Nat) (rs : List (Row Word Cell))
 (absent : ∀ row∈rs, length row≠target) : tally target rs=0 := by
 induction rs with
 | nil => rfl
 | cons first rest ih =>
   change (if length first=target then first.multiplicity.value else 0)+_=0
   rw [ite_eq_right (absent first (.head _)),ih (fun row h => absent row (.tail _ h))]

theorem oneChainIncrement {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell)
 (single : row.multiplicity.value=1) :
 tally (length row) (rows (append p row))=tally (length row) (rows p)+1 := by
 rw [appendedClassIncrement,single]

theorem accumulationAppend {Word Cell : Type} (weight : Row Word Cell → PositiveFraction)
 (initial : PositiveFraction) (prior : List (Row Word Cell)) (row : Row Word Cell) :
 accumulate weight initial (prior++[row])=sumMagnitude (accumulate weight initial prior) (weight row) := by
 induction prior generalizing initial with
 | nil => rfl
 | cons first rest ih => exact ih (sumMagnitude initial (weight first))

theorem totalSuccessor {Word Cell : Type} (weight : Row Word Cell → PositiveFraction)
 (p : Population Word Cell) (row : Row Word Cell) :
 total weight (append p row)=sumMagnitude (total weight p) (weight row) :=
 accumulationAppend weight (weight p.first) p.rest row

theorem massContributionExact {Word Cell : Type} (row : Row Word Cell) :
 ((numberWeight row).numerator*row.molarMass.numerator)*(massWeight row).denominator=
 (massWeight row).numerator*((numberWeight row).denominator*row.molarMass.denominator) :=
 composeValue _ _

theorem numberFractionExact {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :
 ((numberWeight row).numerator*(total numberWeight p).denominator)*(numberFraction p row).denominator=
 (numberFraction p row).numerator*((numberWeight row).denominator*(total numberWeight p).numerator) :=
 quotientExact _ _

theorem massFractionExact {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :
 ((massWeight row).numerator*(total massWeight p).denominator)*(massFraction p row).denominator=
 (massFraction p row).numerator*((massWeight row).denominator*(total massWeight p).numerator) :=
 quotientExact _ _

theorem boundariesRetained {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell) :
 (append p row).sample=p.sample ∧ (append p row).method=p.method := ⟨rfl,rfl⟩


def base {Word Cell : Type} (first second : Row Word Cell)
 (sample method : SFT.Host.Canonical.Value) :
 Population Word Cell := ⟨first,[second],sample,method⟩

theorem baseRows {Word Cell : Type} (first second : Row Word Cell)
 (sample method : SFT.Host.Canonical.Value) :
 rows (base first second sample method)=[first,second] := rfl

theorem actualChainLength {Word Cell : Type} (row : Row Word Cell) :
 length row=(PolymerChain.sourceRecord row.chain).occurrences.value := rfl

theorem positiveLength {Word Cell : Type} (row : Row Word Cell) : 0<length row :=
 PolymerChain.positiveExtent row.chain.incidence

theorem totalPositive {Word Cell : Type} (weight : Row Word Cell → PositiveFraction)
 (p : Population Word Cell) : 0<(total weight p).numerator := (total weight p).positive

theorem measuredMassDoesNotChangeLength {Word Cell : Type} (row : Row Word Cell)
 (mass : PositiveFraction) : length {row with molarMass:=mass}=length row := rfl

theorem measuredMassDoesNotChangeNumberWeight {Word Cell : Type} (row : Row Word Cell)
 (mass : PositiveFraction) : numberWeight {row with molarMass:=mass}=numberWeight row := rfl

theorem tallyForced {Word Cell : Type} (target : Nat) (proposed : List (Row Word Cell) → Nat)
 (empty : proposed []=0)
 (step : ∀ row rest, proposed (row::rest)=
  (if length row=target then row.multiplicity.value else 0)+proposed rest)
 (rs : List (Row Word Cell)) : proposed rs=tally target rs := by
 induction rs with
 | nil => exact empty
 | cons first rest ih => exact (step first rest).trans (congrArg (fun n => _+n) ih)

theorem representedClassPresent {Word Cell : Type} (p : Population Word Cell) (row : Row Word Cell)
 (held : row∈rows p) :
 ∃ count, multiplicityAt p (length row)=some count ∧ count.value=tally (length row) (rows p) := by
 have positive := representedClassPositive (rows p) row held
 refine ⟨⟨tally (length row) (rows p),positive⟩,?_,rfl⟩
 unfold multiplicityAt
 rw [dif_pos positive]

theorem absentClassEmpty {Word Cell : Type} (p : Population Word Cell) (target : Nat)
 (absent : ∀ row∈rows p, length row≠target) : multiplicityAt p target=none := by
 unfold multiplicityAt
 have empty := noInventedClass target (rows p) absent
 have notPositive : ¬0<tally target (rows p) := by rw [empty]; exact Nat.not_lt_zero 0
 rw [dif_neg notPositive]


theorem numberWeightExact {Word Cell : Type} (row : Row Word Cell) :
 row.multiplicity.value*(numberWeight row).denominator=(numberWeight row).numerator*1 :=
 normalizedValuePreserved _ _ _ _

theorem totalSuccessorExact {Word Cell : Type} (weight : Row Word Cell → PositiveFraction)
 (p : Population Word Cell) (row : Row Word Cell) :
 (leftCross (total weight p) (weight row)+rightCross (total weight p) (weight row))*
 (total weight (append p row)).denominator=
 (total weight (append p row)).numerator*denominator (total weight p) (weight row) := by
 rw [totalSuccessor]
 exact sumExact _ _


-- The complete observed census is retained even when there are no resolved
-- rows. Positive weighted readouts are constructed only for nonempty data.
structure Census (Word Cell : Type) where
 observations : List (Row Word Cell)
 sample : SFT.Host.Canonical.Value
 method : SFT.Host.Canonical.Value

def positiveSample {Word Cell : Type} (census : Census Word Cell) : Option (Population Word Cell) :=
 match census.observations with
 | [] => none
 | first::rest => some ⟨first,rest,census.sample,census.method⟩

def completeCensus {Word Cell : Type} (p : Population Word Cell) : Census Word Cell :=
 ⟨rows p,p.sample,p.method⟩

theorem positiveSampleRoundTrip {Word Cell : Type} (p : Population Word Cell) :
 positiveSample (completeCensus p)=some p := by cases p; rfl

theorem positiveSampleRetainsEveryRow {Word Cell : Type} (census : Census Word Cell)
 (p : Population Word Cell) (accepted : positiveSample census=some p) :
 rows p=census.observations ∧ p.sample=census.sample ∧ p.method=census.method := by
 unfold positiveSample at accepted
 cases shape : census.observations with
 | nil => rw [shape] at accepted; cases accepted
 | cons first rest =>
   rw [shape] at accepted
   cases Option.some.inj accepted
   exact ⟨rfl,rfl,rfl⟩

theorem noResolvedRows {Word Cell : Type} (sample method : SFT.Host.Canonical.Value) :
 positiveSample (⟨[],sample,method⟩ : Census Word Cell)=none := rfl

theorem singletonRetained {Word Cell : Type} (row : Row Word Cell)
 (sample method : SFT.Host.Canonical.Value) :
 positiveSample (⟨[row],sample,method⟩ : Census Word Cell)=some ⟨row,[],sample,method⟩ := rfl

end SFT.Chemistry.PolymerDistribution

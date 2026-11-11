import SFT.Chemistry.IsotopeFamily
import SFT.Mathematics.FoldScalar
namespace SFT.Chemistry.AtomicWeightPopulation
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar
open SFT.Mathematics.ExactRatioRelations

-- elements_periodicity_batch_1.py SPECS[3]: exact population calculation
-- over registered observation records; no measured mass selects the grammar.
structure Row where
 isotope : IsotopeFamily.Nuclide
 abundance : SFT.Foundation.ExactPartCarrier.Part
 mass : PositiveFraction
 massSourceRecord : SFT.Host.Canonical.Value

def part (r : Row) : PositiveFraction :=
 ⟨r.abundance.numerator,r.abundance.denominator,r.abundance.denominatorNonzero,r.abundance.reduced,r.abundance.positive⟩
def contribution (r : Row) : PositiveFraction := compose (part r) r.mass

def accumulate (value : Row → PositiveFraction) (initial : PositiveFraction) : List Row → PositiveFraction
 | [] => initial
 | row :: rest => accumulate value (sumMagnitude initial (value row)) rest

structure Population where
 first : Row
 rest : List Row
 sourceBoundary : SFT.Host.Canonical.Value
 uncertainty : SFT.Host.Canonical.Value
 reference : PositiveFraction
 referenceRecord : SFT.Host.Canonical.Value

def rows (p : Population) : List Row := p.first :: p.rest
def weightedTotal (p : Population) : PositiveFraction := accumulate contribution (contribution p.first) p.rest
def abundanceTotal (p : Population) : PositiveFraction := accumulate part (part p.first) p.rest
def average (p : Population) : PositiveFraction := quotientMagnitude (weightedTotal p) (abundanceTotal p)
def relativeMass (p : Population) : PositiveFraction := quotientMagnitude (average p) p.reference

def append (p : Population) (row : Row) : Population := {p with rest := p.rest ++ [row]}

theorem contributionExact (r : Row) :
 (r.abundance.numerator * r.mass.numerator) * (contribution r).denominator =
 (contribution r).numerator * (r.abundance.denominator * r.mass.denominator) := composeValue (part r) r.mass

theorem accumulationAppend (value : Row → PositiveFraction) (initial : PositiveFraction) (prior : List Row) (new : Row) :
 accumulate value initial (prior ++ [new]) = sumMagnitude (accumulate value initial prior) (value new) := by
 induction prior generalizing initial with
 | nil => rfl
 | cons row rest ih => exact ih (sumMagnitude initial (value row))

theorem weightedSuccessor (p : Population) (row : Row) :
 weightedTotal (append p row) = sumMagnitude (weightedTotal p) (contribution row) :=
 accumulationAppend contribution (contribution p.first) p.rest row

theorem abundanceSuccessor (p : Population) (row : Row) :
 abundanceTotal (append p row) = sumMagnitude (abundanceTotal p) (part row) :=
 accumulationAppend part (part p.first) p.rest row

theorem weightedSuccessorExact (p : Population) (row : Row) :
 (leftCross (weightedTotal p) (contribution row) + rightCross (weightedTotal p) (contribution row)) *
 (weightedTotal (append p row)).denominator =
 (weightedTotal (append p row)).numerator * denominator (weightedTotal p) (contribution row) := by
 rw [weightedSuccessor]
 exact sumExact _ _

theorem averageExact (p : Population) :
 ((weightedTotal p).numerator * (abundanceTotal p).denominator) * (average p).denominator =
 (average p).numerator * ((weightedTotal p).denominator * (abundanceTotal p).numerator) := quotientExact _ _

theorem referenceComparisonExact (p : Population) :
 ((average p).numerator * p.reference.denominator) * (relativeMass p).denominator =
 (relativeMass p).numerator * ((average p).denominator * p.reference.numerator) := quotientExact _ _

theorem positiveWeightedTotal (p : Population) : 0 < (weightedTotal p).numerator := (weightedTotal p).positive

theorem positiveAverage (p : Population) : 0 < (average p).numerator := (average p).positive

theorem positiveRelativeMass (p : Population) : 0 < (relativeMass p).numerator := (relativeMass p).positive

theorem allPriorPairsRetained (p : Population) (new prior : Row) (held : prior ∈ rows p) :
 prior ∈ rows (append p new) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft prior (rows p) [new] held

theorem exactRowOrder (p : Population) (new : Row) : rows (append p new) = rows p ++ [new] := rfl

theorem completePopulation (p : Population) : rows p ≠ [] := fun h => nomatch h

theorem sourceBoundaryRetained (p : Population) (row : Row) :
 (append p row).sourceBoundary = p.sourceBoundary := rfl

theorem uncertaintyRetained (p : Population) (row : Row) : (append p row).uncertainty = p.uncertainty := rfl

theorem referenceRetained (p : Population) (row : Row) :
 (append p row).reference = p.reference ∧ (append p row).referenceRecord = p.referenceRecord := ⟨rfl,rfl⟩

def rerecordReference (p : Population) (value : PositiveFraction) (record : SFT.Host.Canonical.Value) : Population :=
 {p with reference := value, referenceRecord := record}

theorem referenceDoesNotSelectAverage (p : Population) (value : PositiveFraction) (record : SFT.Host.Canonical.Value) :
 average (rerecordReference p value record) = average p := rfl

theorem differentCompositionDistinct (a b : Population) (different : rows a ≠ rows b) : a ≠ b :=
 fun same => different (congrArg rows same)

theorem differentSourceDistinct (a b : Population) (different : a.sourceBoundary ≠ b.sourceBoundary) : a ≠ b :=
 fun same => different (congrArg Population.sourceBoundary same)

theorem forcedAccumulation (value : Row → PositiveFraction)
 (proposed : PositiveFraction → List Row → PositiveFraction)
 (base : ∀ initial, proposed initial [] = initial)
 (step : ∀ initial row rest, proposed initial (row :: rest) = proposed (sumMagnitude initial (value row)) rest)
 (initial : PositiveFraction) (rs : List Row) : proposed initial rs = accumulate value initial rs := by
 induction rs generalizing initial with
 | nil => exact base initial
 | cons row rest ih => exact (step initial row rest).trans (ih (sumMagnitude initial (value row)))

inductive History : Population → Population → Prop where
 | base (p : Population) : History p p
 | next {first prior : Population} (history : History first prior) (row : Row) : History first (append prior row)

theorem historyRetainsRows {first last : Population} (history : History first last) (row : Row)
 (held : row ∈ rows first) : row ∈ rows last := by
 induction history with
 | base => exact held
 | next prior new ih => exact allPriorPairsRetained _ new row ih

theorem historyBoundary {first last : Population} (history : History first last) :
 last.sourceBoundary = first.sourceBoundary ∧ last.uncertainty = first.uncertainty ∧
 last.reference = first.reference ∧ last.referenceRecord = first.referenceRecord := by
 induction history with
 | base => exact ⟨rfl,rfl,rfl,rfl⟩
 | next prior row ih => exact ih
end SFT.Chemistry.AtomicWeightPopulation

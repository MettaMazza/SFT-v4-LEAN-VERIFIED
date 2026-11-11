import SFT.Chemistry.AffinityComparison
import SFT.Chemistry.AffinityClosure
namespace SFT.Chemistry.AffinityRecordClosure
open SFT.Foundation.Count.TraceDerivation

-- redox_derivation.py: AffinityComparison retains both endpoints, the shared
-- support and the held orientation. This projection changes none of those fields.
def edge (row : AffinityComparison.Comparison) : String × String :=
 if row.raw.preferredEndpoint=row.raw.firstAtom then
 (row.raw.secondAtom,row.raw.firstAtom)
 else (row.raw.firstAtom,row.raw.secondAtom)

def relation (records : List AffinityComparison.Comparison) : AffinityClosure.Relation :=
 records.map edge

theorem edgeTargetsHeldPreference (row : AffinityComparison.Comparison) :
 (edge row).2=row.raw.preferredEndpoint := by
 unfold edge
 split
 · rename_i first; exact first.symm
 · rename_i first
   cases AffinityComparison.preferredIsEndpoint row with
   | inl impossible => exact False.elim (first impossible)
   | inr second => exact second.symm

theorem edgeRetainsEndpoints (row : AffinityComparison.Comparison) :
 edge row=(row.raw.secondAtom,row.raw.firstAtom) ∨
 edge row=(row.raw.firstAtom,row.raw.secondAtom) := by
 unfold edge
 split
 · exact .inl rfl
 · exact .inr rfl

theorem completeRelation (records : List AffinityComparison.Comparison) (pair : String × String) :
 pair∈relation records ↔ ∃ row, row∈records ∧ edge row=pair := by
 constructor
 · intro held
   exact memMapPreimage edge pair records held
 · intro witness
   obtain ⟨row,held,same⟩ := witness
   rw [←same]
   exact memMap edge row records held

def order (records : List AffinityComparison.Comparison) := AffinityClosure.Precedes (relation records)

theorem recordedComparisonIncluded (records : List AffinityComparison.Comparison)
 (row : AffinityComparison.Comparison) (held : row∈records) :
 order records (edge row).1 row.raw.preferredEndpoint := by
 rw [←edgeTargetsHeldPreference row]
 exact .step .identity (memMap edge row records held)

theorem noExtraOrder (records : List AffinityComparison.Comparison) (Q : String → String → Prop)
 (reflexive : ∀ a, Q a a) (transitive : ∀ a b c, Q a b → Q b c → Q a c)
 (includes : ∀ row∈records, Q (edge row).1 row.raw.preferredEndpoint)
 (a b : String) (path : order records a b) : Q a b := by
 apply AffinityClosure.leastClosure (relation records) Q reflexive transitive _ a b path
 intro left right held
 obtain ⟨row,member,same⟩ := (completeRelation records (left,right)).mp held
 have value := includes row member
 rw [←edgeTargetsHeldPreference row,same] at value
 exact value

theorem extensionRelation (before : List AffinityComparison.Comparison)
 (fresh : AffinityComparison.Comparison) :
 relation (before++[fresh])=relation before++[edge fresh] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend edge before [fresh]

theorem extensionRetainsOrder (before : List AffinityComparison.Comparison)
 (fresh : AffinityComparison.Comparison) (a b : String) (prior : order before a b) :
 order (before++[fresh]) a b := by
 unfold order
 rw [extensionRelation]
 exact AffinityClosure.retainedClosure _ _ _ _ prior

theorem extensionRetainsFullRecord (before : List AffinityComparison.Comparison)
 (fresh old : AffinityComparison.Comparison) (held : old∈before) : old∈before++[fresh] :=
 memAppendLeft _ _ _ held

theorem initialComparison (row : AffinityComparison.Comparison) :
 order [row] (edge row).1 row.raw.preferredEndpoint :=
 recordedComparisonIncluded [row] row (.head _)

theorem originalOrientation : edge AffinityComparison.original=("atom-a","atom-b") := rfl
end SFT.Chemistry.AffinityRecordClosure

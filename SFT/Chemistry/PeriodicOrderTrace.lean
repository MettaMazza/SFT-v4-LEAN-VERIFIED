import SFT.Chemistry.IsotopeFamily
namespace SFT.Chemistry.PeriodicOrderTrace
open ElementIdentity AtomicNumberOrder
structure Row where
 representative : Atom
 isotopeSupport : List IsotopeFamily.Nuclide
 symbol : String
 sourceRecord : SFT.Host.Canonical.Value
 pageLocation : String

def coordinate (r : Row) : Nat := atomicNumber r.representative
def ordered (a b : Row) : Prop := coordinate a ≤ coordinate b
def valid (r : Row) : Prop := ∀ n, n ∈ r.isotopeSupport → atomicNumber n.atom = coordinate r

theorem positiveCoordinate (r : Row) : 0 < coordinate r := positiveIdentity r.representative

theorem total (a b : Row) : ordered a b ∨ ordered b a := totalOrder a.representative b.representative

theorem antisymmetricClass (a b : Row) (ab : ordered a b) (ba : ordered b a) :
 sameElement a.representative b.representative := antisymmetricOrder _ _ ab ba

theorem completeClassAtCoordinate (a b : Row) : coordinate a = coordinate b ↔
 (∀ atom, classContains a.representative atom ↔ classContains b.representative atom) := countClassEquivalence _ _

def relocate (r : Row) (location : String) : Row := {r with pageLocation := location}

theorem layoutCannotSelectOrder (a b : Row) (left right : String) :
 ordered (relocate a left) (relocate b right) ↔ ordered a b := ⟨id,id⟩

theorem layoutRetainsIsotopes (r : Row) (location : String) :
 (relocate r location).isotopeSupport = r.isotopeSupport := rfl

inductive Sequence : Row → Type where
 | first (row : Row) (admitted : valid row) (one : coordinate row = 1) : Sequence row
 | next {prior : Row} (history : Sequence prior) (row : Row) (admitted : valid row)
   (successor : coordinate row = coordinate prior + 1) : Sequence row

def records {last : Row} : Sequence last → List Row
 | .first row _ _ => [row]
 | .next history row _ _ => records history ++ [row]

def length {last : Row} : Sequence last → Nat
 | .first _ _ _ => 1
 | .next history _ _ _ => length history + 1

theorem coordinateForced {last : Row} (history : Sequence last) : coordinate last = length history := by
 induction history with
 | first row admitted one => exact one
 | next history row admitted successor ih => exact successor.trans (congrArg (fun n => n+1) ih)

theorem successorStrict {prior : Row} (history : Sequence prior) (row : Row) (admitted : valid row)
 (successor : coordinate row = coordinate prior + 1) : coordinate prior < coordinate row := by
 rw [successor]
 exact Nat.lt_succ_self _

theorem retainsEveryRow {prior : Row} (history : Sequence prior) (row : Row) (admitted : valid row)
 (successor : coordinate row = coordinate prior + 1) (old : Row) (held : old ∈ records history) :
 old ∈ records (.next history row admitted successor) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft old (records history) [row] held

theorem allIsotopeSupportsValid {last : Row} (history : Sequence last) (row : Row) (held : row ∈ records history) : valid row := by
 induction history with
 | first first admitted one =>
   cases held with
   | head => exact admitted
   | tail _ impossible => cases impossible
 | next history next admitted successor ih =>
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases row (records history) [next] held with
   | inl old => exact ih old
   | inr new =>
     cases new with
     | head => exact admitted
     | tail _ impossible => cases impossible

theorem completeTraceLength {last : Row} (history : Sequence last) : (records history).length = length history := by
 induction history with
 | first => rfl
 | next history row admitted successor ih =>
   change (records history ++ [row]).length = length history + 1
   rw [SFT.Foundation.CommonRefinement.appendLength,ih]
   rfl
end SFT.Chemistry.PeriodicOrderTrace

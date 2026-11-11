import SFT.Chemistry.FormulaComposition
namespace SFT.Chemistry.NomenclatureWord

-- measurement_identity_batch_2.py NOMENCLATURE_BOUNDARY/DIMENSIONS/SPECS[2].
structure Part where
 syllable : String
 «prefix» : Option Nat
 deriving DecidableEq

structure Name (Structure : Type) where
 parts : List Part
 formula : FormulaComposition.Formula Structure

variable {S : Type}
def partAdmitted (registry : List String) (part : Part) : Prop :=
 part.syllable ∈ registry ∧ match part.«prefix» with
 | none => True
 | some count => 0 < count

def admitted (registry : List String) (name : Name S) : Prop :=
 name.parts ≠ [] ∧ (∀ p, p ∈ name.parts → partAdmitted registry p) ∧
 FormulaComposition.admitted name.formula

def initial (p : Part) (f : FormulaComposition.Formula S) : Name S := ⟨[p],f⟩
def append (n : Name S) (p : Part) : Name S := ⟨n.parts ++ [p],n.formula⟩

theorem initialAdmitted (registry : List String) (p : Part) (f : FormulaComposition.Formula S)
 (part : partAdmitted registry p) (formula : FormulaComposition.admitted f) : admitted registry (initial p f) := by
 refine ⟨(fun h => nomatch h),?_,formula⟩
 intro row held
 cases held with
 | head => exact part
 | tail _ impossible => cases impossible

theorem successorAdmitted (registry : List String) (n : Name S) (p : Part)
 (valid : admitted registry n) (part : partAdmitted registry p) : admitted registry (append n p) := by
 refine ⟨?_,?_,valid.2.2⟩
 · intro empty
   have member : p ∈ (append n p).parts := List.mem_append_right _ (List.Mem.head _)
   rw [empty] at member; cases member
 · intro row held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases row n.parts [p] held with
   | inl old => exact valid.2.1 row old
   | inr new =>
     cases new with
     | head => exact part
     | tail _ impossible => cases impossible

theorem retainsOrder (n : Name S) (p : Part) :
 EntityIdentity.priorCoordinates (append n p).parts = n.parts :=
 EntityIdentity.priorCoordinatesExact n.parts p

theorem retainsFormula (n : Name S) (p : Part) : (append n p).formula = n.formula := rfl

theorem unregisteredRejected (registry : List String) (n : Name S) (p : Part)
 (absent : ¬ p.syllable ∈ registry) : ¬ admitted registry (append n p) :=
 fun valid => absent (valid.2.1 p (List.mem_append_right _ (List.Mem.head _))).1

theorem zeroPrefixRejected (registry : List String) (n : Name S) (p : Part)
 (zero : p.«prefix» = some 0) : ¬ admitted registry (append n p) := by
 intro valid
 have held := (valid.2.1 p (List.mem_append_right _ (List.Mem.head _))).2
 rw [zero] at held
 exact Nat.not_lt_zero _ held

-- The registered boundary is injectivity of the full ordered word into the
-- retained formula record. It is checked, never inferred from a surface name.
def injectiveBoundary (rows : List (Name S)) : Prop :=
 ∀ a, a ∈ rows → ∀ b, b ∈ rows → a.parts = b.parts → a.formula = b.formula

def lookup (parts : List Part) : List (Name S) → Option (FormulaComposition.Formula S)
 | [] => none
 | row :: rest => if row.parts = parts then some row.formula else lookup parts rest

theorem boundaryTail (row : Name S) (rest : List (Name S))
 (valid : injectiveBoundary (row :: rest)) : injectiveBoundary rest :=
 fun a ha b hb same => valid a (List.Mem.tail _ ha) b (List.Mem.tail _ hb) same

theorem exactDecode (rows : List (Name S)) (valid : injectiveBoundary rows)
 (name : Name S) (held : name ∈ rows) : lookup name.parts rows = some name.formula := by
 induction rows with
 | nil => cases held
 | cons row rest ih =>
   unfold lookup
   split
   next same => exact congrArg some (valid row (List.Mem.head _) name held same)
   next different =>
     cases held with
     | head => exact False.elim (different rfl)
     | tail _ member => exact ih (boundaryTail row rest valid) member

theorem ambiguousRejected (rows : List (Name S)) (a b : Name S)
 (ha : a ∈ rows) (hb : b ∈ rows) (same : a.parts = b.parts)
 (different : a.formula ≠ b.formula) : ¬ injectiveBoundary rows :=
 fun valid => different (valid a ha b hb same)

theorem singletonBoundary (name : Name S) : injectiveBoundary [name] := by
 intro a ha b hb same
 cases ha with
 | head =>
   cases hb with
   | head => rfl
   | tail _ impossible => cases impossible
 | tail _ impossible => cases impossible

theorem boundaryExtension (rows : List (Name S)) (new : Name S)
 (valid : injectiveBoundary rows)
 (compatible : ∀ old, old ∈ rows → new.parts = old.parts → new.formula = old.formula) :
 injectiveBoundary (new :: rows) := by
 intro a ha b hb same
 cases ha with
 | head =>
   cases hb with
   | head => rfl
   | tail _ old => exact compatible b old same
 | tail _ oldA =>
   cases hb with
   | head => exact (compatible a oldA same.symm).symm
   | tail _ oldB => exact valid a oldA b oldB same

theorem exactExtendedDecode (rows : List (Name S)) (new : Name S)
 (valid : injectiveBoundary rows)
 (compatible : ∀ old, old ∈ rows → new.parts = old.parts → new.formula = old.formula) :
 lookup new.parts (new :: rows) = some new.formula :=
 exactDecode (new :: rows) (boundaryExtension rows new valid compatible) new (List.Mem.head _)

inductive Generated (registry : List String) : Name S → Prop where
 | one (p : Part) (f : FormulaComposition.Formula S)
   (part : partAdmitted registry p) (formula : FormulaComposition.admitted f) : Generated registry (initial p f)
 | next {n : Name S} (prior : Generated registry n) (p : Part)
   (part : partAdmitted registry p) : Generated registry (append n p)

theorem generatedAdmitted (registry : List String) {n : Name S} (generated : Generated registry n) : admitted registry n := by
 induction generated with
 | one p f part formula => exact initialAdmitted registry p f part formula
 | next prior p part ih => exact successorAdmitted registry _ p ih part

theorem generatedSuffix (registry : List String) (tail : List Part) (n : Name S)
 (generated : Generated registry n) (valid : ∀ p, p ∈ tail → partAdmitted registry p) :
 Generated registry (⟨n.parts ++ tail,n.formula⟩ : Name S) := by
 induction tail generalizing n with
 | nil => rw [SFT.Mathematics.CategoryIdentity.appendNil]; exact generated
 | cons p ps ih =>
   have next := Generated.next generated p (valid p (List.Mem.head _))
   have rest := ih (append n p) next (fun row held => valid row (List.Mem.tail _ held))
   change Generated registry ⟨(n.parts ++ [p]) ++ ps, n.formula⟩ at rest
   rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative] at rest
   exact rest

theorem admittedGenerated (registry : List String) (n : Name S) (valid : admitted registry n) : Generated registry n := by
 cases n with
 | mk parts f =>
   cases parts with
   | nil => exact False.elim (valid.1 rfl)
   | cons p ps =>
     have first := Generated.one p f (valid.2.1 p (List.Mem.head _)) valid.2.2
     exact generatedSuffix registry ps (initial p f) first (fun row held => valid.2.1 row (List.Mem.tail _ held))

theorem grammarComplete (registry : List String) (n : Name S) : Generated registry n ↔ admitted registry n :=
 ⟨generatedAdmitted registry, admittedGenerated registry n⟩
end SFT.Chemistry.NomenclatureWord

import SFT.Chemistry.AmountCount
import SFT.Mathematics.ExactTraceArithmetic
import SFT.Mathematics.CategoryIdentity
namespace SFT.Chemistry.FormulaComposition

-- measurement_identity_batch_2.py, FORMULA_DIMENSIONS and SPECS[1].
-- A coordinate is an admitted entity identity and a positive generated count.
-- Structural coordinates are retained records, not selectable coefficients.
structure Coordinate where
 entity : EntityIdentity.Record
 multiplicity : Nat
 deriving DecidableEq

structure Formula (Structure : Type) where
 composition : List Coordinate
 structureRecord : List Structure

variable {S : Type}
def admitted (f : Formula S) : Prop :=
 f.composition ≠ [] ∧ ∀ c, c ∈ f.composition → 0 < c.multiplicity

def initial (c : Coordinate) (s : List S) : Formula S := ⟨[c],s⟩
def append (f : Formula S) (c : Coordinate) (s : List S) : Formula S :=
 ⟨f.composition ++ [c],f.structureRecord ++ s⟩

-- The code retains every coordinate in order; no string spelling selects identity.
abbrev Code (Structure : Type) := List (EntityIdentity.Record × Nat) × List Structure

def encode (f : Formula S) : Code S :=
 (f.composition.map (fun c => (c.entity,c.multiplicity)), f.structureRecord)
def decode (c : Code S) : Formula S :=
 ⟨c.1.map (fun p => ⟨p.1,p.2⟩),c.2⟩

theorem rowsRoundtrip (rows : List Coordinate) :
 (rows.map (fun c => (c.entity,c.multiplicity))).map (fun p => (⟨p.1,p.2⟩ : Coordinate)) = rows := by
 induction rows with
 | nil => rfl
 | cons c cs ih => cases c; exact congrArg (List.cons _) ih

theorem decodeEncode (f : Formula S) : decode (encode f) = f := by
 cases f with
 | mk rows s => exact congrArg (fun xs => (⟨xs,s⟩ : Formula S)) (rowsRoundtrip rows)

theorem encodingInjective (a b : Formula S) (same : encode a = encode b) : a = b :=
 (decodeEncode a).symm.trans ((congrArg decode same).trans (decodeEncode b))

theorem structureDistinguished (a b : Formula S)
 (different : a.structureRecord ≠ b.structureRecord) : encode a ≠ encode b :=
 fun same => different (congrArg Formula.structureRecord (encodingInjective a b same))

theorem compositionDistinguished (a b : Formula S)
 (different : a.composition ≠ b.composition) : encode a ≠ encode b :=
 fun same => different (congrArg Formula.composition (encodingInjective a b same))

theorem initialAdmitted (c : Coordinate) (s : List S) (positive : 0 < c.multiplicity) :
 admitted (initial c s) := by
 refine ⟨(fun h => nomatch h),?_⟩
 intro row member
 cases member with
 | head => exact positive
 | tail _ impossible => cases impossible

theorem successorAdmitted (f : Formula S) (c : Coordinate) (s : List S)
 (valid : admitted f) (positive : 0 < c.multiplicity) : admitted (append f c s) := by
 refine ⟨?_,?_⟩
 · intro empty
   have member : c ∈ (append f c s).composition := List.mem_append_right _ (List.Mem.head _)
   rw [empty] at member
   cases member
 · intro row member
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases row f.composition [c] member with
   | inl old => exact valid.2 row old
   | inr new =>
     cases new with
     | head => exact positive
     | tail _ impossible => cases impossible

theorem priorCoordinatesRetained (f : Formula S) (c : Coordinate) (s : List S) :
 EntityIdentity.priorCoordinates (append f c s).composition = f.composition :=
 EntityIdentity.priorCoordinatesExact f.composition c

theorem successorOrder (f : Formula S) (c : Coordinate) (s : List S) :
 (encode (append f c s)).1 = (encode f).1 ++ [(c.entity,c.multiplicity)] := by
 change List.map _ (f.composition ++ [c]) = _
 exact SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem structureReconstructed (f : Formula S) :
 (decode (encode f)).structureRecord = f.structureRecord :=
 congrArg Formula.structureRecord (decodeEncode f)

theorem zeroCountRejected (f : Formula S) (c : Coordinate) (s : List S)
 (zero : c.multiplicity = 0) : ¬ admitted (append f c s) := by
 intro valid
 have positive := valid.2 c (List.mem_append_right _ (List.Mem.head _))
 rw [zero] at positive
 exact Nat.not_lt_zero _ positive

-- Any exact encoding must distinguish the entire required record. This is
-- minimality by retained distinctions, not a new preferred typography.
theorem leastDecodableRecord {CodeType : Type} (encodeOther : Formula S → CodeType)
 (decodeOther : CodeType → Formula S)
 (exactDecode : ∀ f, decodeOther (encodeOther f) = f)
 (a b : Formula S) (same : encodeOther a = encodeOther b) : encode a = encode b := by
 have identity := (exactDecode a).symm.trans ((congrArg decodeOther same).trans (exactDecode b))
 exact congrArg encode identity

theorem noAdditionalDistinction (a b : Formula S)
 (rows : a.composition = b.composition) (sameStructure : a.structureRecord = b.structureRecord) :
 encode a = encode b := by
 cases a; cases b; cases rows; cases sameStructure; rfl

-- Relative mass is read from the held composition at its comparison boundary.
-- Reconstruction is uniform in the boundary's exact mass representation.
def reconstructedMass {Mass : Type} (readComposition : List Coordinate → Mass) (f : Formula S) : Mass :=
 readComposition f.composition

theorem massReconstructed {Mass : Type} (readComposition : List Coordinate → Mass) (f : Formula S) :
 reconstructedMass readComposition (decode (encode f)) = reconstructedMass readComposition f :=
 congrArg (reconstructedMass readComposition) (decodeEncode f)

theorem equalCompositionEqualMass {Mass : Type} (readComposition : List Coordinate → Mass)
 (a b : Formula S) (same : a.composition = b.composition) :
 reconstructedMass readComposition a = reconstructedMass readComposition b :=
 congrArg readComposition same

inductive Generated : Formula S → Prop where
 | one (c : Coordinate) (s : List S) (positive : 0 < c.multiplicity) : Generated (initial c s)
 | next {f : Formula S} (previous : Generated f) (c : Coordinate) (s : List S)
   (positive : 0 < c.multiplicity) : Generated (append f c s)

theorem generatedAdmitted {f : Formula S} (generated : Generated f) : admitted f := by
 induction generated with
 | one c s positive => exact initialAdmitted c s positive
 | next previous c s positive ih => exact successorAdmitted _ c s ih positive

theorem generatedExact {f : Formula S} (_generated : Generated f) : decode (encode f) = f :=
 decodeEncode f

theorem generatedSuffix (tail : List Coordinate) (f : Formula S) (generated : Generated f)
 (positive : ∀ c, c ∈ tail → 0 < c.multiplicity) :
 Generated (⟨f.composition ++ tail, f.structureRecord⟩ : Formula S) := by
 induction tail generalizing f with
 | nil => rw [SFT.Mathematics.CategoryIdentity.appendNil]; exact generated
 | cons c cs ih =>
   have next := Generated.next generated c [] (positive c (List.Mem.head _))
   have rest := ih (append f c []) next (fun row held => positive row (List.Mem.tail _ held))
   change Generated ⟨(f.composition ++ [c]) ++ cs, f.structureRecord ++ []⟩ at rest
   rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative,
       SFT.Mathematics.CategoryIdentity.appendNil] at rest
   exact rest

theorem admittedGenerated (f : Formula S) (valid : admitted f) : Generated f := by
 cases f with
 | mk rows s =>
   cases rows with
   | nil => exact False.elim (valid.1 rfl)
   | cons c cs =>
     have first := Generated.one c s (valid.2 c (List.Mem.head _))
     exact generatedSuffix cs (initial c s) first (fun row held => valid.2 row (List.Mem.tail _ held))

theorem grammarComplete (f : Formula S) : Generated f ↔ admitted f :=
 ⟨generatedAdmitted, admittedGenerated f⟩

theorem successorRetainsStructure (f : Formula S) (c : Coordinate) (s : List S)
 (coordinate : S) (held : coordinate ∈ f.structureRecord) :
 coordinate ∈ (append f c s).structureRecord :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft coordinate f.structureRecord s held

end SFT.Chemistry.FormulaComposition

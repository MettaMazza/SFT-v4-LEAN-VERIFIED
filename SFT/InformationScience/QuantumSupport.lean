import SFT.InformationScience.ClassicalExtension
import SFT.InformationScience.QuantityPositions
namespace SFT.InformationScience.QuantumSupport
open QuantitySupport SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

def completeFoldSupport (labels positions : List String) : Except String (List Word) :=
  if labels.length < 2 || !distinct labels then
    .error "ValueError: quantum support correspondence requires one Fold distinction"
  else if positions.isEmpty || !distinct positions then
    .error "ValueError: support positions must form a nonempty canonical trace"
  else .ok (words labels positions.length)

theorem quantityCorrespondence (labels positions : List String) (support : List Word) :
    completeFoldSupport labels positions = .ok support ↔ completeWordSupport labels positions = .ok support := by
  unfold completeFoldSupport completeWordSupport
  split
  · constructor <;> intro h <;> cases h
  · split
    · constructor <;> intro h <;> cases h
    · exact ⟨fun h => h,fun h => h⟩

theorem supportResult (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) : support = words labels positions.length :=
  QuantitySupport.supportResult _ _ _ ((quantityCorrespondence _ _ _).mp h)

theorem supportAdmission (labels positions : List String) :
    (∃ support, completeFoldSupport labels positions = .ok support) ↔
      ¬ labels.length < 2 ∧ distinct labels = true ∧ positions.isEmpty = false ∧ distinct positions = true := by
  constructor
  · intro ⟨support,h⟩
    exact (QuantitySupport.supportAdmission _ _).mp ⟨support,(quantityCorrespondence _ _ _).mp h⟩
  · intro h
    obtain ⟨support,hs⟩ := (QuantitySupport.supportAdmission _ _).mpr h
    exact ⟨support,(quantityCorrespondence _ _ _).mpr hs⟩

theorem supportDistinct (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) : distinct support = true :=
  admittedSupportDistinct _ _ _ ((quantityCorrespondence _ _ _).mp h)

theorem supportMembership (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) (word : Word) :
    word ∈ support ↔ word.length = positions.length ∧ ∀ label, label ∈ word → label ∈ labels :=
  admittedWord _ _ _ ((quantityCorrespondence _ _ _).mp h) word

structure BranchSupport where
  completeBranchSupport : List Word
  branchProvenance : List (Word × List (String × String))
  amplitudes : String

def superpositionEquivalentSupport (labels positions : List String) : Except String BranchSupport :=
  match completeFoldSupport labels positions with
  | .error e => .error e
  | .ok support => .ok ⟨support,support.map (fun word => (word,positions.zip word)),"not-admitted-at-support-boundary"⟩

theorem branchOutput (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) :
    superpositionEquivalentSupport labels positions = .ok
      ⟨support,support.map (fun word => (word,positions.zip word)),"not-admitted-at-support-boundary"⟩ := by
  unfold superpositionEquivalentSupport
  rw [h]

theorem branchProjection (support : List Word) (positions : List String) :
    (support.map (fun word => (word,positions.zip word))).map Prod.fst = support := by
  induction support with
  | nil => rfl
  | cons word rest ih => exact congrArg (List.cons word) ih

theorem zipRetainsWord (positions : List String) (word : Word) (equal : word.length = positions.length) :
    (positions.zip word).map Prod.snd = word := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases equal
  | cons position rest ih => cases word with
    | nil => cases equal
    | cons label tail => exact congrArg (List.cons label) (ih tail (Nat.succ.inj equal))

theorem zipRetainsPositions (positions : List String) (word : Word) (equal : word.length = positions.length) :
    (positions.zip word).map Prod.fst = positions := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases equal
  | cons position rest ih => cases word with
    | nil => cases equal
    | cons label tail => exact congrArg (List.cons position) (ih tail (Nat.succ.inj equal))

theorem admittedProvenance (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) (word : Word) (member : word ∈ support) :
    (positions.zip word).map Prod.snd = word ∧ (positions.zip word).map Prod.fst = positions := by
  have length := ((supportMembership _ _ _ h word).mp member).1
  exact ⟨zipRetainsWord _ _ length,zipRetainsPositions _ _ length⟩

end SFT.InformationScience.QuantumSupport

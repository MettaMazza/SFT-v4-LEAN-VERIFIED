import SFT.InformationScience.QuantumJoint
namespace SFT.InformationScience.QuantumUnits
open QuantitySupport QuantumSupport
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement SFT.Foundation.Count.Representation

abbrev Cell := String × String × Word × Word

def copies (label : String) : Nat → Word
  | 0 => []
  | n+1 => label :: copies label n

def traceRows (first second : String) (index : Nat) : List String → List Cell
  | [] => []
  | position :: rest =>
    (position,"one-Fold-information-distinction",copies first index ++ first :: copies first rest.length,
      copies first index ++ second :: copies first rest.length) :: traceRows first second (index+1) rest

def checks (support : List Word) (rows : List Cell) : Bool :=
  rows.all (fun row => has support row.2.2.1 && has support row.2.2.2)

def informationUnitTrace (labels positions : List String) : Except String (List Cell) :=
  match completeFoldSupport labels positions with
  | .error e => .error e
  | .ok support => match labels with
    | [] => .error "ValueError: quantum support correspondence requires one Fold distinction"
    | first :: rest => match rest with
      | [] => .error "ValueError: quantum support correspondence requires one Fold distinction"
      | second :: _ =>
        let rows := traceRows first second 0 positions
        if checks support rows then .ok rows
        else .error "ValueError: a support position lacks an independently realized Fold distinction"

theorem copiesLength (label : String) (n : Nat) : (copies label n).length = n := by
  induction n with
  | zero => rfl
  | succ n ih => exact congrArg Nat.succ ih

theorem copiesMember (labels : List String) (label : String) (member : label ∈ labels) (n : Nat) :
    copies label n ∈ words labels n := by
  induction n with
  | zero => exact List.Mem.head _
  | succ n ih => exact (wordsSuccessorMember _ _ _).mpr ⟨label,member,copies label n,ih,rfl⟩

theorem copiesAppend (label : String) (n m : Nat) : copies label (n+m) = copies label n ++ copies label m := by
  induction n with
  | zero => rw [Nat.zero_add]; rfl
  | succ n ih => rw [Nat.succ_add]; exact congrArg (List.cons label) ih

theorem unchangedLeft (first : String) (index after : Nat) :
    copies first index ++ first :: copies first after = copies first (index+(after+1)) :=
  (copiesAppend first index (after+1)).symm

theorem rowAlternatives (labels : List String) (first second : String) (index after : Nat)
    (hf : first ∈ labels) (hs : second ∈ labels) :
    (copies first index ++ first :: copies first after) ∈ words labels (index+(after+1)) ∧
    (copies first index ++ second :: copies first after) ∈ words labels (index+(after+1)) :=
  ⟨independentPosition _ _ _ _ _ _ (copiesMember labels first hf index) (copiesMember labels first hf after) hf,
   independentPosition _ _ _ _ _ _ (copiesMember labels first hf index) (copiesMember labels first hf after) hs⟩

theorem alternativesDistinct (first second : String) (index after : Nat) (different : first ≠ second) :
    copies first index ++ first :: copies first after ≠ copies first index ++ second :: copies first after :=
  positionAlternativesDistinct _ _ _ _ different

theorem traceChecks (labels : List String) (first second : String) (index : Nat) (positions : List String)
    (hf : first ∈ labels) (hs : second ∈ labels) :
    checks (words labels (index+positions.length)) (traceRows first second index positions) = true := by
  induction positions generalizing index with
  | nil => rfl
  | cons position rest ih =>
    have pair := rowAlternatives labels first second index rest.length hf hs
    change (has (words labels (index+(rest.length+1))) (copies first index ++ first :: copies first rest.length) &&
      has (words labels (index+(rest.length+1))) (copies first index ++ second :: copies first rest.length)) &&
      checks (words labels (index+(rest.length+1))) (traceRows first second (index+1) rest) = true
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr pair.1,(hasIff _ _).mpr pair.2⟩,?_⟩
    have size : index+(rest.length+1) = (index+1)+rest.length := by
      rw [Nat.add_assoc,Nat.add_comm 1 rest.length]
    rw [size]
    exact ih (index+1)

theorem admittedTrace (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) :
    ∃ first second tail, labels = first :: second :: tail ∧
      informationUnitTrace labels positions = .ok (traceRows first second 0 positions) := by
  have valid := (QuantumSupport.supportAdmission _ _).mp ⟨support,h⟩
  cases labels with
  | nil => exact False.elim (valid.1 (by decide))
  | cons first rest => cases rest with
    | nil => exact False.elim (valid.1 (by change 1 < 2; decide))
    | cons second tail =>
      refine ⟨first,second,tail,rfl,?_⟩
      unfold informationUnitTrace
      rw [h]
      have checked := traceChecks (first::second::tail) first second 0 positions (List.Mem.head _) (List.Mem.tail first (List.Mem.head _))
      rw [Nat.zero_add] at checked
      change (if checks support (traceRows first second 0 positions) then Except.ok (traceRows first second 0 positions) else Except.error "ValueError: a support position lacks an independently realized Fold distinction") = _
      rw [QuantumSupport.supportResult _ _ _ h,checked]
      rfl

theorem traceLength (first second : String) (index : Nat) (positions : List String) :
    (traceRows first second index positions).length = positions.length := by
  induction positions generalizing index with
  | nil => rfl
  | cons position rest ih => exact congrArg Nat.succ (ih (index+1))

theorem tracePositions (first second : String) (index : Nat) (positions : List String) :
    (traceRows first second index positions).map Prod.fst = positions := by
  induction positions generalizing index with
  | nil => rfl
  | cons position rest ih => exact congrArg (List.cons position) (ih (index+1))

end SFT.InformationScience.QuantumUnits

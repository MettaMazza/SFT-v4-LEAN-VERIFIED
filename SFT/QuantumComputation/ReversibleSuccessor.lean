import SFT.QuantumComputation.ReversibleWitnesses
namespace SFT.QuantumComputation.ReversibleSuccessor
open SFT.QuantumComputation.ReversibleModel
open SFT.QuantumComputation.ReversibleObservation

theorem recordAppend (mapping : Classification) (left right : List (Word × String))
    (one two : List Record) (first : recordBranches mapping left = some one)
    (second : recordBranches mapping right = some two) :
    recordBranches mapping (left ++ right) = some (one ++ two) := by
  induction left generalizing one with
  | nil => cases Option.some.inj first; exact second
  | cons branch rest ih =>
    unfold recordBranches at first
    cases lookup : SFT.InformationScience.EncodingMaps.lookupFirst mapping branch.1 with
    | none => rw [lookup] at first; cases first
    | some label =>
      rw [lookup] at first
      cases tail : recordBranches mapping rest with
      | none => rw [tail] at first; cases first
      | some rows =>
        rw [tail] at first
        cases Option.some.inj first
        change recordBranches mapping (branch :: (rest ++ right)) = _
        rw [recordBranches,lookup]
        change (match recordBranches mapping (rest ++ right) with
          | none => none
          | some rs => some ((branch,label)::rs)) = _
        rw [ih rows tail]
        rfl

theorem recordSuccessor (mapping : Classification) (before : List (Word × String))
    (record : List Record) (branch : Word × String) (label : String)
    (prior : recordBranches mapping before = some record)
    (held : SFT.InformationScience.EncodingMaps.lookupFirst mapping branch.1 = some label) :
    recordBranches mapping (before ++ [branch]) = some (record ++ [(branch,label)]) := by
  apply recordAppend mapping before [branch] record [(branch,label)] prior
  rw [recordBranches,held]
  rfl

theorem earlierRecordRetained (mapping : Classification) (before : List (Word × String))
    (record : List Record) (branch : Word × String) (label : String)
    (prior : recordBranches mapping before = some record)
    (held : SFT.InformationScience.EncodingMaps.lookupFirst mapping branch.1 = some label)
    (row : Record) (earlier : row ∈ record) :
    ∃ result, recordBranches mapping (before ++ [branch]) = some result ∧ row ∈ result :=
  ⟨record ++ [(branch,label)],recordSuccessor mapping before record branch label prior held,
   SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ earlier⟩
open SFT.QuantumComputation.ReversibleComposition

theorem pairAppend (cycle : List String) (left : Word × String) (before after : List (Word × String))
    (one two : List (Word × String)) (first : pairWith cycle left before = some one)
    (second : pairWith cycle left after = some two) :
    pairWith cycle left (before ++ after) = some (one ++ two) := by
  induction before generalizing one with
  | nil => cases Option.some.inj first; exact second
  | cons right rest ih =>
    unfold pairWith at first
    cases cell : jointBranch cycle left right with
    | none => rw [cell] at first; cases first
    | some row =>
      rw [cell] at first
      cases tail : pairWith cycle left rest with
      | none => rw [tail] at first; cases first
      | some rows =>
        rw [tail] at first
        cases Option.some.inj first
        change pairWith cycle left (right :: (rest ++ after)) = _
        rw [pairWith,cell]
        change (match pairWith cycle left (rest ++ after) with
          | none => none
          | some rs => some (row::rs)) = _
        rw [ih rows tail]
        rfl

theorem jointAppend (cycle : List String) (before after right : List (Word × String))
    (one two : List (Word × String)) (first : jointBranches cycle before right = some one)
    (second : jointBranches cycle after right = some two) :
    jointBranches cycle (before ++ after) right = some (one ++ two) := by
  induction before generalizing one with
  | nil => cases Option.some.inj first; exact second
  | cons left rest ih =>
    unfold jointBranches at first
    cases cells : pairWith cycle left right with
    | none => rw [cells] at first; cases first
    | some row =>
      rw [cells] at first
      cases tail : jointBranches cycle rest right with
      | none => rw [tail] at first; cases first
      | some rows =>
        rw [tail] at first
        cases Option.some.inj first
        change jointBranches cycle (left :: (rest ++ after)) right = _
        rw [jointBranches,cells]
        change (match jointBranches cycle (rest ++ after) right with
          | none => none
          | some rs => some (row ++ rs)) = _
        rw [ih rows tail]
        exact congrArg some (SFT.Mathematics.ExactTraceArithmetic.appendAssociative row rows two).symm

theorem phaseAppend (cycle : List String) (amount : Nat) (before after : List (Word × String))
    (one two : List (Word × String)) (first : shiftBranches cycle amount before = some one)
    (second : shiftBranches cycle amount after = some two) :
    shiftBranches cycle amount (before ++ after) = some (one ++ two) := by
  induction before generalizing one with
  | nil => cases Option.some.inj first; exact second
  | cons branch rest ih =>
    obtain ⟨word,phase⟩ := branch
    unfold shiftBranches at first
    cases changed : shiftPhase cycle amount phase with
    | none => rw [changed] at first; cases first
    | some label =>
      rw [changed] at first
      cases tail : shiftBranches cycle amount rest with
      | none => rw [tail] at first; cases first
      | some rows =>
        rw [tail] at first
        cases Option.some.inj first
        change shiftBranches cycle amount ((word,phase) :: (rest ++ after)) = _
        rw [shiftBranches,changed]
        change (match shiftBranches cycle amount (rest ++ after) with
          | none => none
          | some rs => some ((word,label)::rs)) = _
        rw [ih rows tail]
        rfl

theorem supportPositionSuccessor (labels : List String) (depth : Nat) :
    SFT.InformationScience.QuantitySupport.words labels (depth+1) =
    SFT.InformationScience.QuantitySupport.extendWords labels
      (SFT.InformationScience.QuantitySupport.words labels depth) :=
  SFT.InformationScience.QuantitySupport.positionSuccessorOrder labels depth

end SFT.QuantumComputation.ReversibleSuccessor

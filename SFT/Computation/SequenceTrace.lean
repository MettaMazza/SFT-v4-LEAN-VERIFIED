import SFT.Computation.ArithmeticTrace
namespace SFT.Computation.SequenceTrace
open SFT.Foundation.Count.TraceDerivation

-- Every occurrence keeps its position; repeated symbols are not collapsed.
def matchesFrom (start : Nat) : List String → List String → List (List Nat)
 | [], _ => [[]]
 | _ :: _, [] => []
 | wanted :: needle, symbol :: rest =>
     matchesFrom (start+1) (wanted :: needle) rest ++
       if symbol = wanted then (matchesFrom (start+1) needle rest).map (List.cons start) else []

inductive Match : Nat → List String → List String → List Nat → Prop where
 | done (start : Nat) (source : List String) : Match start [] source []
 | skip (start : Nat) (wanted : String) (needle : List String) (symbol : String) (rest : List String) (positions : List Nat)
     (tail : Match (start+1) (wanted :: needle) rest positions) :
     Match start (wanted :: needle) (symbol :: rest) positions
 | take (start : Nat) (wanted : String) (needle rest : List String) (positions : List Nat)
     (tail : Match (start+1) needle rest positions) :
     Match start (wanted :: needle) (wanted :: rest) (start :: positions)

theorem everyMatchGenerated (start : Nat) (needle source : List String) (positions : List Nat)
    (trace : Match start needle source positions) : positions ∈ matchesFrom start needle source := by
  induction trace with
  | done start source => cases source <;> exact .head []
  | skip start wanted needle symbol rest positions tail ih =>
    exact memAppendLeft _ _ _ ih
  | take start wanted needle rest positions tail ih =>
    change (start :: positions) ∈
      matchesFrom (start+1) (wanted :: needle) rest ++
        (if wanted = wanted then (matchesFrom (start+1) needle rest).map (List.cons start) else [])
    rw [ite_eq_left (show wanted = wanted from rfl)]
    exact memAppendRight _ _ _ (memMap (List.cons start) positions _ ih)

theorem generatedMatchTrace (source : List String) (start : Nat) (needle : List String) (positions : List Nat)
    (held : positions ∈ matchesFrom start needle source) : Match start needle source positions := by
  induction source generalizing start needle positions with
  | nil =>
    cases needle with
    | nil =>
      cases held with
      | head => exact .done start []
      | tail _ impossible => cases impossible
    | cons wanted needle => cases held
  | cons symbol rest ih =>
    cases needle with
    | nil =>
      cases held with
      | head => exact .done start (symbol :: rest)
      | tail _ impossible => cases impossible
    | cons wanted needle =>
      cases memAppendCases _ _ _ held with
      | inl skipped => exact .skip _ _ _ _ _ _ (ih _ _ _ skipped)
      | inr selected =>
        by_cases equal : symbol = wanted
        · rw [ite_eq_left equal] at selected
          obtain ⟨tail,member,same⟩ := memMapPreimage (List.cons start) _ _ selected
          cases same; cases equal
          exact .take _ _ _ _ _ (ih _ _ _ member)
        · rw [ite_eq_right equal] at selected; cases selected

theorem completeMatchLedger (start : Nat) (needle source : List String) (positions : List Nat) :
    positions ∈ matchesFrom start needle source ↔ Match start needle source positions :=
  ⟨generatedMatchTrace _ _ _ _,everyMatchGenerated _ _ _ _⟩

theorem matchLength (start : Nat) (needle source : List String) (positions : List Nat)
    (trace : Match start needle source positions) : positions.length = needle.length := by
  induction trace with
  | done => rfl
  | skip start wanted needle symbol rest positions tail ih => exact ih
  | take start wanted needle rest positions tail ih => exact congrArg Nat.succ ih

-- The retained trace reconstructs the matched symbols in source order.
inductive Selection : List String → List String → Prop where
 | empty (source) : Selection [] source
 | skip (wanted needle symbol rest) (tail : Selection (wanted :: needle) rest) :
     Selection (wanted :: needle) (symbol :: rest)
 | take (symbol needle rest) (tail : Selection needle rest) : Selection (symbol :: needle) (symbol :: rest)

theorem matchReconstructs (start : Nat) (needle source : List String) (positions : List Nat)
    (trace : Match start needle source positions) : Selection needle source := by
  induction trace with
  | done => exact .empty _
  | skip start wanted needle symbol rest positions tail ih => exact .skip _ _ _ _ ih
  | take start wanted needle rest positions tail ih => exact .take _ _ _ ih

theorem positionBounds (start : Nat) (needle source : List String) (positions : List Nat)
    (trace : Match start needle source positions) :
    ∀ index, index ∈ positions → start ≤ index ∧ index < start + source.length := by
  induction trace with
  | done => intro index impossible; cases impossible
  | skip start wanted needle symbol rest positions tail ih =>
    intro index held
    have bounds := ih index held
    refine ⟨Nat.le_trans (Nat.le_succ start) bounds.1,?_⟩
    have eq := EnumerationTrace.shiftedIndex start rest.length
    rw [eq] at bounds
    exact bounds.2
  | take start wanted needle rest positions tail ih =>
    intro index held
    cases held with
    | head => exact ⟨Nat.le_refl _,Nat.lt_add_of_pos_right (Nat.zero_lt_succ _)⟩
    | tail _ member =>
      have bounds := ih index member
      refine ⟨Nat.le_trans (Nat.le_succ start) bounds.1,?_⟩
      rw [EnumerationTrace.shiftedIndex start rest.length] at bounds
      exact bounds.2

theorem retainedExtension (start : Nat) (needle source : List String) (positions : List Nat)
    (trace : Match start needle source positions) (fresh : List String) :
    Match start needle (source ++ fresh) positions := by
  induction trace with
  | done => exact .done _ _
  | skip start wanted needle symbol rest positions tail ih => exact .skip _ _ _ _ _ _ ih
  | take start wanted needle rest positions tail ih => exact .take _ _ _ _ _ ih

theorem singletonMatch (start : Nat) (symbol : String) : Match start [symbol] [symbol] [start] :=
  .take _ _ _ _ _ (.done _ _)

theorem exactPositionSymbol (start : Nat) (needle source : List String) (positions : List Nat)
    (trace : Match start needle source positions) :
    ∀ index symbol, (index,symbol) ∈ positions.zip needle →
      ∃ before after, source = before ++ symbol :: after ∧ index = start + before.length := by
  induction trace with
  | done => intro index symbol impossible; cases impossible
  | skip start wanted needle head rest positions tail ih =>
    intro index symbol held
    obtain ⟨before,after,split,position⟩ := ih index symbol held
    refine ⟨head :: before,after,congrArg (List.cons head) split,?_⟩
    exact position.trans (EnumerationTrace.shiftedIndex start before.length)
  | take start wanted needle rest positions tail ih =>
    intro index symbol held
    cases held with
    | head => exact ⟨[],rest,rfl,rfl⟩
    | tail _ member =>
      obtain ⟨before,after,split,position⟩ := ih index symbol member
      exact ⟨wanted :: before,after,congrArg (List.cons wanted) split,
        position.trans (EnumerationTrace.shiftedIndex start before.length)⟩

end SFT.Computation.SequenceTrace

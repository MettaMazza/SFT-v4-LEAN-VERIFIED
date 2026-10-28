import SFT.Computation.StateWords
namespace SFT.Computation.RewritingDerivation
open StateWords
open SFT.InformationScience.QuantitySupport
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

theorem overwriteRows (word : Word) (positions : List String) (held first second : String)
    (length : word.length = positions.length) :
    rewriteRows (rewriteRows word held positions first) held positions second = rewriteRows word held positions second := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases length
  | cons position positions ih => cases word with
    | nil => cases length
    | cons symbol word =>
      change (if position = held then second else if position = held then first else symbol) ::
        rewriteRows (rewriteRows word held positions first) held positions second =
        (if position = held then second else symbol) :: rewriteRows word held positions second
      rw [ih word (Nat.succ.inj length)]
      by_cases h : position = held
      · rw [if_pos h,if_pos h]
      · rw [if_neg h,if_neg h,if_neg h]

theorem commuteRows (word : Word) (positions : List String) (left right first second : String)
    (length : word.length = positions.length) (different : left ≠ right) :
    rewriteRows (rewriteRows word left positions first) right positions second =
      rewriteRows (rewriteRows word right positions second) left positions first := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases length
  | cons position positions ih => cases word with
    | nil => cases length
    | cons symbol word =>
      change (if position = right then second else if position = left then first else symbol) ::
        rewriteRows (rewriteRows word left positions first) right positions second =
        (if position = left then first else if position = right then second else symbol) ::
        rewriteRows (rewriteRows word right positions second) left positions first
      rw [ih word (Nat.succ.inj length)]
      by_cases hl : position = left
      · have hr : position ≠ right := fun hr => different (hl.symm.trans hr)
        rw [if_neg hr,if_pos hl,if_pos hl]
      · by_cases hr : position = right
        · rw [if_pos hr,if_neg hl,if_pos hr]
        · rw [if_neg hr,if_neg hl,if_neg hl,if_neg hr]

theorem rewriteSuccessorAdmitted (word result : Word) (positions : List String) (held first second : String)
    (h : exactRewrite word held positions first = .ok result) :
    exactRewrite result held positions second = .ok (rewriteRows word held positions second) := by
  have p := (rewriteMeaning _ _ _ _ _).mp h
  apply (rewriteMeaning _ _ _ _ _).mpr
  refine ⟨p.1,?_,p.2.2.1,?_⟩
  · rw [p.2.2.2,rewriteLength word held positions first p.2.1]; exact p.2.1
  · rw [p.2.2.2,overwriteRows word positions held first second p.2.1]

theorem rewriteIdempotent (word result : Word) (positions : List String) (held replacement : String)
    (h : exactRewrite word held positions replacement = .ok result) :
    exactRewrite result held positions replacement = .ok result := by
  have again := rewriteSuccessorAdmitted word result positions held replacement replacement h
  rw [← ((rewriteMeaning _ _ _ _ _).mp h).2.2.2] at again
  exact again

-- Retained step records interpret the source topic's rule identity and held position.
structure Record where
  ruleIdentity : String
  heldPosition : String
  replacement : String
  source : Word
  successor : Word

def Replays (positions : List String) (record : Record) : Prop :=
  exactRewrite record.source record.heldPosition positions record.replacement = .ok record.successor

theorem recordLength (positions : List String) (record : Record) (h : Replays positions record) :
    record.successor.length = record.source.length := by
  have p := (rewriteMeaning _ _ _ _ _).mp h
  rw [p.2.2.2]
  exact rewriteLength _ _ _ _ p.2.1

theorem recordCoordinate (positions : List String) (record : Record) (h : Replays positions record)
    (position symbol : String) (occurrence : (position,symbol) ∈ positions.zip record.source) :
    (position,if position = record.heldPosition then record.replacement else symbol) ∈ positions.zip record.successor := by
  have p := (rewriteMeaning _ _ _ _ _).mp h
  rw [p.2.2.2]
  exact rewriteCoordinate _ _ _ _ p.2.1 _ _ occurrence

inductive Trace (positions : List String) : Word → List Record → Word → Prop
 | identity (word) : Trace positions word [] word
 | next (record records terminal) (valid : Replays positions record)
     (rest : Trace positions record.successor records terminal) :
     Trace positions record.source (record::records) terminal

theorem traceLengthPreserved (positions : List String) (initial terminal : Word) (records : List Record)
    (h : Trace positions initial records terminal) : terminal.length = initial.length := by
  induction h with
  | identity => rfl
  | next record records terminal valid rest ih => exact ih.trans (recordLength _ _ valid)

theorem traceComposition (positions : List String) (initial middle terminal : Word) (left right : List Record)
    (first : Trace positions initial left middle) (second : Trace positions middle right terminal) :
    Trace positions initial (left ++ right) terminal := by
  induction first with
  | identity => exact second
  | next record records endState valid rest ih => exact .next _ _ _ valid (ih second)

theorem traceRecordsReplay (positions : List String) (initial terminal : Word) (records : List Record)
    (h : Trace positions initial records terminal) : ∀ record, record ∈ records → Replays positions record := by
  induction h with
  | identity => intro record member; cases member
  | next record records terminal valid rest ih =>
    intro selected member
    cases member with
    | head => exact valid
    | tail _ hm => exact ih selected hm

end SFT.Computation.RewritingDerivation

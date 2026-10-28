import SFT.Computation.HaltingBoundary
namespace SFT.Computation.EnumerationTrace
open RecognitionDomain
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects

-- Positional reconstruction of the original ordered tuple, without installing
-- a new string parser or changing its canonical position-n labels.
def atPosition {α : Type} : List α → Nat → Option α
 | [], _ => none
 | item :: _, 0 => some item
 | _ :: rest, index+1 => atPosition rest index

theorem atMember {α : Type} (items : List α) (index : Nat) (item : α)
    (found : atPosition items index = some item) : item ∈ items := by
  induction items generalizing index with
  | nil => cases found
  | cons head rest ih =>
    cases index with
    | zero => cases found; exact .head rest
    | succ index => exact .tail head (ih index found)

theorem shiftedIndex (start index : Nat) : start + 1 + index = start + (index + 1) := by
  rw [Nat.add_assoc,Nat.add_comm 1 index]

theorem positionReconstruction (descriptions : List String) (start index : Nat) (description : String)
    (found : atPosition descriptions index = some description) :
    atPosition (enumerateRows start descriptions) index =
      some (SFT.Host.Text.append "position-" (toString (start+index)),description) := by
  induction descriptions generalizing start index with
  | nil => cases found
  | cons head rest ih =>
    cases index with
    | zero => cases found; rfl
    | succ index =>
      have next := ih (start+1) index found
      rw [shiftedIndex] at next
      exact next

theorem outsideSupport {α : Type} (items : List α) (index : Nat) (bound : items.length ≤ index) :
    atPosition items index = none := by
  induction items generalizing index with
  | nil => rfl
  | cons head rest ih =>
    cases index with
    | zero => cases bound
    | succ index => exact ih index (Nat.le_of_succ_le_succ bound)

theorem retainedAppend (left right : List String) (start : Nat) :
    enumerateRows start (left ++ right) =
      enumerateRows start left ++ enumerateRows (start + left.length) right := by
  induction left generalizing start with
  | nil => rfl
  | cons head rest ih =>
    change (SFT.Host.Text.append "position-" (toString start),head) ::
      enumerateRows (start+1) (rest ++ right) = _
    rw [ih,shiftedIndex]
    rfl

theorem admittedNoDuplicates (descriptions : List String) (rows : List (String × String))
    (passed : completeEnumeration descriptions = .ok rows) :
    distinct (rows.map Prod.snd) = true := by
  rw [(domainReconstructed _ _ passed).1]
  exact ((enumerationMeaning _ _).mp passed).1

theorem admittedSuccessor (descriptions : List String) (fresh : String)
    (before after : List (String × String))
    (old : completeEnumeration descriptions = .ok before)
    (extended : completeEnumeration (descriptions ++ [fresh]) = .ok after) :
    after = before ++ [(SFT.Host.Text.append "position-" (toString (1+descriptions.length)),fresh)] := by
  rw [(enumerationMeaning _ _).mp extended |>.2.2,(enumerationMeaning _ _).mp old |>.2.2]
  exact retainedAppend descriptions [fresh] 1

theorem oneDescription (description : String) :
    completeEnumeration [description] = .ok [("position-1",description)] := rfl

open SFT.InformationScience EncodingClasses EncodingMaps EncodingDecoder
open UniversalInterpretation

theorem recognizerLink (descriptions : List String) (rows : List (String × String))
    (enumerated : completeEnumeration descriptions = .ok rows)
    (index : Nat) (description : String) (found : atPosition descriptions index = some description)
    (support : List Codeword) (encoding : Encoding) (decoder : Decoder)
    (valid : validateEncoding descriptions support encoding = true)
    (inverse : exactDecoder descriptions encoding = some decoder)
    (registry : List (String × Request)) (request : Request)
    (selected : lookupFirst registry description = some request) :
    ∃ code, code ∈ support ∧
      atPosition rows index = some (SFT.Host.Text.append "position-" (toString (1+index)),description) ∧
      interpret registry decoder code = some (StateTransition.run request.machine request.initial request.actions) := by
  obtain ⟨code,bound,lookup,decoded⟩ := ModelEncoding.finiteRoundTrip _ _ _ valid _ inverse description
    (atMember _ _ _ found)
  have position := positionReconstruction descriptions 1 index description found
  rw [← (enumerationMeaning _ _).mp enumerated |>.2.2] at position
  exact ⟨code,bound,position,exactRequest _ _ _ _ _ decoded selected⟩

end SFT.Computation.EnumerationTrace

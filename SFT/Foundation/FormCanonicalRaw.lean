import SFT.Foundation.FormIdentity
namespace SFT.Foundation.FormCanonicalRaw
open FormConstruction FormValidation FormIdentity

def invalid : Except String TupleValue := .error "ValueError: form is outside the admitted grammar"

def combine (left : Except String TupleValue) (right : Unit → Except String TupleValue) : Except String TupleValue :=
  match left with
  | .error e => .error e
  | .ok l => match right () with
    | .error e => .error e
    | .ok r => .ok (.tuple [.text "Fold",.text "held-a",l,.text "held-b",r,.text "return"])

def guarded (validation : Except String Bool) (body : Unit → Except String TupleValue) : Except String TupleValue :=
  match validation with
  | .error e => .error e
  | .ok false => invalid
  | .ok true => body ()

/-! Source canonical_trace: validate first, preserving errors, then recursively
emit the exact ordered tuple. Fallback branches are unreachable after acceptance. -/
def canonical : TupleValue → Except String TupleValue
  | .text s => guarded (valid (.text s)) (fun _ => invalid)
  | .list values => guarded (valid (.list values)) (fun _ => invalid)
  | .tuple values => guarded (valid (.tuple values)) (fun _ =>
    match values with
    | [] => invalid
    | _tag::rest => match rest with
      | [] => .ok (.tuple [.text "One"])
      | left::rest => match rest with
        | [] => invalid
        | right::rest => match rest with
          | [] => invalid
          | _ret::rest => match rest with
            | _::_ => invalid
            | [] => match left with
              | .text _ => invalid
              | .tuple ls => match ls with
                | [] => invalid
                | _a::ls => match ls with
                  | [] => invalid
                  | l::_ => match right with
                    | .text _ => invalid
                    | .tuple rs => match rs with
                      | [] => invalid
                      | _b::rs => match rs with
                        | [] => invalid
                        | r::_ => combine (canonical l) (fun _ => canonical r)
                    | .list rs => match rs with
                      | [] => invalid
                      | _b::rs => match rs with
                        | [] => invalid
                        | r::_ => combine (canonical l) (fun _ => canonical r)
              | .list ls => match ls with
                | [] => invalid
                | _a::ls => match ls with
                  | [] => invalid
                  | l::_ => match right with
                    | .text _ => invalid
                    | .tuple rs => match rs with
                      | [] => invalid
                      | _b::rs => match rs with
                        | [] => invalid
                        | r::_ => combine (canonical l) (fun _ => canonical r)
                    | .list rs => match rs with
                      | [] => invalid
                      | _b::rs => match rs with
                        | [] => invalid
                        | r::_ => combine (canonical l) (fun _ => canonical r)
    )
termination_by structural value => value

theorem generatedTrace (form : Form) : canonical (encode form) = .ok (canonicalTrace form) := by
  induction form with
  | one => rfl
  | fold left right ihl ihr =>
    rw [canonical.eq_def]
    change guarded (valid (encode (.fold left right))) (fun _ => combine (canonical (encode left)) (fun _ => canonical (encode right))) = _
    rw [generatedFormsValid]
    change combine (canonical (encode left)) (fun _ => canonical (encode right)) = _
    rw [ihl]
    dsimp only [combine]
    rw [ihr]
    rfl

theorem textRejected (text : String) : canonical (.text text) = invalid := rfl

theorem missingEdgePreservesError : canonical (.tuple [.text "Fold",.tuple [],encode .one,.text "return"]) =
    .error "IndexError: tuple index out of range" := rfl

theorem oneChildRejected : canonical (.tuple [.text "Fold",.tuple [.text "held-a",encode .one],.text "return"]) = invalid := rfl

theorem acceptedHasCanonicalForm (value : TupleValue) (h : FormAcceptance.Accepted value) :
    ∃ form : Form, canonical value = .ok (canonicalTrace form) := by
  induction h with
  | one tag named =>
    refine ⟨.one, ?_⟩
    rw [canonical.eq_def]
    change guarded (.ok (isText tag "One")) (fun _ => .ok (.tuple [.text "One"])) = _
    rw [named]
    rfl
  | fold tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr ihl ihr =>
    obtain ⟨l, eql⟩ := ihl
    obtain ⟨r, eqr⟩ := ihr
    refine ⟨.fold l r, ?_⟩
    rw [canonical.eq_def]
    dsimp only
    rw [FormAcceptance.validOfAccepted _ (FormAcceptance.Accepted.fold tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr)]
    change combine (canonical left) (fun _ => canonical right) = _
    rw [eql]
    dsimp only [combine]
    rw [eqr]
    rfl
  | foldListLeft tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr ihl ihr =>
    obtain ⟨l, eql⟩ := ihl
    obtain ⟨r, eqr⟩ := ihr
    refine ⟨.fold l r, ?_⟩
    rw [canonical.eq_def]
    dsimp only
    rw [FormAcceptance.validOfAccepted _ (FormAcceptance.Accepted.foldListLeft tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr)]
    change combine (canonical left) (fun _ => canonical right) = _
    rw [eql]
    dsimp only [combine]
    rw [eqr]
    rfl
  | foldListRight tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr ihl ihr =>
    obtain ⟨l, eql⟩ := ihl
    obtain ⟨r, eqr⟩ := ihr
    refine ⟨.fold l r, ?_⟩
    rw [canonical.eq_def]
    dsimp only
    rw [FormAcceptance.validOfAccepted _ (FormAcceptance.Accepted.foldListRight tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr)]
    change combine (canonical left) (fun _ => canonical right) = _
    rw [eql]
    dsimp only [combine]
    rw [eqr]
    rfl
  | foldLists tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr ihl ihr =>
    obtain ⟨l, eql⟩ := ihl
    obtain ⟨r, eqr⟩ := ihr
    refine ⟨.fold l r, ?_⟩
    rw [canonical.eq_def]
    dsimp only
    rw [FormAcceptance.validOfAccepted _ (FormAcceptance.Accepted.foldLists tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr)]
    change combine (canonical left) (fun _ => canonical right) = _
    rw [eql]
    dsimp only [combine]
    rw [eqr]
    rfl

theorem validHasCanonicalForm (value : TupleValue) (h : valid value = .ok true) :
    ∃ form : Form, canonical value = .ok (canonicalTrace form) :=
  acceptedHasCanonicalForm value (FormAcceptance.acceptedOfValid value h)

end SFT.Foundation.FormCanonicalRaw

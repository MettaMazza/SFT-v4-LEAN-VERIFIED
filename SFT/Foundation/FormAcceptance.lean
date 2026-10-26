import SFT.Foundation.FormValidation

/-! Finite production traces for the source validator's accepted tuple/string
values, retaining ignored edge tails rather than imposing a stricter parser. -/
namespace SFT.Foundation.FormAcceptance
open FormConstruction FormValidation

inductive Accepted : TupleValue → Prop where
  | one (tag : TupleValue) (named : isText tag "One" = true) : Accepted (.tuple [tag])
  | fold (tag a b ret left right : TupleValue) (extraLeft extraRight : List TupleValue)
      (named : isText tag "Fold" = true) (heldA : isText a "held-a" = true)
      (heldB : isText b "held-b" = true) (returns : isText ret "return" = true)
      (leftGenerated : Accepted left) (rightGenerated : Accepted right) :
      Accepted (.tuple [tag,.tuple (a::left::extraLeft),.tuple (b::right::extraRight),ret])

theorem shortAndTrue (left : Except String Bool) (right : Unit → Except String Bool)
    (h : shortAnd left right = .ok true) : left = .ok true ∧ right () = .ok true := by
  cases left with
  | error e => cases h
  | ok b => cases b with
    | false => cases h
    | true => exact ⟨rfl,h⟩

theorem acceptedOfValid (value : TupleValue) (h : valid value = .ok true) : Accepted value := by
  cases value with
  | text s => cases h
  | tuple values =>
    cases values with
    | nil => cases h
    | cons tag rest =>
      cases rest with
      | nil => exact Accepted.one tag (Except.ok.inj h)
      | cons left rest =>
        cases rest with
        | nil => cases h
        | cons right rest =>
          cases rest with
          | nil => cases h
          | cons ret rest =>
            cases rest with
            | cons extra more => cases h
            | nil =>
              rw [valid.eq_def] at h
              dsimp only at h
              split at h
              next named =>
                cases left with
                | text s => dsimp only at h; split at h <;> cases h
                | tuple items =>
                  cases items with
                  | nil => cases h
                  | cons a leftTail =>
                    dsimp only at h
                    split at h
                    next heldA =>
                      cases right with
                      | text s => dsimp only at h; split at h <;> cases h
                      | tuple items =>
                        cases items with
                        | nil => cases h
                        | cons b rightTail =>
                          dsimp only at h
                          split at h
                          next heldB =>
                            split at h
                            next returns =>
                              cases leftTail with
                              | nil => cases h
                              | cons l extraLeft =>
                                have both := shortAndTrue _ _ h
                                cases rightTail with
                                | nil => cases both.2
                                | cons r extraRight =>
                                  exact Accepted.fold tag a b ret l r extraLeft extraRight named heldA heldB returns
                                    (acceptedOfValid l both.1) (acceptedOfValid r both.2)
                            next noReturn => cases h
                          next noB => cases h
                    next noA => cases h
              next noName => cases h
termination_by structural value

theorem validOfAccepted (value : TupleValue) (h : Accepted value) : valid value = .ok true := by
  induction h with
  | one tag named => exact congrArg Except.ok named
  | fold tag a b ret left right extraLeft extraRight named heldA heldB returns hl hr ihl ihr =>
    rw [valid,ite_eq_left named,ite_eq_left heldA,ite_eq_left heldB,ite_eq_left returns]
    change shortAnd (valid left) (fun _ => valid right) = .ok true
    rw [ihl]
    exact ihr

theorem validityIffFiniteProduction (value : TupleValue) : valid value = .ok true ↔ Accepted value :=
  ⟨acceptedOfValid value,validOfAccepted value⟩

end SFT.Foundation.FormAcceptance

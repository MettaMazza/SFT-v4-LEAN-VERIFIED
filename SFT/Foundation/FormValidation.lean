import SFT.Foundation.FormConstruction

/-! valid_form on finite tuple/list/string source values. Preserve source access
order, IndexError outcomes and ignored trailing edge items exactly. -/
namespace SFT.Foundation.FormValidation
open FormConstruction

def isText (value : TupleValue) (text : String) : Bool :=
  match value with
  | .text s => SFT.Host.Text.equal s text
  | .tuple _ => false
  | .list _ => false

def shortAnd (left : Except String Bool) (right : Unit → Except String Bool) : Except String Bool :=
  match left with
  | .error e => .error e
  | .ok false => .ok false
  | .ok true => right ()

def valid : TupleValue → Except String Bool
  | .text _ => .ok false
  | .list _ => .ok false
  | .tuple values =>
    match values with
    | [] => .ok false
    | tag::rest => match rest with
      | [] => .ok (isText tag "One")
      | left::rest => match rest with
        | [] => .ok false
        | right::rest => match rest with
          | [] => .ok false
          | ret::rest => match rest with
            | _::_ => .ok false
            | [] =>
                if isText tag "Fold" then
                  match left with
                  | .text s => if s.isEmpty then .error "IndexError: string index out of range" else .ok false
                  | .tuple items => match items with
                    | [] => .error "IndexError: tuple index out of range"
                    | label::leftTail =>
                      if isText label "held-a" then
                        match right with
                        | .text s => if s.isEmpty then .error "IndexError: string index out of range" else .ok false
                        | .tuple items => match items with
                          | [] => .error "IndexError: tuple index out of range"
                          | label::rightTail =>
                            if isText label "held-b" then
                              if isText ret "return" then
                                match leftTail with
                                | [] => .error "IndexError: tuple index out of range"
                                | child::_ => shortAnd (valid child) (fun _ => match rightTail with
                                    | [] => .error "IndexError: tuple index out of range"
                                    | child::_ => valid child)
                              else .ok false
                            else .ok false
                        | .list items => match items with
                          | [] => .error "IndexError: list index out of range"
                          | label::rightTail =>
                            if isText label "held-b" then
                              if isText ret "return" then
                                match leftTail with
                                | [] => .error "IndexError: tuple index out of range"
                                | child::_ => shortAnd (valid child) (fun _ => match rightTail with
                                    | [] => .error "IndexError: list index out of range"
                                    | child::_ => valid child)
                              else .ok false
                            else .ok false
                      else .ok false
                  | .list items => match items with
                    | [] => .error "IndexError: list index out of range"
                    | label::leftTail =>
                      if isText label "held-a" then
                        match right with
                        | .text s => if s.isEmpty then .error "IndexError: string index out of range" else .ok false
                        | .tuple items => match items with
                          | [] => .error "IndexError: tuple index out of range"
                          | label::rightTail =>
                            if isText label "held-b" then
                              if isText ret "return" then
                                match leftTail with
                                | [] => .error "IndexError: list index out of range"
                                | child::_ => shortAnd (valid child) (fun _ => match rightTail with
                                    | [] => .error "IndexError: tuple index out of range"
                                    | child::_ => valid child)
                              else .ok false
                            else .ok false
                        | .list items => match items with
                          | [] => .error "IndexError: list index out of range"
                          | label::rightTail =>
                            if isText label "held-b" then
                              if isText ret "return" then
                                match leftTail with
                                | [] => .error "IndexError: list index out of range"
                                | child::_ => shortAnd (valid child) (fun _ => match rightTail with
                                    | [] => .error "IndexError: list index out of range"
                                    | child::_ => valid child)
                              else .ok false
                            else .ok false
                      else .ok false
                else .ok false
termination_by structural value => value

theorem oneValid : valid (encode .one) = .ok true := rfl

theorem foldEvaluation (left right : TupleValue) (extraLeft extraRight : List TupleValue) :
    valid (.tuple [.text "Fold",.tuple (.text "held-a"::left::extraLeft),
      .tuple (.text "held-b"::right::extraRight),.text "return"]) =
    (match valid left with
      | .error e => .error e
      | .ok false => .ok false
      | .ok true => valid right) := by
  rw [valid]
  rfl

theorem generatedFormsValid (form : Form) : valid (encode form) = .ok true := by
  induction form with
  | one => rfl
  | fold left right ihl ihr =>
    change valid (.tuple [.text "Fold",.tuple [.text "held-a",encode left],
      .tuple [.text "held-b",encode right],.text "return"]) = .ok true
    rw [foldEvaluation,ihl]
    exact ihr

theorem oneChildRejected (child : TupleValue) :
    valid (.tuple [.text "Fold",.tuple [.text "held-a",child],.text "return"]) = .ok false := rfl

theorem sameLabelRejected (left right : TupleValue) :
    valid (.tuple [.text "Fold",.tuple [.text "held-a",left],
      .tuple [.text "held-a",right],.text "return"]) = .ok false := by
  rw [valid]
  rfl

theorem edgeTailIgnored (left right : TupleValue) (extraLeft extraRight : List TupleValue) :
    valid (.tuple [.text "Fold",.tuple (.text "held-a"::left::extraLeft),
      .tuple (.text "held-b"::right::extraRight),.text "return"]) =
    valid (.tuple [.text "Fold",.tuple [.text "held-a",left],
      .tuple [.text "held-b",right],.text "return"]) := by
  rw [foldEvaluation,foldEvaluation]

theorem missingLeftLabelErrors (right ret : TupleValue) :
    valid (.tuple [.text "Fold",.tuple [],right,ret]) = .error "IndexError: tuple index out of range" := rfl

theorem wrongReturnPrecedesMissingChild :
    valid (.tuple [.text "Fold",.tuple [.text "held-a"],.tuple [.text "held-b"],.text "wrong"]) = .ok false := rfl

theorem leftFalsePrecedesMissingRightChild :
    valid (.tuple [.text "Fold",.tuple [.text "held-a",.text "not-a-form"],
      .tuple [.text "held-b"],.text "return"]) = .ok false := rfl

theorem missingLeftChildErrors :
    valid (.tuple [.text "Fold",.tuple [.text "held-a"],.tuple [.text "held-b"],.text "return"]) =
      .error "IndexError: tuple index out of range" := rfl

theorem listEdgesEvaluation (left right : TupleValue) (extraLeft extraRight : List TupleValue) :
    valid (.tuple [.text "Fold",.list (.text "held-a"::left::extraLeft),
      .list (.text "held-b"::right::extraRight),.text "return"]) =
    (match valid left with
      | .error e => .error e
      | .ok false => .ok false
      | .ok true => valid right) := by
  rw [valid]
  rfl

theorem mixedLeftListEvaluation (left right : TupleValue) :
    valid (.tuple [.text "Fold",.list [.text "held-a",left],
      .tuple [.text "held-b",right],.text "return"]) =
    shortAnd (valid left) (fun _ => valid right) := by rw [valid]; rfl

theorem mixedRightListEvaluation (left right : TupleValue) :
    valid (.tuple [.text "Fold",.tuple [.text "held-a",left],
      .list [.text "held-b",right],.text "return"]) =
    shortAnd (valid left) (fun _ => valid right) := by rw [valid]; rfl

theorem listFormRejected (values : List TupleValue) : valid (.list values) = .ok false := rfl

theorem missingListLabelErrors (right ret : TupleValue) :
    valid (.tuple [.text "Fold",.list [],right,ret]) = .error "IndexError: list index out of range" := rfl

theorem missingListChildErrors :
    valid (.tuple [.text "Fold",.list [.text "held-a"],.tuple [.text "held-b",encode .one],.text "return"]) =
    .error "IndexError: list index out of range" := rfl

end SFT.Foundation.FormValidation

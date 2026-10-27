import SFT.Foundation.FormEquivalenceRaw
open SFT.Foundation.FormConstruction SFT.Foundation.FormValidation
open SFT.Foundation.FormCanonicalRaw SFT.Foundation.FormIdentity SFT.Foundation.FormEquivalenceRaw
def one : TupleValue := encode .one
def lists : TupleValue := .tuple [.text "Fold", .list [.text "held-a",one], .list [.text "held-b",one], .text "return"]
example : valid lists = .ok true := rfl
example : canonical lists = .ok (canonicalTrace first) := rfl
example : equivalent lists (encode first) = .ok true := rfl
example : valid (.list [.text "One"]) = .ok false := rfl
example : valid (.tuple [.text "Fold", .list [.text "held-a",one,.text "ignored"], .list [.text "held-b",one,.text "ignored"], .text "return"]) = .ok true := rfl
example : valid (.tuple [.text "Fold", .list [.text "held-a",lists], .tuple [.text "held-b",one], .text "return"]) = .ok true := rfl
example : valid (.tuple [.text "Fold", .tuple [.text "held-a",one], .list [.text "held-b",lists], .text "return"]) = .ok true := rfl
example : valid (.tuple [.text "Fold", .list [], .tuple [], .text "wrong"]) = .error "IndexError: list index out of range" := rfl
example : valid (.tuple [.text "Fold", .list [.text "wrong"], .list [], .text "return"]) = .ok false := rfl
example : valid (.tuple [.text "Fold", .list [.text "held-a"], .tuple [], .text "return"]) = .error "IndexError: tuple index out of range" := rfl
example : valid (.tuple [.text "Fold", .tuple [.text "held-a"], .list [], .text "return"]) = .error "IndexError: list index out of range" := rfl
example : valid (.tuple [.text "Fold", .list [.text "held-a"], .tuple [.text "held-b"], .text "wrong"]) = .ok false := rfl
example : valid (.tuple [.text "Fold", .list [.text "held-a",.text "invalid"], .list [.text "held-b"], .text "return"]) = .ok false := rfl
example : canonical (.tuple [.text "Fold", .list [.text "held-a",one], .list [.text "held-b"], .text "return"]) = .error "IndexError: list index out of range" := rfl
example : canonical (.list [.text "One"]) = .error "ValueError: form is outside the admitted grammar" := rfl

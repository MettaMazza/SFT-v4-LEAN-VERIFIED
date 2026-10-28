import SFT.Computation.BindingLedger
open SFT.Computation.BindingTerms SFT.Computation.BindingSubstitution SFT.Computation.BindingLedger

def input : Term := .abs "y" (.abs "u" (.app (.var "y") (.var "x")))
def output : Term := .abs "u" (.abs "u" (.app (.var "u") (.var "y")))
example : free input "x" = true := rfl
example : ("y" : String) ≠ "u" := by decide
example : substitute input "x" (.var "y") = .ok output := rfl
example : ledger [] [] input = [⟨[.body,.body,.left],"y",some []⟩,⟨[.body,.body,.right],"x",none⟩] := rfl
example : ledger [] [] output = [⟨[.body,.body,.left],"u",some [.body]⟩,⟨[.body,.body,.right],"y",none⟩] := rfl
#eval "PASS: source substitution changes an existing bound occurrence with a free target and distinct input binder labels"

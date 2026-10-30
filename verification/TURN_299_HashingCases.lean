import SFT.Computation.Hashing
open SFT.Computation.Hashing
def m0 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "u" else if x = "b" then "u" else "u"
  outputBound := by
    intro x held; cases held with
    | head => exact .head _
    | tail _ held => cases held with
      | head => exact .head _
      | tail _ held => cases held with
        | head => exact .head _
        | tail _ held => cases held
example : fibre m0 "u" = ["a","b","c"] := rfl
example : fibre m0 "v" = [] := rfl
example : collisions m0 = [("a","b"),("a","c"),("b","a"),("b","c"),("c","a"),("c","b")] := rfl
example : preimages m0 = [("u",["a","b","c"]),("v",[])] := rfl
theorem collisionWitness0 : ∃ a b, a ∈ m0.messages ∧ b ∈ m0.messages ∧ a ≠ b ∧ m0.transform a = m0.transform b :=
  largerDomainWitness m0 (by decide) (by decide)
#print axioms collisionWitness0
def m1 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "u" else if x = "b" then "u" else "v"
  outputBound := by
    intro x held; cases held with
    | head => exact .head _
    | tail _ held => cases held with
      | head => exact .head _
      | tail _ held => cases held with
        | head => exact .tail _ (.head _)
        | tail _ held => cases held
example : fibre m1 "u" = ["a","b"] := rfl
example : fibre m1 "v" = ["c"] := rfl
example : collisions m1 = [("a","b"),("b","a")] := rfl
example : preimages m1 = [("u",["a","b"]),("v",["c"])] := rfl
theorem collisionWitness1 : ∃ a b, a ∈ m1.messages ∧ b ∈ m1.messages ∧ a ≠ b ∧ m1.transform a = m1.transform b :=
  largerDomainWitness m1 (by decide) (by decide)
#print axioms collisionWitness1
def m2 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "u" else if x = "b" then "v" else "u"
  outputBound := by
    intro x held; cases held with
    | head => exact .head _
    | tail _ held => cases held with
      | head => exact .tail _ (.head _)
      | tail _ held => cases held with
        | head => exact .head _
        | tail _ held => cases held
example : fibre m2 "u" = ["a","c"] := rfl
example : fibre m2 "v" = ["b"] := rfl
example : collisions m2 = [("a","c"),("c","a")] := rfl
example : preimages m2 = [("u",["a","c"]),("v",["b"])] := rfl
theorem collisionWitness2 : ∃ a b, a ∈ m2.messages ∧ b ∈ m2.messages ∧ a ≠ b ∧ m2.transform a = m2.transform b :=
  largerDomainWitness m2 (by decide) (by decide)
#print axioms collisionWitness2
def m3 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "u" else if x = "b" then "v" else "v"
  outputBound := by
    intro x held; cases held with
    | head => exact .head _
    | tail _ held => cases held with
      | head => exact .tail _ (.head _)
      | tail _ held => cases held with
        | head => exact .tail _ (.head _)
        | tail _ held => cases held
example : fibre m3 "u" = ["a"] := rfl
example : fibre m3 "v" = ["b","c"] := rfl
example : collisions m3 = [("b","c"),("c","b")] := rfl
example : preimages m3 = [("u",["a"]),("v",["b","c"])] := rfl
theorem collisionWitness3 : ∃ a b, a ∈ m3.messages ∧ b ∈ m3.messages ∧ a ≠ b ∧ m3.transform a = m3.transform b :=
  largerDomainWitness m3 (by decide) (by decide)
#print axioms collisionWitness3
def m4 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "v" else if x = "b" then "u" else "u"
  outputBound := by
    intro x held; cases held with
    | head => exact .tail _ (.head _)
    | tail _ held => cases held with
      | head => exact .head _
      | tail _ held => cases held with
        | head => exact .head _
        | tail _ held => cases held
example : fibre m4 "u" = ["b","c"] := rfl
example : fibre m4 "v" = ["a"] := rfl
example : collisions m4 = [("b","c"),("c","b")] := rfl
example : preimages m4 = [("u",["b","c"]),("v",["a"])] := rfl
theorem collisionWitness4 : ∃ a b, a ∈ m4.messages ∧ b ∈ m4.messages ∧ a ≠ b ∧ m4.transform a = m4.transform b :=
  largerDomainWitness m4 (by decide) (by decide)
#print axioms collisionWitness4
def m5 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "v" else if x = "b" then "u" else "v"
  outputBound := by
    intro x held; cases held with
    | head => exact .tail _ (.head _)
    | tail _ held => cases held with
      | head => exact .head _
      | tail _ held => cases held with
        | head => exact .tail _ (.head _)
        | tail _ held => cases held
example : fibre m5 "u" = ["b"] := rfl
example : fibre m5 "v" = ["a","c"] := rfl
example : collisions m5 = [("a","c"),("c","a")] := rfl
example : preimages m5 = [("u",["b"]),("v",["a","c"])] := rfl
theorem collisionWitness5 : ∃ a b, a ∈ m5.messages ∧ b ∈ m5.messages ∧ a ≠ b ∧ m5.transform a = m5.transform b :=
  largerDomainWitness m5 (by decide) (by decide)
#print axioms collisionWitness5
def m6 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "v" else if x = "b" then "v" else "u"
  outputBound := by
    intro x held; cases held with
    | head => exact .tail _ (.head _)
    | tail _ held => cases held with
      | head => exact .tail _ (.head _)
      | tail _ held => cases held with
        | head => exact .head _
        | tail _ held => cases held
example : fibre m6 "u" = ["c"] := rfl
example : fibre m6 "v" = ["a","b"] := rfl
example : collisions m6 = [("a","b"),("b","a")] := rfl
example : preimages m6 = [("u",["c"]),("v",["a","b"])] := rfl
theorem collisionWitness6 : ∃ a b, a ∈ m6.messages ∧ b ∈ m6.messages ∧ a ≠ b ∧ m6.transform a = m6.transform b :=
  largerDomainWitness m6 (by decide) (by decide)
#print axioms collisionWitness6
def m7 : Model where
  messages := ["a","b","c"]
  outputs := ["u","v"]
  transform := fun x => if x = "a" then "v" else if x = "b" then "v" else "v"
  outputBound := by
    intro x held; cases held with
    | head => exact .tail _ (.head _)
    | tail _ held => cases held with
      | head => exact .tail _ (.head _)
      | tail _ held => cases held with
        | head => exact .tail _ (.head _)
        | tail _ held => cases held
example : fibre m7 "u" = [] := rfl
example : fibre m7 "v" = ["a","b","c"] := rfl
example : collisions m7 = [("a","b"),("a","c"),("b","a"),("b","c"),("c","a"),("c","b")] := rfl
example : preimages m7 = [("u",[]),("v",["a","b","c"])] := rfl
theorem collisionWitness7 : ∃ a b, a ∈ m7.messages ∧ b ∈ m7.messages ∧ a ≠ b ∧ m7.transform a = m7.transform b :=
  largerDomainWitness m7 (by decide) (by decide)
#print axioms collisionWitness7
def empty : Model := ⟨[],[],fun _ => "unused",by intro x h; cases h⟩
example : preimages empty = [] := rfl
example : collisions empty = [] := rfl
example : domainSeparated "domain-a" "same" ≠ domainSeparated "domain-b" "same" := by decide
example : domainSeparated "domain-a" "same" = domainSeparated "domain-a" "same" := rfl

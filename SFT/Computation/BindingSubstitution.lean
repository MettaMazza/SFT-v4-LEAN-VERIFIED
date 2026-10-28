import SFT.Computation.BindingTerms
namespace SFT.Computation.BindingSubstitution
open BindingTerms

-- Carry the source's whole-body renamings through the original finite tree.
def mapNames (mapping : String → String) : Term → Term
 | .var name => .var (mapping name)
 | .app left right => .app (mapNames mapping left) (mapNames mapping right)
 | .abs binder body => .abs (mapping binder) (mapNames mapping body)

def substituteWith (term : Term) (mapping : String → String) (name : String) (replacement : Term) : Except String Term :=
 match term with
 | .var label => .ok (if mapping label = name then replacement else .var (mapping label))
 | .app left right => match substituteWith left mapping name replacement with
   | .error e => .error e
   | .ok l => match substituteWith right mapping name replacement with
     | .error e => .error e
     | .ok r => .ok (.app l r)
 | .abs binder body =>
   if mapping binder = name then .ok (mapNames mapping term)
   else if free replacement (mapping binder) then
     match fresh (mapNames mapping body) replacement name with
     | .error e => .error e
     | .ok newBinder =>
       match substituteWith body (fun label => if mapping label = mapping binder then newBinder else mapping label) name replacement with
       | .error e => .error e
       | .ok result => .ok (.abs newBinder result)
   else match substituteWith body mapping name replacement with
     | .error e => .error e
     | .ok result => .ok (.abs (mapping binder) result)

def substitute (term : Term) (name : String) (replacement : Term) : Except String Term :=
  substituteWith term (fun label => label) name replacement

theorem mapIdentity (term : Term) : mapNames (fun label => label) term = term := by
  induction term with
  | var => rfl
  | app left right il ir => change Term.app (mapNames _ left) (mapNames _ right) = _; rw [il,ir]
  | abs binder body ih => change Term.abs binder (mapNames _ body) = _; rw [ih]

theorem mapRename (term : Term) (mapping : String → String) (old freshName : String) :
    mapNames (fun label => if mapping label = old then freshName else mapping label) term =
      rename (mapNames mapping term) old freshName := by
  induction term with
  | var => rfl
  | app left right il ir =>
    change Term.app (mapNames _ left) (mapNames _ right) = Term.app (rename _ _ _) (rename _ _ _)
    rw [il,ir]
  | abs binder body ih =>
    change Term.abs _ (mapNames _ body) = Term.abs _ (rename _ _ _)
    rw [ih]

theorem variableSubstitution (label name : String) (replacement : Term) :
    substitute (.var label) name replacement = .ok (if label = name then replacement else .var label) := rfl

theorem heldBinder (name : String) (body replacement : Term) :
    substitute (.abs name body) name replacement = .ok (.abs name body) := by
  unfold substitute substituteWith
  rw [if_pos rfl,mapIdentity]

theorem sourceWitness : substitute (.abs "y" (.var "x")) "x" (.var "y") = .ok (.abs "u" (.var "y")) := rfl

end SFT.Computation.BindingSubstitution

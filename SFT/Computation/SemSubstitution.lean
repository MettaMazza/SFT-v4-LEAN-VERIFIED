import SFT.Computation.SemBindingTerms
namespace SFT.Computation.SemSubstitution
open SemBindingTerms

def mapNames {Value : Type} (mapping : String → String) : Term Value → Term Value
 | .value v => .value v
 | .name label => .name (mapping label)
 | .join left right => .join (mapNames mapping left) (mapNames mapping right)
 | .letE binder value body => .letE (mapping binder) (mapNames mapping value) (mapNames mapping body)
 | .same left right yes no => .same (mapNames mapping left) (mapNames mapping right) (mapNames mapping yes) (mapNames mapping no)

-- Accumulate the exact source whole-body renaming, preserving structural
-- recursion and the original fresh-search-before-initializer failure order.
def substituteWith {Value : Type} (mapping : String → String) (name : String) (replacement : Term Value) : Term Value → Except String (Term Value)
 | .value v => .ok (.value v)
 | .name label => .ok (if mapping label = name then replacement else .name (mapping label))
 | .join left right => do
   let l ← substituteWith mapping name replacement left
   let r ← substituteWith mapping name replacement right
   pure (Term.join l r)
 | .same left right yes no => do
   let l ← substituteWith mapping name replacement left
   let r ← substituteWith mapping name replacement right
   let y ← substituteWith mapping name replacement yes
   let n ← substituteWith mapping name replacement no
   pure (Term.same l r y n)
 | .letE binder value body =>
   if mapping binder = name then do
     let v ← substituteWith mapping name replacement value
     pure (Term.letE (mapping binder) v (mapNames mapping body))
   else if free [] (mapping binder) replacement then do
     let newBinder ← fresh (mapNames mapping body) replacement name
     let v ← substituteWith mapping name replacement value
     let b ← substituteWith (fun label => if mapping label = mapping binder then newBinder else mapping label) name replacement body
     pure (Term.letE newBinder v b)
   else do
     let v ← substituteWith mapping name replacement value
     let b ← substituteWith mapping name replacement body
     pure (Term.letE (mapping binder) v b)

def substitute {Value : Type} (term : Term Value) (name : String) (replacement : Term Value) : Except String (Term Value) :=
  substituteWith (fun label => label) name replacement term

theorem mapIdentity {Value : Type} (term : Term Value) : mapNames (fun label => label) term = term := by
  induction term with
  | value => rfl
  | name => rfl
  | join a b ia ib => change Term.join (mapNames _ a) (mapNames _ b) = _; rw [ia,ib]
  | letE binder value body iv ib => change Term.letE binder (mapNames _ value) (mapNames _ body) = _; rw [iv,ib]
  | same a b c d ia ib ic id => change Term.same (mapNames _ a) (mapNames _ b) (mapNames _ c) (mapNames _ d) = _; rw [ia,ib,ic,id]

theorem mapCompose {Value : Type} (term : Term Value) (outer inner : String → String) :
    mapNames outer (mapNames inner term) = mapNames (fun name => outer (inner name)) term := by
  induction term with
  | value => rfl
  | name => rfl
  | join a b ia ib => change Term.join (mapNames _ (mapNames _ a)) (mapNames _ (mapNames _ b)) = _; rw [ia,ib]; rfl
  | letE binder value body iv ib => change Term.letE _ (mapNames _ (mapNames _ value)) (mapNames _ (mapNames _ body)) = _; rw [iv,ib]; rfl
  | same a b c d ia ib ic id => change Term.same (mapNames _ (mapNames _ a)) (mapNames _ (mapNames _ b)) (mapNames _ (mapNames _ c)) (mapNames _ (mapNames _ d)) = _; rw [ia,ib,ic,id]; rfl

theorem mapRename {Value : Type} (term : Term Value) (old fresh : String) :
    mapNames (fun label => if label = old then fresh else label) term = rename old fresh term := by
  induction term with
  | value => rfl
  | name => rfl
  | join a b ia ib => change Term.join (mapNames _ a) (mapNames _ b) = _; rw [ia,ib]; rfl
  | letE binder value body iv ib => change Term.letE _ (mapNames _ value) (mapNames _ body) = _; rw [iv,ib]; rfl
  | same a b c d ia ib ic id => change Term.same (mapNames _ a) (mapNames _ b) (mapNames _ c) (mapNames _ d) = _; rw [ia,ib,ic,id]; rfl

theorem literalUnchanged {Value : Type} (value : Value) (name : String) (replacement : Term Value) :
    substitute (.value value) name replacement = .ok (.value value) := rfl

theorem nameReplacement {Value : Type} (label name : String) (replacement : Term Value) :
    substitute (.name label) name replacement = .ok (if label = name then replacement else .name label) := rfl

theorem heldBinder {Value : Type} (binder : String) (value body replacement : Term Value) :
    substitute (.letE binder value body) binder replacement =
      (do let v ← substitute value binder replacement; pure (Term.letE binder v body)) := by
  unfold substitute
  rw [substituteWith,ite_eq_left rfl,mapIdentity]

theorem joinEquation {Value : Type} (left right : Term Value) (name : String) (replacement : Term Value) :
    substitute (.join left right) name replacement =
      (do let l ← substitute left name replacement; let r ← substitute right name replacement; pure (Term.join l r)) := rfl

theorem sameEquation {Value : Type} (left right yes no : Term Value) (name : String) (replacement : Term Value) :
    substitute (.same left right yes no) name replacement =
      (do let l ← substitute left name replacement; let r ← substitute right name replacement
          let y ← substitute yes name replacement; let n ← substitute no name replacement; pure (Term.same l r y n)) := rfl

theorem nonconflictingBinder {Value : Type} (binder name : String) (value body replacement : Term Value)
    (different : binder ≠ name) (unconflicted : free [] binder replacement = false) :
    substitute (.letE binder value body) name replacement =
      (do let v ← substitute value name replacement; let b ← substitute body name replacement; pure (Term.letE binder v b)) := by
  unfold substitute
  rw [substituteWith,ite_eq_right different,unconflicted]
  rfl

theorem exhaustedBeforeDescent {Value : Type} (binder name : String) (value body replacement : Term Value)
    (different : binder ≠ name) (conflict : free [] binder replacement = true)
    (exhaustion : fresh body replacement name = .error "StopIteration") :
    substitute (.letE binder value body) name replacement = .error "StopIteration" := by
  unfold substitute
  rw [substituteWith,ite_eq_right different,conflict,mapIdentity,exhaustion]
  rfl

theorem mappedExecution {Value : Type} (term : Term Value) (outer inner : String → String)
    (name : String) (replacement : Term Value) :
    substituteWith outer name replacement (mapNames inner term) =
      substituteWith (fun label => outer (inner label)) name replacement term := by
  induction term generalizing outer with
  | value => rfl
  | name => rfl
  | join left right il ir =>
    change (do let l ← substituteWith outer name replacement (mapNames inner left)
               let r ← substituteWith outer name replacement (mapNames inner right); pure (Term.join l r)) = _
    rw [il,ir]
    rfl
  | same left right yes no il ir iy inn =>
    change (do let l ← substituteWith outer name replacement (mapNames inner left)
               let r ← substituteWith outer name replacement (mapNames inner right)
               let y ← substituteWith outer name replacement (mapNames inner yes)
               let n ← substituteWith outer name replacement (mapNames inner no); pure (Term.same l r y n)) = _
    rw [il,ir,iy,inn]
    rfl
  | letE binder value body iv ib =>
    change (if outer (inner binder) = name then
      (do let v ← substituteWith outer name replacement (mapNames inner value)
          pure (Term.letE (outer (inner binder)) v (mapNames outer (mapNames inner body))))
      else if free [] (outer (inner binder)) replacement then
      (do let next ← fresh (mapNames outer (mapNames inner body)) replacement name
          let v ← substituteWith outer name replacement (mapNames inner value)
          let b ← substituteWith (fun label => if outer label = outer (inner binder) then next else outer label) name replacement (mapNames inner body)
          pure (Term.letE next v b))
      else (do let v ← substituteWith outer name replacement (mapNames inner value)
               let b ← substituteWith outer name replacement (mapNames inner body)
               pure (Term.letE (outer (inner binder)) v b))) = _
    rw [mapCompose,iv]
    by_cases held : outer (inner binder) = name
    · rw [ite_eq_left held]
      rw [substituteWith,ite_eq_left held]
    · rw [ite_eq_right held]
      rw [substituteWith,ite_eq_right held]
      cases conflict : free [] (outer (inner binder)) replacement with
      | false => rw [ib]; rfl
      | true =>
        cases search : fresh (mapNames (fun label => outer (inner label)) body) replacement name with
        | error reason => rfl
        | ok next =>
          change (do let v ← substituteWith (fun label => outer (inner label)) name replacement value
                     let b ← substituteWith (fun label => if outer label = outer (inner binder) then next else outer label) name replacement (mapNames inner body)
                     pure (Term.letE next v b)) = _
          rw [ib]
          rfl

theorem renamedExecution {Value : Type} (term : Term Value) (old fresh name : String) (replacement : Term Value) :
    substitute (rename old fresh term) name replacement =
      substituteWith (fun label => if label = old then fresh else label) name replacement term := by
  rw [← mapRename]
  exact mappedExecution _ (fun label => label) _ _ _

theorem conflictingBinder {Value : Type} (binder name freshName : String) (value body replacement : Term Value)
    (different : binder ≠ name) (conflict : free [] binder replacement = true)
    (selected : fresh body replacement name = .ok freshName) :
    substitute (.letE binder value body) name replacement =
      (do let v ← substitute value name replacement
          let b ← substitute (rename binder freshName body) name replacement
          pure (Term.letE freshName v b)) := by
  change substituteWith (fun label => label) name replacement (.letE binder value body) = _
  rw [substituteWith,ite_eq_right different,conflict,mapIdentity,selected]
  change (do let v ← substitute value name replacement
             let b ← substituteWith (fun label => if label = binder then freshName else label) name replacement body
             pure (Term.letE freshName v b)) = _
  rw [← renamedExecution]

theorem originalWitness :
    substitute (.letE "y" (.value (["a"] : List String)) (.name "x")) "x" (.name "y") =
      .ok (.letE "u" (.value ["a"]) (.name "y")) := rfl

end SFT.Computation.SemSubstitution

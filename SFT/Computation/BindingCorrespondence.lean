import SFT.Computation.BindingSubstitution
namespace SFT.Computation.BindingCorrespondence
open BindingTerms BindingSubstitution

theorem mapCompose (term : Term) (outer inner : String → String) :
    mapNames outer (mapNames inner term) = mapNames (fun x => outer (inner x)) term := by
  induction term with
  | var => rfl
  | app left right il ir => change Term.app (mapNames _ (mapNames _ left)) (mapNames _ (mapNames _ right)) = _; rw [il,ir]; rfl
  | abs binder body ih => change Term.abs _ (mapNames _ (mapNames _ body)) = _; rw [ih]; rfl

theorem mappedExecution (term : Term) (outer inner : String → String) (name : String) (replacement : Term) :
    substituteWith (mapNames inner term) outer name replacement =
      substituteWith term (fun x => outer (inner x)) name replacement := by
  induction term generalizing outer inner with
  | var => rfl
  | app left right il ir =>
    dsimp only [mapNames,substituteWith]
    rw [il]
    cases substituteWith left (fun x => outer (inner x)) name replacement with
    | error e => rfl
    | ok l =>
      change (match substituteWith (mapNames inner right) outer name replacement with | .error e => Except.error e | .ok r => Except.ok (Term.app l r)) = _
      rw [ir]
      rfl
  | abs binder body ih =>
    dsimp only [mapNames,substituteWith]
    by_cases eq : outer (inner binder) = name
    · rw [if_pos eq,if_pos eq,mapCompose]
    · rw [if_neg eq,if_neg eq]
      cases hf : free replacement (outer (inner binder))
      · change (match substituteWith (mapNames inner body) outer name replacement with | .error e => Except.error e | .ok result => Except.ok (Term.abs (outer (inner binder)) result)) = _
        rw [ih]
        rfl
      · rw [if_pos rfl,if_pos rfl,mapCompose]
        cases fresh (mapNames (fun x => outer (inner x)) body) replacement name with
        | error e => rfl
        | ok freshName =>
          change (match substituteWith (mapNames inner body) (fun label => if outer label = outer (inner binder) then freshName else outer label) name replacement with | .error e => Except.error e | .ok result => Except.ok (Term.abs freshName result)) = _
          rw [ih]
          rfl

theorem renamedExecution (term : Term) (old freshName name : String) (replacement : Term) :
    substitute (rename term old freshName) name replacement =
      substituteWith term (fun label => if label = old then freshName else label) name replacement := by
  have mapping := mapRename term (fun label => label) old freshName
  rw [mapIdentity] at mapping
  rw [← mapping]
  exact mappedExecution term (fun label => label) (fun label => if label = old then freshName else label) name replacement

theorem applicationEquation (left right : Term) (name : String) (replacement : Term) :
    substitute (.app left right) name replacement =
      (match substitute left name replacement with
       | .error e => .error e
       | .ok l => match substitute right name replacement with
         | .error e => .error e
         | .ok r => .ok (.app l r)) := rfl

theorem abstractionEquation (binder name : String) (body replacement : Term) :
    substitute (.abs binder body) name replacement =
      (if binder = name then .ok (.abs binder body)
       else if free replacement binder then
         match fresh body replacement name with
         | .error e => .error e
         | .ok freshName => match substitute (rename body binder freshName) name replacement with
           | .error e => .error e
           | .ok result => .ok (.abs freshName result)
       else match substitute body name replacement with
         | .error e => .error e
         | .ok result => .ok (.abs binder result)) := by
  change substituteWith (.abs binder body) (fun label => label) name replacement = _
  rw [substituteWith]
  rw [mapIdentity,mapIdentity]
  by_cases eq : binder = name
  · rw [if_pos eq,if_pos eq]
  · rw [if_neg eq,if_neg eq]
    cases hf : free replacement binder
    · rfl
    · rw [if_pos rfl,if_pos rfl]
      cases fresh body replacement name with
      | error e => rfl
      | ok freshName => change (match substituteWith body (fun label => if label = binder then freshName else label) name replacement with | .error e => Except.error e | .ok result => Except.ok (Term.abs freshName result)) = _
                        rw [← renamedExecution]


theorem firstFreshError (body replacement : Term) (name : String) (candidates : List String) (error : String)
    (h : firstFresh body replacement name candidates = .error error) : error = "StopIteration" := by
  induction candidates with
  | nil => cases h; rfl
  | cons candidate rest ih =>
    unfold firstFresh at h
    cases ha : available body replacement name candidate with
    | true => rw [ha] at h; cases h
    | false => rw [ha] at h; exact ih h

theorem substitutionWithError (term : Term) (mapping : String → String) (name : String)
    (replacement : Term) (error : String)
    (h : substituteWith term mapping name replacement = .error error) : error = "StopIteration" := by
  induction term generalizing mapping error with
  | var label => cases h
  | app left right il ir =>
    unfold substituteWith at h
    cases hl : substituteWith left mapping name replacement with
    | error e => rw [hl] at h; cases h; exact il _ _ hl
    | ok l =>
      rw [hl] at h
      dsimp only at h
      cases hr : substituteWith right mapping name replacement with
      | error e => rw [hr] at h; cases h; exact ir _ _ hr
      | ok r => rw [hr] at h; cases h
  | abs binder body ih =>
    unfold substituteWith at h
    by_cases eq : mapping binder = name
    · rw [if_pos eq] at h; cases h
    · rw [if_neg eq] at h
      cases hf : free replacement (mapping binder)
      · rw [hf] at h
        cases hb : substituteWith body mapping name replacement with
        | error e => rw [hb] at h; cases h; exact ih _ _ hb
        | ok r => rw [hb] at h; cases h
      · rw [hf] at h
        cases hn : fresh (mapNames mapping body) replacement name with
        | error e => rw [hn] at h; cases h; exact firstFreshError _ _ _ _ _ hn
        | ok newBinder =>
          rw [hn] at h
          dsimp only at h
          cases hb : substituteWith body (fun label => if mapping label = mapping binder then newBinder else mapping label) name replacement with
          | error e => rw [hb] at h; cases h; exact ih _ _ hb
          | ok r => rw [hb] at h; cases h

theorem substitutionError (term : Term) (name : String) (replacement : Term) (error : String)
    (h : substitute term name replacement = .error error) : error = "StopIteration" :=
  substitutionWithError _ _ _ _ _ h

end SFT.Computation.BindingCorrespondence

import SFT.Mathematics.AlgebraReturnMeaning
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects

def imageLookup : List (String × String) → String → Option String
  | [], _ => none
  | (key,value)::rest, origin => if key = origin then some value else imageLookup rest origin

def putImage : List (String × String) → String → String → List (String × String)
  | [], origin, image => [(origin,image)]
  | (key,value)::rest, origin, image =>
    if key = origin then (origin,image)::rest else (key,value)::putImage rest origin image

def imageRun (current : List (String × String)) : List (String × String) → List (String × String)
  | [] => current
  | (origin,image)::rest => imageRun (putImage current origin image) rest

def buildImages (mapping : List (String × String)) : List (String × String) := imageRun [] mapping

def imageAt (images : List (String × String)) (origin : String) : Except String String :=
  match imageLookup images origin with
  | none => .error (SFT.Host.Text.append "KeyError: " origin)
  | some image => .ok image

def imageInCarrier (images : List (String × String)) (target : List String) (origin : String) : Bool :=
  match imageLookup images origin with
  | none => false
  | some image => has target image

def preservationCell (source target : OperationTable) (images : List (String × String))
    (a b : String) : Except String Bool := do
  let result ← applyOperation source a b
  let mappedResult ← imageAt images result
  let mappedA ← imageAt images a
  let mappedB ← imageAt images b
  let targetResult ← applyOperation target mappedA mappedB
  pure (decide (mappedResult = targetResult))

def preservesOperation (source target : OperationTable) (mapping : List (String × String)) : Except String Bool :=
  let images := buildImages mapping
  if images.length = source.carrier.length then
    if source.carrier.all (imageInCarrier images target.carrier) then
      allChecked (fun a => allChecked (preservationCell source target images a) source.carrier) source.carrier
    else .ok false
  else .ok false

theorem putImageLookupSame (images : List (String × String)) (origin image : String) :
    imageLookup (putImage images origin image) origin = some image := by
  induction images with
  | nil => change (if origin = origin then some image else none) = some image; rw [ite_eq_left rfl]
  | cons pair rest ih =>
    cases pair with
    | mk key value =>
      change imageLookup (if key = origin then (origin,image)::rest else (key,value)::putImage rest origin image) origin = _
      by_cases eq : key = origin
      · rw [ite_eq_left eq]; change (if origin = origin then some image else _) = _; rw [ite_eq_left rfl]
      · rw [ite_eq_right eq]; change (if key = origin then some value else _) = _; rw [ite_eq_right eq]; exact ih

theorem putImageLookupOther (images : List (String × String)) (origin image other : String)
    (different : origin ≠ other) : imageLookup (putImage images origin image) other = imageLookup images other := by
  induction images with
  | nil => change (if origin = other then some image else none) = none; rw [ite_eq_right different]
  | cons pair rest ih =>
    cases pair with
    | mk key value =>
      change imageLookup (if key = origin then (origin,image)::rest else (key,value)::putImage rest origin image) other = _
      by_cases eq : key = origin
      · rw [ite_eq_left eq]
        cases eq
        change (if origin = other then some image else _) = (if origin = other then some value else _)
        rw [ite_eq_right different,ite_eq_right different]
      · rw [ite_eq_right eq]
        change (if key = other then some value else _) = (if key = other then some value else _)
        by_cases same : key = other
        · rw [ite_eq_left same,ite_eq_left same]
        · rw [ite_eq_right same,ite_eq_right same,ih]

theorem imageRunAppend (current left right : List (String × String)) :
    imageRun current (left ++ right) = imageRun (imageRun current left) right := by
  induction left generalizing current with
  | nil => rfl
  | cons pair rest ih => exact ih _

theorem finalMappingValueWins (mapping : List (String × String)) (origin image : String) :
    imageLookup (buildImages (mapping ++ [(origin,image)])) origin = some image := by
  unfold buildImages
  rw [imageRunAppend]
  exact putImageLookupSame _ origin image

theorem preservationCellExact (source target : OperationTable) (images : List (String × String))
    (a b result mappedResult mappedA mappedB targetResult : String)
    (hs : applyOperation source a b = .ok result) (hi : imageAt images result = .ok mappedResult)
    (ha : imageAt images a = .ok mappedA) (hb : imageAt images b = .ok mappedB)
    (ht : applyOperation target mappedA mappedB = .ok targetResult) :
    preservationCell source target images a b = .ok true ↔ mappedResult = targetResult := by
  unfold preservationCell
  rw [hs]
  dsimp only [Bind.bind,Except.bind]
  rw [hi]
  dsimp only [Bind.bind,Except.bind]
  rw [ha]
  dsimp only [Bind.bind,Except.bind]
  rw [hb]
  dsimp only [Bind.bind,Except.bind]
  rw [ht]
  dsimp only [Bind.bind,Except.bind,Pure.pure,Except.pure]
  exact ⟨fun h => of_decide_eq_true (Except.ok.inj h),fun h => congrArg Except.ok (decide_eq_true h)⟩

theorem preservesOperationTrueIff (source target : OperationTable) (mapping : List (String × String)) :
    preservesOperation source target mapping = .ok true ↔
      (buildImages mapping).length = source.carrier.length ∧
      source.carrier.all (imageInCarrier (buildImages mapping) target.carrier) = true ∧
      ∀ a, a ∈ source.carrier → ∀ b, b ∈ source.carrier →
        preservationCell source target (buildImages mapping) a b = .ok true := by
  unfold preservesOperation
  dsimp only
  by_cases size : (buildImages mapping).length = source.carrier.length
  · rw [ite_eq_left size]
    cases valid : source.carrier.all (imageInCarrier (buildImages mapping) target.carrier) with
    | false =>
      constructor
      · intro h; cases h
      · intro h; cases h.2.1
    | true =>
      constructor
      · intro h
        exact ⟨size,rfl,fun a ha b hb => (allCheckedTrueIff _ _).mp ((allCheckedTrueIff _ _).mp h a ha) b hb⟩
      · intro h
        exact (allCheckedTrueIff _ _).mpr (fun a ha => (allCheckedTrueIff _ _).mpr (fun b hb => h.2.2 a ha b hb))
  · rw [ite_eq_right size]
    constructor
    · intro h; cases h
    · intro h; exact False.elim (size h.1)

end SFT.Mathematics.AlgebraOperations

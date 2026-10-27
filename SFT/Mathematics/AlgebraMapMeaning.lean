import SFT.Mathematics.AlgebraMaps
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem imageLookupDomain (images : List (String × String)) (origin : String) :
    (∃ value, imageLookup images origin = some value) ↔ origin ∈ images.map Prod.fst := by
  induction images with
  | nil => constructor <;> intro h; obtain ⟨v,h⟩ := h; cases h; cases h
  | cons pair rest ih =>
    cases pair with
    | mk key value =>
      change (∃ v, (if key = origin then some value else imageLookup rest origin) = some v) ↔ origin ∈ key::rest.map Prod.fst
      by_cases eq : key = origin
      · rw [ite_eq_left eq]
        constructor
        · intro _; cases eq; exact List.Mem.head _
        · intro _; exact ⟨value,rfl⟩
      · rw [ite_eq_right eq]
        constructor
        · intro h; exact List.Mem.tail _ (ih.mp h)
        · intro h
          cases h with
          | head => exact False.elim (eq rfl)
          | tail _ m => exact ih.mpr m

theorem putImageKeyContainment (images : List (String × String)) (origin image key : String)
    (member : key ∈ (putImage images origin image).map Prod.fst) :
    key = origin ∨ key ∈ images.map Prod.fst := by
  by_cases same : origin = key
  · exact Or.inl same.symm
  · obtain ⟨value,found⟩ := (imageLookupDomain _ key).mpr member
    rw [putImageLookupOther images origin image key same] at found
    exact Or.inr ((imageLookupDomain images key).mp ⟨value,found⟩)

theorem putImageKeysDistinct (images : List (String × String)) (origin image : String)
    (unique : distinct (images.map Prod.fst) = true) :
    distinct ((putImage images origin image).map Prod.fst) = true := by
  induction images with
  | nil => rfl
  | cons pair rest ih =>
    cases pair with
    | mk key value =>
      have parts := (distinctCons key (rest.map Prod.fst)).mp unique
      change distinct ((if key = origin then (origin,image)::rest else (key,value)::putImage rest origin image).map Prod.fst) = true
      by_cases eq : key = origin
      · rw [ite_eq_left eq]; cases eq; exact unique
      · rw [ite_eq_right eq]
        apply (distinctCons key _).mpr
        constructor
        · apply (absentIff _ _).mpr
          intro member
          cases putImageKeyContainment rest origin image key member with
          | inl same => exact eq same
          | inr old => exact (absentIff _ _).mp parts.1 old
        · exact ih parts.2

theorem imageRunKeysDistinct (current mapping : List (String × String))
    (unique : distinct (current.map Prod.fst) = true) :
    distinct ((imageRun current mapping).map Prod.fst) = true := by
  induction mapping generalizing current with
  | nil => exact unique
  | cons pair rest ih => exact ih _ (putImageKeysDistinct current pair.1 pair.2 unique)

theorem generatedImageKeysDistinct (mapping : List (String × String)) :
    distinct ((buildImages mapping).map Prod.fst) = true := imageRunKeysDistinct [] mapping rfl

theorem imageInCarrierIff (images : List (String × String)) (carrier : List String) (origin : String) :
    imageInCarrier images carrier origin = true ↔
      ∃ value, imageAt images origin = .ok value ∧ value ∈ carrier := by
  unfold imageInCarrier imageAt
  cases found : imageLookup images origin with
  | none =>
    constructor
    · intro h; cases h
    · intro h; obtain ⟨value,bad,_⟩ := h; cases bad
  | some value =>
    constructor
    · intro h; exact ⟨value,rfl,(hasIff carrier value).mp h⟩
    · intro h
      obtain ⟨other,eq,member⟩ := h
      cases eq
      exact (hasIff carrier value).mpr member

theorem checkedPreservationCellTotal (source target : OperationTable) (images : List (String × String))
    (sourceAccepted : makeTable source.carrier source.rows = .ok source)
    (targetAccepted : makeTable target.carrier target.rows = .ok target)
    (imagesValid : source.carrier.all (imageInCarrier images target.carrier) = true)
    (a b : String) (ha : a ∈ source.carrier) (hb : b ∈ source.carrier) :
    ∃ value, preservationCell source target images a b = .ok value := by
  obtain ⟨result,hs,resultMember⟩ := acceptedLookupTotal _ _ source sourceAccepted a b ha hb
  have imageExists : ∀ x, x ∈ source.carrier → ∃ v, imageAt images x = .ok v ∧ v ∈ target.carrier :=
    fun x hx => (imageInCarrierIff images target.carrier x).mp (allTrueAtMember _ _ imagesValid x hx)
  obtain ⟨mappedResult,hi,_⟩ := imageExists result resultMember
  obtain ⟨mappedA,hma,maMember⟩ := imageExists a ha
  obtain ⟨mappedB,hmb,mbMember⟩ := imageExists b hb
  obtain ⟨targetResult,ht,_⟩ := acceptedLookupTotal _ _ target targetAccepted mappedA mappedB maMember mbMember
  refine ⟨decide (mappedResult = targetResult),?_⟩
  unfold preservationCell
  rw [hs]
  dsimp only [Bind.bind,Except.bind]
  rw [hi]
  dsimp only [Bind.bind,Except.bind]
  rw [hma]
  dsimp only [Bind.bind,Except.bind]
  rw [hmb]
  dsimp only [Bind.bind,Except.bind]
  rw [ht]
  rfl


theorem acceptedPreservationMeaning (source target : OperationTable) (mapping : List (String × String))
    (sourceAccepted : makeTable source.carrier source.rows = .ok source)
    (targetAccepted : makeTable target.carrier target.rows = .ok target) :
    preservesOperation source target mapping = .ok true ↔
      (buildImages mapping).length = source.carrier.length ∧
      source.carrier.all (imageInCarrier (buildImages mapping) target.carrier) = true ∧
      ∀ a, a ∈ source.carrier → ∀ b, b ∈ source.carrier →
      ∀ result mappedResult mappedA mappedB targetResult,
        applyOperation source a b = .ok result → imageAt (buildImages mapping) result = .ok mappedResult →
        imageAt (buildImages mapping) a = .ok mappedA → imageAt (buildImages mapping) b = .ok mappedB →
        applyOperation target mappedA mappedB = .ok targetResult → mappedResult = targetResult := by
  constructor
  · intro passed
    have parts := (preservesOperationTrueIff source target mapping).mp passed
    refine ⟨parts.1,parts.2.1,?_⟩
    intro a ha b hb result mappedResult mappedA mappedB targetResult hs hi hma hmb ht
    exact (preservationCellExact source target _ a b result mappedResult mappedA mappedB targetResult hs hi hma hmb ht).mp
      (parts.2.2 a ha b hb)
  · intro conditions
    apply (preservesOperationTrueIff source target mapping).mpr
    refine ⟨conditions.1,conditions.2.1,?_⟩
    intro a ha b hb
    obtain ⟨result,hs,resultMember⟩ := acceptedLookupTotal _ _ source sourceAccepted a b ha hb
    have imageExists : ∀ x, x ∈ source.carrier →
        ∃ v, imageAt (buildImages mapping) x = .ok v ∧ v ∈ target.carrier :=
      fun x hx => (imageInCarrierIff _ target.carrier x).mp (allTrueAtMember _ _ conditions.2.1 x hx)
    obtain ⟨mappedResult,hi,_⟩ := imageExists result resultMember
    obtain ⟨mappedA,hma,maMember⟩ := imageExists a ha
    obtain ⟨mappedB,hmb,mbMember⟩ := imageExists b hb
    obtain ⟨targetResult,ht,_⟩ := acceptedLookupTotal _ _ target targetAccepted mappedA mappedB maMember mbMember
    exact (preservationCellExact source target _ a b result mappedResult mappedA mappedB targetResult hs hi hma hmb ht).mpr
      (conditions.2.2 a ha b hb result mappedResult mappedA mappedB targetResult hs hi hma hmb ht)

end SFT.Mathematics.AlgebraOperations

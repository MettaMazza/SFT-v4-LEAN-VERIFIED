import SFT.Mathematics.AlgebraMapExtension
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects SFT.Foundation.CommonRefinement CombinatorialArrangements

theorem acceptedMapKeysPermuteCarrier (source target : OperationTable) (mapping : List (String × String))
    (accepted : makeTable source.carrier source.rows = .ok source)
    (passed : preservesOperation source target mapping = .ok true) :
    List.Perm source.carrier ((buildImages mapping).map Prod.fst) := by
  have checks := (preservesOperationTrueIff source target mapping).mp passed
  apply completeEqualLengthPermutation
  · exact (tableAcceptedData _ _ source accepted).2.2.1
  · intro origin held
    have valid := allTrueAtMember _ _ checks.2.1 origin held
    apply (imageLookupDomain _ origin).mp
    unfold imageInCarrier at valid
    cases found : imageLookup (buildImages mapping) origin with
    | none => rw [found] at valid; cases valid
    | some value => exact ⟨value,rfl⟩
  · rw [mapLength]
    exact checks.1.symm

theorem freshOriginAbsent (source target : OperationTable) (mapping : List (String × String))
    (accepted : makeTable source.carrier source.rows = .ok source)
    (passed : preservesOperation source target mapping = .ok true)
    (fresh : String) (new : fresh ∉ source.carrier) :
    imageLookup (buildImages mapping) fresh = none := by
  cases found : imageLookup (buildImages mapping) fresh with
  | none => rfl
  | some value =>
    have held := (imageLookupDomain _ fresh).mp ⟨value,found⟩
    exact False.elim (new (permutationMember (acceptedMapKeysPermuteCarrier source target mapping accepted passed).symm fresh held))

theorem putFreshImageAppends (images : List (String × String)) (fresh value : String)
    (absent : imageLookup images fresh = none) :
    putImage images fresh value = images ++ [(fresh,value)] := by
  induction images with
  | nil => rfl
  | cons pair rest ih =>
    cases pair with
    | mk key old =>
      by_cases same : key = fresh
      · change (if key = fresh then some old else _) = none at absent
        rw [ite_eq_left same] at absent
        cases absent
      · change (if key = fresh then some old else imageLookup rest fresh) = none at absent
        rw [ite_eq_right same] at absent
        change (if key = fresh then _ else (key,old)::putImage rest fresh value) = _
        rw [ite_eq_right same]
        exact congrArg (List.cons (key,old)) (ih absent)

theorem buildFreshImageAppends (mapping : List (String × String)) (fresh value : String)
    (absent : imageLookup (buildImages mapping) fresh = none) :
    buildImages (mapping ++ [(fresh,value)]) = buildImages mapping ++ [(fresh,value)] := by
  unfold buildImages
  rw [imageRunAppend]
  exact putFreshImageAppends _ fresh value absent

theorem extendedDictionaryCardinality (source target : OperationTable) (mapping : List (String × String))
    (accepted : makeTable source.carrier source.rows = .ok source)
    (passed : preservesOperation source target mapping = .ok true)
    (fresh value : String) (new : fresh ∉ source.carrier) :
    (buildImages (mapping ++ [(fresh,value)])).length = (source.carrier ++ [fresh]).length := by
  rw [buildFreshImageAppends mapping fresh value (freshOriginAbsent source target mapping accepted passed fresh new),
    appendLength,appendLength]
  rw [(preservesOperationTrueIff source target mapping).mp passed |>.1]
  rfl

theorem appendedImagePreservesOther (mapping : List (String × String)) (fresh value origin : String)
    (different : fresh ≠ origin) :
    imageAt (buildImages (mapping ++ [(fresh,value)])) origin = imageAt (buildImages mapping) origin := by
  unfold buildImages
  rw [imageRunAppend]
  change imageAt (putImage (imageRun [] mapping) fresh value) origin = _
  unfold imageAt
  rw [putImageLookupOther _ fresh value origin different]

theorem appendedImageAtFresh (mapping : List (String × String)) (fresh value : String) :
    imageAt (buildImages (mapping ++ [(fresh,value)])) fresh = .ok value := by
  unfold imageAt
  rw [finalMappingValueWins]

theorem appendedFreshImageValidIff (mapping : List (String × String)) (fresh value : String)
    (target : List String) :
    imageInCarrier (buildImages (mapping ++ [(fresh,value)])) target fresh = true ↔ value ∈ target := by
  constructor
  · intro valid
    obtain ⟨other,found,member⟩ := (imageInCarrierIff _ target fresh).mp valid
    rw [appendedImageAtFresh] at found
    cases found
    exact member
  · intro member
    exact (imageInCarrierIff _ target fresh).mpr ⟨value,appendedImageAtFresh mapping fresh value,member⟩

theorem freshDictionaryMapExtensionIff (source target extendedSource extendedTarget : OperationTable)
    (mapping : List (String × String)) (fresh value : String)
    (accepted : makeTable source.carrier source.rows = .ok source)
    (new : fresh ∉ source.carrier)
    (shape : extendedSource.carrier = source.carrier ++ [fresh])
    (targetInclusion : ∀ x, x ∈ target.carrier → x ∈ extendedTarget.carrier)
    (sourceAgreement : ∀ a, a ∈ source.carrier → ∀ b, b ∈ source.carrier →
      applyOperation extendedSource a b = applyOperation source a b)
    (targetAgreement : ∀ a, a ∈ target.carrier → ∀ b, b ∈ target.carrier →
      applyOperation extendedTarget a b = applyOperation target a b)
    (prior : preservesOperation source target mapping = .ok true) :
    preservesOperation extendedSource extendedTarget (mapping ++ [(fresh,value)]) = .ok true ↔
      value ∈ extendedTarget.carrier ∧
      (∀ a, a ∈ extendedSource.carrier → ∀ b, b ∈ extendedSource.carrier →
        (a = fresh ∨ b = fresh) →
        preservationCell extendedSource extendedTarget (buildImages (mapping ++ [(fresh,value)])) a b = .ok true) := by
  have images : ∀ x, x ∈ source.carrier →
      imageAt (buildImages (mapping ++ [(fresh,value)])) x = imageAt (buildImages mapping) x := by
    intro x held
    apply appendedImagePreservesOther
    intro same
    exact new (same.symm ▸ held)
  have split := operationMapPreservedByExtension source target extendedSource extendedTarget mapping
    (mapping ++ [(fresh,value)]) fresh accepted shape targetInclusion sourceAgreement targetAgreement images prior
  constructor
  · intro passed
    have checks := split.mp passed
    exact ⟨(appendedFreshImageValidIff mapping fresh value extendedTarget.carrier).mp checks.2.1,checks.2.2⟩
  · intro checks
    apply split.mpr
    refine ⟨?_,(appendedFreshImageValidIff mapping fresh value extendedTarget.carrier).mpr checks.1,checks.2⟩
    rw [shape]
    exact extendedDictionaryCardinality source target mapping accepted prior fresh value new

end SFT.Mathematics.AlgebraOperations

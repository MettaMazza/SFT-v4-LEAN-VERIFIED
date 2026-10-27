import SFT.Mathematics.AlgebraExtension
import SFT.Mathematics.AlgebraMapMeaning
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem extendedImageCoverageIff (images : List (String × String)) (carrier target : List String)
    (fresh : String) :
    (carrier ++ [fresh]).all (imageInCarrier images target) = true ↔
      carrier.all (imageInCarrier images target) = true ∧ imageInCarrier images target fresh = true := by
  constructor
  · intro h
    have each := (allTrueIffMembers _ _).mp h
    exact ⟨(allTrueIffMembers _ _).mpr (fun item held => each item (memAppendLeft _ _ _ held)),
      each fresh (memAppendRight _ _ _ (List.Mem.head []))⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro item member
    cases (extendedCarrierMember carrier fresh item).mp member with
    | inl held => exact (allTrueIffMembers _ _).mp h.1 item held
    | inr same => cases same; exact h.2

theorem extendedMapChecksIff (source target : OperationTable) (mapping : List (String × String))
    (carrier : List String) (fresh : String) (shape : source.carrier = carrier ++ [fresh]) :
    preservesOperation source target mapping = .ok true ↔
      (buildImages mapping).length = source.carrier.length ∧
      carrier.all (imageInCarrier (buildImages mapping) target.carrier) = true ∧
      imageInCarrier (buildImages mapping) target.carrier fresh = true ∧
      (∀ a, a ∈ carrier → ∀ b, b ∈ carrier →
        preservationCell source target (buildImages mapping) a b = .ok true) ∧
      (∀ a, a ∈ source.carrier → ∀ b, b ∈ source.carrier →
        (a = fresh ∨ b = fresh) → preservationCell source target (buildImages mapping) a b = .ok true) := by
  have embed (x : String) (h : x ∈ carrier) : x ∈ source.carrier := by
    rw [shape]; exact memAppendLeft _ _ _ h
  constructor
  · intro passed
    have checked := (preservesOperationTrueIff source target mapping).mp passed
    have coverage := checked.2.1
    rw [shape] at coverage
    have split := (extendedImageCoverageIff _ carrier target.carrier fresh).mp coverage
    exact ⟨checked.1,split.1,split.2,
      fun a ha b hb => checked.2.2 a (embed a ha) b (embed b hb),
      fun a ha b hb _ => checked.2.2 a ha b hb⟩
  · intro checks
    apply (preservesOperationTrueIff source target mapping).mpr
    refine ⟨checks.1,?_,?_⟩
    · rw [shape]
      exact (extendedImageCoverageIff _ carrier target.carrier fresh).mpr ⟨checks.2.1,checks.2.2.1⟩
    · intro a ha b hb
      have classify (x : String) (h : x ∈ source.carrier) : x ∈ carrier ∨ x = fresh := by
        rw [shape] at h; exact (extendedCarrierMember carrier fresh x).mp h
      cases classify a ha with
      | inr same => exact checks.2.2.2.2 a ha b hb (Or.inl same)
      | inl oldA =>
        cases classify b hb with
        | inr same => exact checks.2.2.2.2 a ha b hb (Or.inr same)
        | inl oldB => exact checks.2.2.2.1 a oldA b oldB

theorem oldImageCoveragePreserved (source target extendedTarget : OperationTable)
    (images extendedImages : List (String × String))
    (valid : source.carrier.all (imageInCarrier images target.carrier) = true)
    (imageAgreement : ∀ x, x ∈ source.carrier → imageAt extendedImages x = imageAt images x)
    (targetInclusion : ∀ x, x ∈ target.carrier → x ∈ extendedTarget.carrier) :
    source.carrier.all (imageInCarrier extendedImages extendedTarget.carrier) = true := by
  apply (allTrueIffMembers _ _).mpr
  intro x held
  obtain ⟨value,found,member⟩ := (imageInCarrierIff images target.carrier x).mp
    (allTrueAtMember _ _ valid x held)
  apply (imageInCarrierIff extendedImages extendedTarget.carrier x).mpr
  exact ⟨value,(imageAgreement x held).trans found,targetInclusion value member⟩

theorem oldPreservationCellPreserved (source target extendedSource extendedTarget : OperationTable)
    (images extendedImages : List (String × String))
    (accepted : makeTable source.carrier source.rows = .ok source)
    (valid : source.carrier.all (imageInCarrier images target.carrier) = true)
    (sourceAgreement : ∀ a, a ∈ source.carrier → ∀ b, b ∈ source.carrier →
      applyOperation extendedSource a b = applyOperation source a b)
    (targetAgreement : ∀ a, a ∈ target.carrier → ∀ b, b ∈ target.carrier →
      applyOperation extendedTarget a b = applyOperation target a b)
    (imageAgreement : ∀ x, x ∈ source.carrier → imageAt extendedImages x = imageAt images x)
    (a b : String) (ha : a ∈ source.carrier) (hb : b ∈ source.carrier) :
    preservationCell extendedSource extendedTarget extendedImages a b = preservationCell source target images a b := by
  obtain ⟨result,hs,resultHeld⟩ := acceptedLookupTotal _ _ source accepted a b ha hb
  have imageExists (x : String) (hx : x ∈ source.carrier) :
      ∃ value, imageAt images x = .ok value ∧ value ∈ target.carrier :=
    (imageInCarrierIff images target.carrier x).mp (allTrueAtMember _ _ valid x hx)
  obtain ⟨mappedResult,hi,_⟩ := imageExists result resultHeld
  obtain ⟨mappedA,hia,mha⟩ := imageExists a ha
  obtain ⟨mappedB,hib,mhb⟩ := imageExists b hb
  unfold preservationCell
  rw [sourceAgreement a ha b hb,hs]
  dsimp only [Bind.bind,Except.bind]
  rw [imageAgreement result resultHeld,hi]
  dsimp only [Bind.bind,Except.bind]
  rw [imageAgreement a ha,hia]
  dsimp only [Bind.bind,Except.bind]
  rw [imageAgreement b hb,hib]
  dsimp only [Bind.bind,Except.bind]
  rw [targetAgreement mappedA mha mappedB mhb]

theorem operationMapPreservedByExtension (source target extendedSource extendedTarget : OperationTable)
    (mapping extendedMapping : List (String × String)) (fresh : String)
    (accepted : makeTable source.carrier source.rows = .ok source)
    (shape : extendedSource.carrier = source.carrier ++ [fresh])
    (targetInclusion : ∀ x, x ∈ target.carrier → x ∈ extendedTarget.carrier)
    (sourceAgreement : ∀ a, a ∈ source.carrier → ∀ b, b ∈ source.carrier →
      applyOperation extendedSource a b = applyOperation source a b)
    (targetAgreement : ∀ a, a ∈ target.carrier → ∀ b, b ∈ target.carrier →
      applyOperation extendedTarget a b = applyOperation target a b)
    (imageAgreement : ∀ x, x ∈ source.carrier →
      imageAt (buildImages extendedMapping) x = imageAt (buildImages mapping) x)
    (prior : preservesOperation source target mapping = .ok true) :
    preservesOperation extendedSource extendedTarget extendedMapping = .ok true ↔
      (buildImages extendedMapping).length = extendedSource.carrier.length ∧
      imageInCarrier (buildImages extendedMapping) extendedTarget.carrier fresh = true ∧
      (∀ a, a ∈ extendedSource.carrier → ∀ b, b ∈ extendedSource.carrier →
        (a = fresh ∨ b = fresh) →
          preservationCell extendedSource extendedTarget (buildImages extendedMapping) a b = .ok true) := by
  have previous := (preservesOperationTrueIff source target mapping).mp prior
  have split := extendedMapChecksIff extendedSource extendedTarget extendedMapping source.carrier fresh shape
  constructor
  · intro passed
    have checks := split.mp passed
    exact ⟨checks.1,checks.2.2.1,checks.2.2.2.2⟩
  · intro checks
    apply split.mpr
    refine ⟨checks.1,oldImageCoveragePreserved source target extendedTarget _ _ previous.2.1
      imageAgreement targetInclusion,checks.2.1,?_,checks.2.2⟩
    intro a ha b hb
    rw [oldPreservationCellPreserved source target extendedSource extendedTarget _ _ accepted
      previous.2.1 sourceAgreement targetAgreement imageAgreement a b ha hb]
    exact previous.2.2 a ha b hb

end SFT.Mathematics.AlgebraOperations

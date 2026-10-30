import SFT.QuantumComputation.ClassicalCorrespondence
import SFT.Computation.DiagonalTrace
namespace SFT.QuantumComputation.Limits
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleInterpretation
open SFT.QuantumComputation.ClassicalCorrespondence
open SFT.Computation.RecognitionDomain SFT.Computation.HaltingBoundary
open SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingMaps SFT.InformationScience.EncodingDecoder
open SFT.Mathematics.DiscreteObjects

theorem complementaryQuantumExecution (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name prediction opposite phase : String) (cycle : List String)
    (unique : distinct cycle = true) (size : 2 ≤ cycle.length) (heldPhase : phase ∈ cycle)
    (complement : selfNegatingBoundary prediction = .ok opposite)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some ⟨⟨[([opposite],phase)],cycle⟩,[]⟩) :
    makeState [([opposite],phase)] cycle = .ok ⟨[([opposite],phase)],cycle⟩ ∧
    interpret registry decoder code = some (.ok ([],⟨[([opposite],phase)],cycle⟩)) ∧
    selfNegatingBoundary prediction = .ok opposite := by
  exact ⟨singletonEmbeddingAdmitted [opposite] phase cycle unique size heldPhase,
    exactRequest registry decoder code name ⟨⟨[([opposite],phase)],cycle⟩,[]⟩ decoded selected,complement⟩

theorem selfPredictionContradiction (registry : List (String × Request)) (decoder : Decoder)
    (code : Codeword) (name prediction opposite phase : String) (cycle : List String)
    (decoded : decode code decoder = .ok name)
    (selected : lookupFirst registry name = some ⟨⟨[([opposite],phase)],cycle⟩,[]⟩)
    (predictor : Codeword → Except String String) (answered : predictor code = .ok prediction)
    (held : Verdict prediction) (complement : selfNegatingBoundary prediction = .ok opposite)
    (correct : ∀ encoded answer outcome p c,
      predictor encoded = .ok answer →
      interpret registry decoder encoded = some (.ok ([],⟨[([outcome],p)],c⟩)) →
      Verdict outcome → answer = outcome) : False := by
  have executed := exactRequest registry decoder code name ⟨⟨[([opposite],phase)],cycle⟩,[]⟩ decoded selected
  have same := correct code prediction opposite phase cycle answered executed
    (SFT.Computation.DiagonalTrace.complementaryAnswer prediction opposite held complement)
  exact complementHasNoFixedPoint prediction held (by rw [← same] at complement; exact complement)
theorem totalInternalQuantumPredictionExcluded (registry : List (String × Request)) (decoder : Decoder)
    (predictor : Codeword → Except String String)
    (supported : ∃ code name, decode code decoder = .ok name ∧
      ∀ answer, predictor code = .ok answer → ∃ opposite phase cycle,
        selfNegatingBoundary answer = .ok opposite ∧
        makeState [([opposite],phase)] cycle = .ok ⟨[([opposite],phase)],cycle⟩ ∧
        lookupFirst registry name = some ⟨⟨[([opposite],phase)],cycle⟩,[]⟩)
    (total : ∀ code name, decode code decoder = .ok name →
      ∃ answer, Verdict answer ∧ predictor code = .ok answer)
    (correct : ∀ encoded answer outcome p c,
      predictor encoded = .ok answer →
      interpret registry decoder encoded = some (.ok ([],⟨[([outcome],p)],c⟩)) →
      Verdict outcome → answer = outcome) : False := by
  obtain ⟨code,name,decoded,selfDescription⟩ := supported
  obtain ⟨answer,held,answered⟩ := total code name decoded
  obtain ⟨opposite,phase,cycle,complement,_,selected⟩ := selfDescription answer answered
  exact selfPredictionContradiction registry decoder code name answer opposite phase cycle
    decoded selected predictor answered held complement correct
end SFT.QuantumComputation.Limits

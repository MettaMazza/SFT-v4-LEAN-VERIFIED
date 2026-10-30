import SFT.QuantumComputation.ReversibleGrammar
import SFT.QuantumComputation.Circuit
namespace SFT.QuantumComputation.CircuitGrammar
abbrev Candidate := SFT.QuantumComputation.ReversibleGrammar.Candidate
abbrev sourceFields := SFT.QuantumComputation.ReversibleGrammar.sourceFields
abbrev candidateId := SFT.QuantumComputation.ReversibleGrammar.candidateId
abbrev exactForm := SFT.QuantumComputation.ReversibleGrammar.exactForm
abbrev survivorId := SFT.QuantumComputation.ReversibleGrammar.survivorId
abbrev survives := SFT.QuantumComputation.ReversibleGrammar.survives
abbrev criteriaDecision := SFT.QuantumComputation.ReversibleGrammar.criteriaDecision
abbrev candidates := SFT.QuantumComputation.ReversibleGrammar.candidates
abbrev survivor := SFT.QuantumComputation.ReversibleGrammar.survivor
abbrev ExactCriteria := SFT.QuantumComputation.ReversibleGrammar.ExactCriteria
def generationRule : String := "Generate the literal product of eight registered Fold-quantum structural axes for quantum circuits."
def grammarBoundary : String := "All finite quantum circuits structures generated from admitted Fold words, distinction ledgers, classical computation and exact held phase labels. This derives circuit semantics; hardware timing and noise are external."
def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.supportName c.support) "complete-generated-branch-support") then "partial-or-selected-branch-support removes the required exact support structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.unitName c.unit) "one-Fold-distinction-unit") then "imported-bit-or-qubit removes the required exact unit structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.compositionName c.composition) "complete-pair-cell-joint-support") then "sampled-joint-states removes the required exact composition structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.phaseName c.phase) "period-held-phase-action") then "complex-amplitude-postulate removes the required exact phase structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.transformationName c.transformation) "total-reversible-source-bound-map") then "partial-or-irreversible-map removes the required exact transformation structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.observationName c.observation) "retained-class-and-complete-record") then "collapse-without-record removes the required exact observation structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.generalityName c.generality) "branch-and-depth-successor-certificate") then "fixed-circuit-examples removes the required exact generality structure." else
  if !(SFT.Host.Text.equal (SFT.QuantumComputation.ReversibleGrammar.additionName c.addition) "no-extra-quantum-premise") then "imported-quantum-model removes the required exact addition structure." else
  "The forced quantum circuits kernel retains generated wires; information units; reversible gates; causal circuit order; complete branchwise evaluation; inverse circuit; observation boundary; resource ledger; branch support, phase, transformation, observation, composition and resources remain exact, finite, source-bound and free of imported amplitudes or postulates."
theorem generatedCardinality : candidates.length = 256 := SFT.QuantumComputation.ReversibleGrammar.generatedCardinality
theorem candidatesComplete (c : Candidate) : c ∈ candidates := SFT.QuantumComputation.ReversibleGrammar.candidatesComplete c
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := SFT.QuantumComputation.ReversibleGrammar.uniqueSurvivor c
theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := SFT.QuantumComputation.ReversibleGrammar.acceptanceIffExactCriteria c
abbrev supportName := SFT.QuantumComputation.ReversibleGrammar.supportName
abbrev unitName := SFT.QuantumComputation.ReversibleGrammar.unitName
abbrev compositionName := SFT.QuantumComputation.ReversibleGrammar.compositionName
abbrev phaseName := SFT.QuantumComputation.ReversibleGrammar.phaseName
abbrev transformationName := SFT.QuantumComputation.ReversibleGrammar.transformationName
abbrev observationName := SFT.QuantumComputation.ReversibleGrammar.observationName
abbrev generalityName := SFT.QuantumComputation.ReversibleGrammar.generalityName
abbrev additionName := SFT.QuantumComputation.ReversibleGrammar.additionName
end SFT.QuantumComputation.CircuitGrammar

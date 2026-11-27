import SFT.Chemistry.Rearrangement
import SFT.Chemistry.RearrangementAnalysis
import SFT.Chemistry.RearrangementEvidence
import SFT.Chemistry.RearrangementExperiment
import SFT.Chemistry.RearrangementGrammar
import SFT.Chemistry.RearrangementSource
import SFT.Chemistry.RearrangementValidation
import SFT.Chemistry.RearrangementWitnessProofs
import SFT.Chemistry.RearrangementWitnesses
import SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource
import SFT.Chemistry.RearrangementWitnessGraphs.DegenerateTerminal
import SFT.Chemistry.RearrangementWitnessGraphs.MultiSource
import SFT.Chemistry.RearrangementWitnessGraphs.MultiTerminal
import SFT.Chemistry.RearrangementWitnessGraphs.SingleSource
import SFT.Chemistry.RearrangementWitnessGraphs.SingleTerminal
import SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource
import SFT.Chemistry.RearrangementWitnessGraphs.SuccessorTerminal
import SFT.Chemistry.RearrangementResults.Degenerate
import SFT.Chemistry.RearrangementResults.Multi
import SFT.Chemistry.RearrangementResults.MultiReverse
import SFT.Chemistry.RearrangementResults.Single
import SFT.Chemistry.RearrangementResults.Successor
#print axioms SFT.Chemistry.Rearrangement.incidence
#print axioms SFT.Chemistry.Rearrangement.atomIndex
#print axioms SFT.Chemistry.Rearrangement.sameIndexEdge
#print axioms SFT.Chemistry.Rearrangement.unlabelledAdjacencies
#print axioms SFT.Chemistry.Rearrangement.mappedIndex
#print axioms SFT.Chemistry.Rearrangement.graphIsomorphic
#print axioms SFT.Chemistry.Rearrangement.allIncidences
#print axioms SFT.Chemistry.Rearrangement.transform
#print axioms SFT.Chemistry.Rearrangement.sameIncidences
#print axioms SFT.Chemistry.Rearrangement.reverseReconstruction
#print axioms SFT.Chemistry.Rearrangement.extend
#print axioms SFT.Chemistry.RearrangementAnalysis.textHash
#print axioms SFT.Chemistry.RearrangementAnalysis.normalizedPage
#print axioms SFT.Chemistry.RearrangementAnalysis.integer
#print axioms SFT.Chemistry.RearrangementAnalysis.pageAt
#print axioms SFT.Chemistry.RearrangementAnalysis.pad2
#print axioms SFT.Chemistry.RearrangementAnalysis.definition
#print axioms SFT.Chemistry.RearrangementAnalysis.pairPassed
#print axioms SFT.Chemistry.RearrangementAnalysis.pairCheck
#print axioms SFT.Chemistry.RearrangementAnalysis.optimizationPassed
#print axioms SFT.Chemistry.RearrangementAnalysis.optimizationCheck
#print axioms SFT.Chemistry.RearrangementAnalysis.expectedTargets
#print axioms SFT.Chemistry.RearrangementAnalysis.analysis
#print axioms SFT.Chemistry.RearrangementEvidence.witnessPassed
#print axioms SFT.Chemistry.RearrangementEvidence.witnesses
#print axioms SFT.Chemistry.RearrangementEvidence.claimId
#print axioms SFT.Chemistry.RearrangementEvidence.dependencies
#print axioms SFT.Chemistry.RearrangementEvidence.candidateRecord
#print axioms SFT.Chemistry.RearrangementEvidence.completenessRecord
#print axioms SFT.Chemistry.RearrangementEvidence.registrationData
#print axioms SFT.Chemistry.RearrangementEvidence.registration
#print axioms SFT.Chemistry.RearrangementEvidence.generatedCandidateData
#print axioms SFT.Chemistry.RearrangementEvidence.censusData
#print axioms SFT.Chemistry.RearrangementEvidence.census
#print axioms SFT.Chemistry.RearrangementEvidence.decisionData
#print axioms SFT.Chemistry.RearrangementEvidence.decideCandidate
#print axioms SFT.Chemistry.RearrangementEvidence.closureValue
#print axioms SFT.Chemistry.RearrangementEvidence.exclusions
#print axioms SFT.Chemistry.RearrangementEvidence.closureData
#print axioms SFT.Chemistry.RearrangementEvidence.closure
#print axioms SFT.Chemistry.RearrangementEvidence.control
#print axioms SFT.Chemistry.RearrangementEvidence.runControls
#print axioms SFT.Chemistry.RearrangementEvidence.registrationNoAxioms
#print axioms SFT.Chemistry.RearrangementEvidence.registrationNoFreeParameters
#print axioms SFT.Chemistry.RearrangementEvidence.decisionSurvival
#print axioms SFT.Chemistry.RearrangementExperiment.claimId
#print axioms SFT.Chemistry.RearrangementExperiment.experimentId
#print axioms SFT.Chemistry.RearrangementExperiment.expectedLabel
#print axioms SFT.Chemistry.RearrangementExperiment.falsification
#print axioms SFT.Chemistry.RearrangementExperiment.sourceIds
#print axioms SFT.Chemistry.RearrangementExperiment.targetIds
#print axioms SFT.Chemistry.RearrangementExperiment.snapshotHashes
#print axioms SFT.Chemistry.RearrangementExperiment.predictionDocument
#print axioms SFT.Chemistry.RearrangementExperiment.registration
#print axioms SFT.Chemistry.RearrangementExperiment.programFields
#print axioms SFT.Chemistry.RearrangementExperiment.labelValue
#print axioms SFT.Chemistry.RearrangementExperiment.envelope
#print axioms SFT.Chemistry.RearrangementExperiment.dimensions
#print axioms SFT.Chemistry.RearrangementExperiment.distinct
#print axioms SFT.Chemistry.RearrangementExperiment.validateSpec
#print axioms SFT.Chemistry.RearrangementGrammar.carrierName
#print axioms SFT.Chemistry.RearrangementGrammar.atomsName
#print axioms SFT.Chemistry.RearrangementGrammar.supportsName
#print axioms SFT.Chemistry.RearrangementGrammar.adjacencyName
#print axioms SFT.Chemistry.RearrangementGrammar.pathName
#print axioms SFT.Chemistry.RearrangementGrammar.alternativesName
#print axioms SFT.Chemistry.RearrangementGrammar.observationName
#print axioms SFT.Chemistry.RearrangementGrammar.extensionName
#print axioms SFT.Chemistry.RearrangementGrammar.sourceFields
#print axioms SFT.Chemistry.RearrangementGrammar.candidateId
#print axioms SFT.Chemistry.RearrangementGrammar.exactForm
#print axioms SFT.Chemistry.RearrangementGrammar.survivorId
#print axioms SFT.Chemistry.RearrangementGrammar.survives
#print axioms SFT.Chemistry.RearrangementGrammar.criteriaDecision
#print axioms SFT.Chemistry.RearrangementGrammar.decisionReason
#print axioms SFT.Chemistry.RearrangementGrammar.generationRule
#print axioms SFT.Chemistry.RearrangementGrammar.grammarBoundary
#print axioms SFT.Chemistry.RearrangementGrammar.candidates
#print axioms SFT.Chemistry.RearrangementGrammar.survivor
#print axioms SFT.Chemistry.RearrangementGrammar.generatedCardinality
#print axioms SFT.Chemistry.RearrangementGrammar.candidatesComplete
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0000
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0001
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0010
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0011
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0100
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0101
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0110
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock0111
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1000
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1001
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1010
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1011
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1100
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1101
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1110
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionBlock1111
#print axioms SFT.Chemistry.RearrangementGrammar.sourceDecisionMatchesCriteria
#print axioms SFT.Chemistry.RearrangementGrammar.carrierCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.atomsCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.supportsCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.adjacencyCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.pathCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.alternativesCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.observationCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.extensionCriterion
#print axioms SFT.Chemistry.RearrangementGrammar.uniqueCriteriaSurvivor
#print axioms SFT.Chemistry.RearrangementGrammar.uniqueSurvivor
#print axioms SFT.Chemistry.RearrangementGrammar.survivorAccepted
#print axioms SFT.Chemistry.RearrangementGrammar.ExactCriteria
#print axioms SFT.Chemistry.RearrangementGrammar.acceptanceIffExactCriteria
#print axioms SFT.Chemistry.RearrangementGrammar.carrier_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.atoms_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.supports_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.adjacency_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.path_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.alternatives_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.observation_rejected_rejected
#print axioms SFT.Chemistry.RearrangementGrammar.extension_rejected_rejected
#print axioms SFT.Chemistry.RearrangementSource.authorities
#print axioms SFT.Chemistry.RearrangementSource.authority
#print axioms SFT.Chemistry.RearrangementValidation.inputValues
#print axioms SFT.Chemistry.RearrangementValidation.sealPrediction
#print axioms SFT.Chemistry.RearrangementValidation.certificate
#print axioms SFT.Chemistry.RearrangementValidation.isolation
#print axioms SFT.Chemistry.RearrangementValidation.custodyCertificate
#print axioms SFT.Chemistry.RearrangementValidation.stringField
#print axioms SFT.Chemistry.RearrangementValidation.messages
#print axioms SFT.Chemistry.RearrangementValidation.validate
#print axioms SFT.Chemistry.RearrangementWitnessProofs.successorPassed
#print axioms SFT.Chemistry.RearrangementWitnessProofs.reversePassed
#print axioms SFT.Chemistry.RearrangementWitnessProofs.unchangedRejected
#print axioms SFT.Chemistry.RearrangementWitnessProofs.compositionRejected
#print axioms SFT.Chemistry.RearrangementWitnessProofs.operationalWitnesses
#print axioms SFT.Chemistry.RearrangementWitnesses.singleMove
#print axioms SFT.Chemistry.RearrangementWitnesses.threeMoves
#print axioms SFT.Chemistry.RearrangementWitnesses.degenerate
#print axioms SFT.Chemistry.RearrangementWitnesses.witnesses
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateTerminal.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateTerminal.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateTerminal.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.DegenerateTerminal.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiSource.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiSource.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiSource.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiSource.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiTerminal.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiTerminal.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiTerminal.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.MultiTerminal.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleSource.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleSource.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleSource.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleSource.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleTerminal.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleTerminal.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleTerminal.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SingleTerminal.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorTerminal.sourceSame
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorTerminal.sourceSameGraph
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorTerminal.sourceSameComponents
#print axioms SFT.Chemistry.RearrangementWitnessGraphs.SuccessorTerminal.sourceOrderedComponents
#print axioms SFT.Chemistry.RearrangementResults.Degenerate.expected
#print axioms SFT.Chemistry.RearrangementResults.Degenerate.result
#print axioms SFT.Chemistry.RearrangementResults.Degenerate.transformResult
#print axioms SFT.Chemistry.RearrangementResults.Multi.expected
#print axioms SFT.Chemistry.RearrangementResults.Multi.result
#print axioms SFT.Chemistry.RearrangementResults.Multi.transformResult
#print axioms SFT.Chemistry.RearrangementResults.MultiReverse.expected
#print axioms SFT.Chemistry.RearrangementResults.MultiReverse.result
#print axioms SFT.Chemistry.RearrangementResults.MultiReverse.transformResult
#print axioms SFT.Chemistry.RearrangementResults.Single.expected
#print axioms SFT.Chemistry.RearrangementResults.Single.result
#print axioms SFT.Chemistry.RearrangementResults.Single.transformResult
#print axioms SFT.Chemistry.RearrangementResults.Successor.expected
#print axioms SFT.Chemistry.RearrangementResults.Successor.result
#print axioms SFT.Chemistry.RearrangementResults.Successor.transformResult

import SFT.Physics.ThermalHistory
import SFT.Physics.ThermalHistoryTransport
import SFT.Physics.ThermalHistoryCertificate
import SFT.Physics.ThermalHistoryHorizon
import SFT.Physics.ThermalHistoryVisibility
import SFT.Physics.ThermalHistoryThresholds
import SFT.Physics.ThermalHistoryOrder
import SFT.Physics.ThermalHistoryAcoustic
import SFT.Physics.ThermalHistoryGrammarBase
import SFT.Physics.ThermalHistoryCensus0
import SFT.Physics.ThermalHistoryCensus1
import SFT.Physics.ThermalHistoryCensus2
import SFT.Physics.ThermalHistoryCensus3
import SFT.Physics.ThermalHistoryCensus4
import SFT.Physics.ThermalHistoryCensus5
import SFT.Physics.ThermalHistoryCensus6
import SFT.Physics.ThermalHistoryCensus7
import SFT.Physics.ThermalHistoryCensus8
import SFT.Physics.ThermalHistoryCensus9
import SFT.Physics.ThermalHistoryCensus10
import SFT.Physics.ThermalHistoryCensus11
import SFT.Physics.ThermalHistoryCensus12
import SFT.Physics.ThermalHistoryCensus13
import SFT.Physics.ThermalHistoryCensus14
import SFT.Physics.ThermalHistoryCensus15
import SFT.Physics.ThermalHistoryGrammar
import SFT.Physics.ThermalHistoryWitnesses
import SFT.Physics.ThermalHistoryEntryEvidence
#print axioms SFT.Physics.ThermalHistory.requirePositive
#print axioms SFT.Physics.ThermalHistory.transportedTemperature
#print axioms SFT.Physics.ThermalHistory.temperatureScaleInvariant
#print axioms SFT.Physics.ThermalHistory.insertDescending
#print axioms SFT.Physics.ThermalHistory.sortDescending
#print axioms SFT.Physics.ThermalHistory.distinct
#print axioms SFT.Physics.ThermalHistory.orderedThresholds
#print axioms SFT.Physics.ThermalHistory.orbitLoop
#print axioms SFT.Physics.ThermalHistory.liveDepthSevenOrbit
#print axioms SFT.Physics.ThermalHistory.CaptureLedger
#print axioms SFT.Physics.ThermalHistory.freezeoutCaptureLedger
#print axioms SFT.Physics.ThermalHistory.Visibility
#print axioms SFT.Physics.ThermalHistory.visibilityAt
#print axioms SFT.Physics.ThermalHistory.visibilityLedger
#print axioms SFT.Physics.ThermalHistory.AcousticMode
#print axioms SFT.Physics.ThermalHistory.acousticModeLedger
#print axioms SFT.Physics.ThermalHistory.horizonSegments
#print axioms SFT.Physics.ThermalHistory.finiteSoundHorizon
#print axioms SFT.Physics.ThermalHistory.originalOrbit
#print axioms SFT.Physics.ThermalHistory.originalCaptureShares
#print axioms SFT.Physics.ThermalHistoryTransport.admittedPositive
#print axioms SFT.Physics.ThermalHistoryTransport.originalInverseTransport
#print axioms SFT.Physics.ThermalHistoryTransport.originalHeldProduct
#print axioms SFT.Physics.ThermalHistoryTransport.originalInvariant
#print axioms SFT.Physics.ThermalHistoryCertificate.Certificate
#print axioms SFT.Physics.ThermalHistoryCertificate.ratListsEqual
#print axioms SFT.Physics.ThermalHistoryCertificate.certificate
#print axioms SFT.Physics.ThermalHistoryCertificate.originalCertificateFlags
#print axioms SFT.Physics.ThermalHistoryCertificate.originalCertificateQuantities
#print axioms SFT.Physics.ThermalHistoryHorizon.segmentValue
#print axioms SFT.Physics.ThermalHistoryHorizon.originalSegments
#print axioms SFT.Physics.ThermalHistoryHorizon.originalPositiveSum
#print axioms SFT.Physics.ThermalHistoryHorizon.originalFiniteHorizon
#print axioms SFT.Physics.ThermalHistoryVisibility.weights
#print axioms SFT.Physics.ThermalHistoryVisibility.sumRetains
#print axioms SFT.Physics.ThermalHistoryVisibility.originalWeightTotalPositive
#print axioms SFT.Physics.ThermalHistoryVisibility.originalNormalizedWeights
#print axioms SFT.Physics.ThermalHistoryVisibility.originalNormalizedTotal
#print axioms SFT.Physics.ThermalHistoryVisibility.originalVisibilityComplete
#print axioms SFT.Physics.ThermalHistoryVisibility.originalMidpointDecomposition
#print axioms SFT.Physics.ThermalHistoryVisibility.originalSideBelowMidpoint
#print axioms SFT.Physics.ThermalHistoryVisibility.originalReflectedSideBelowMidpoint
#print axioms SFT.Physics.ThermalHistoryVisibility.originalEveryWeightPositive
#print axioms SFT.Physics.ThermalHistoryVisibility.originalNormalizedRecord
#print axioms SFT.Physics.ThermalHistoryVisibility.originalNormalizedMidpointDecomposition
#print axioms SFT.Physics.ThermalHistoryVisibility.originalNormalizedSideStrict
#print axioms SFT.Physics.ThermalHistoryVisibility.originalNormalizedReflectedSideStrict
#print axioms SFT.Physics.ThermalHistoryVisibility.originalUniqueNormalizedMidpoint
#print axioms SFT.Physics.ThermalHistoryThresholds.originalInsertionRetains
#print axioms SFT.Physics.ThermalHistoryThresholds.originalSortRetains
#print axioms SFT.Physics.ThermalHistoryOrder.originalPositiveComparison
#print axioms SFT.Physics.ThermalHistoryOrder.insertPositive
#print axioms SFT.Physics.ThermalHistoryOrder.sortPositive
#print axioms SFT.Physics.ThermalHistoryOrder.originalInsertionProjection
#print axioms SFT.Physics.ThermalHistoryOrder.originalSortProjection
#print axioms SFT.Physics.ThermalHistoryOrder.Descending
#print axioms SFT.Physics.ThermalHistoryOrder.originalInsertionDescending
#print axioms SFT.Physics.ThermalHistoryOrder.originalPositiveSortDescending
#print axioms SFT.Physics.ThermalHistoryOrder.originalSortDescending
#print axioms SFT.Physics.ThermalHistoryOrder.originalThresholdGuard
#print axioms SFT.Physics.ThermalHistoryOrder.originalAcceptedThresholds
#print axioms SFT.Physics.ThermalHistoryOrder.originalAcceptedDescending
#print axioms SFT.Physics.ThermalHistoryAcoustic.row
#print axioms SFT.Physics.ThermalHistoryAcoustic.rows
#print axioms SFT.Physics.ThermalHistoryAcoustic.originalModeLedger
#print axioms SFT.Physics.ThermalHistoryAcoustic.originalCompleteModeCount
#print axioms SFT.Physics.ThermalHistoryAcoustic.originalPositiveMode
#print axioms SFT.Physics.ThermalHistoryAcoustic.originalPhasePositive
#print axioms SFT.Physics.ThermalHistoryAcoustic.originalSuccessiveParity
#print axioms SFT.Physics.ThermalHistoryAcoustic.originalLoadingAlternates
#print axioms SFT.Physics.ThermalHistoryGrammar.provenanceName
#print axioms SFT.Physics.ThermalHistoryGrammar.temperatureName
#print axioms SFT.Physics.ThermalHistoryGrammar.thresholdName
#print axioms SFT.Physics.ThermalHistoryGrammar.freezeoutName
#print axioms SFT.Physics.ThermalHistoryGrammar.decayName
#print axioms SFT.Physics.ThermalHistoryGrammar.captureName
#print axioms SFT.Physics.ThermalHistoryGrammar.recombinationName
#print axioms SFT.Physics.ThermalHistoryGrammar.acousticName
#print axioms SFT.Physics.ThermalHistoryGrammar.Candidate
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceFields
#print axioms SFT.Physics.ThermalHistoryGrammar.candidateId
#print axioms SFT.Physics.ThermalHistoryGrammar.exactForm
#print axioms SFT.Physics.ThermalHistoryGrammar.survivorId
#print axioms SFT.Physics.ThermalHistoryGrammar.survives
#print axioms SFT.Physics.ThermalHistoryGrammar.criteriaDecision
#print axioms SFT.Physics.ThermalHistoryGrammar.decisionReason
#print axioms SFT.Physics.ThermalHistoryGrammar.generationRule
#print axioms SFT.Physics.ThermalHistoryGrammar.grammarBoundary
#print axioms SFT.Physics.ThermalHistoryGrammar.candidates
#print axioms SFT.Physics.ThermalHistoryGrammar.survivor
#print axioms SFT.Physics.ThermalHistoryGrammar.generatedCardinality
#print axioms SFT.Physics.ThermalHistoryGrammar.candidatesComplete
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk0
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk0
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk1
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk1
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk2
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk2
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk3
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk3
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk4
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk4
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk5
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk5
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk6
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk6
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk7
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk7
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk8
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk8
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk9
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk9
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk10
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk10
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk11
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk11
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk12
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk12
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk13
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk13
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk14
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk14
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionChunk15
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaChunk15
#print axioms SFT.Physics.ThermalHistoryGrammar.sourceDecisionMatchesCriteria
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueCriteriaSurvivor
#print axioms SFT.Physics.ThermalHistoryGrammar.uniqueSurvivor
#print axioms SFT.Physics.ThermalHistoryGrammar.survivorAccepted
#print axioms SFT.Physics.ThermalHistoryGrammar.ExactCriteria
#print axioms SFT.Physics.ThermalHistoryGrammar.acceptanceIffExactCriteria
#print axioms SFT.Physics.ThermalHistoryGrammar.provenance_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.temperature_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.threshold_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.freezeout_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.decay_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.capture_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.recombination_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryGrammar.acoustic_rejected_rejected
#print axioms SFT.Physics.ThermalHistoryWitnesses.Witness
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness0
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness0Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness1
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness1Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness2
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness2Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness3
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness3Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness4
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness4Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness5
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness5Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness6
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness6Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness7
#print axioms SFT.Physics.ThermalHistoryWitnesses.witness7Passed
#print axioms SFT.Physics.ThermalHistoryWitnesses.witnesses
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.witnessRecords
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.claimId
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.dependencies
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.candidateRecord
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.completenessRecord
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.registrationData
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.registration
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.generatedCandidateData
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.censusData
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.census
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.decisionData
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.decideCandidate
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.closureValue
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.closureData
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.closure
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.control
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.exclusions
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.controls
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.runControls
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.registrationNoAxioms
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.registrationNoFreeParameters
#print axioms SFT.Physics.ThermalHistoryEntryEvidence.decisionPreservesSurvival

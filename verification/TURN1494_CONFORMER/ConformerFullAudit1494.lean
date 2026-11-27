import SFT.Chemistry.ConformerCarrier
import SFT.Chemistry.ConformerIdentity
import SFT.Chemistry.ConformerReachSet
import SFT.Chemistry.ConformerIdentityValues
import SFT.Chemistry.ConformerIdentityFilters
import SFT.Chemistry.ConformerAdmittedGraph
import SFT.Chemistry.ConformerActionEnumeration
import SFT.Chemistry.ConformerAlphabetProofs
import SFT.Chemistry.ConformerPrediction
import SFT.Chemistry.ConformerSource
import SFT.Chemistry.ConformerAssignments
import SFT.Chemistry.ConformerCensus
import SFT.Chemistry.ConformerAnalysis
import SFT.Chemistry.ConformerRotorAction
import SFT.Chemistry.ConformerIdentityFold
import SFT.Chemistry.ConformerReadback
import SFT.Chemistry.ConformerOrbitProgress
import SFT.Chemistry.ConformerAssignmentMembership
import SFT.Chemistry.ConformerComparison
import SFT.Chemistry.ConformerGenerationGrammar
import SFT.Chemistry.ConformerGenerationEvidence
import SFT.Chemistry.ConformerExperiment
import SFT.Chemistry.ConformerGenerationProofs
import SFT.Chemistry.ConformerUniqueness
import SFT.Chemistry.ConformerGenerationClosure
import SFT.Chemistry.ConformerOrbitOrder
import SFT.Chemistry.ConformerPartition
import SFT.Chemistry.ConformerQuotientTrace
import SFT.Chemistry.ConformerReachability
import SFT.Chemistry.ConformerValidation
#print axioms SFT.Chemistry.ConformerCarrier.orderedBond
#print axioms SFT.Chemistry.ConformerCarrier.sameBond
#print axioms SFT.Chemistry.ConformerCarrier.positions
#print axioms SFT.Chemistry.ConformerCarrier.containsPosition
#print axioms SFT.Chemistry.ConformerCarrier.uniquePositions
#print axioms SFT.Chemistry.ConformerCarrier.distinctBonds
#print axioms SFT.Chemistry.ConformerCarrier.expand
#print axioms SFT.Chemistry.ConformerCarrier.reach
#print axioms SFT.Chemistry.ConformerCarrier.bondLE
#print axioms SFT.Chemistry.ConformerCarrier.insertBond
#print axioms SFT.Chemistry.ConformerCarrier.sortBonds
#print axioms SFT.Chemistry.ConformerCarrier.graph
#print axioms SFT.Chemistry.ConformerCarrier.validateRotor
#print axioms SFT.Chemistry.ConformerCarrier.reversedSites
#print axioms SFT.Chemistry.ConformerCarrier.reversalLookup
#print axioms SFT.Chemistry.ConformerCarrier.alphabet
#print axioms SFT.Chemistry.ConformerCarrier.reverseState
#print axioms SFT.Chemistry.ConformerCarrier.action
#print axioms SFT.Chemistry.ConformerCarrier.apply
#print axioms SFT.Chemistry.ConformerCarrier.allActions
#print axioms SFT.Chemistry.ConformerIdentity.identityPermutationGenerated
#print axioms SFT.Chemistry.ConformerIdentity.identityPosition
#print axioms SFT.Chemistry.ConformerIdentity.identitySiteWord
#print axioms SFT.Chemistry.ConformerIdentity.identityBond
#print axioms SFT.Chemistry.ConformerReachSet.positionMembership
#print axioms SFT.Chemistry.ConformerReachSet.uniquePositionsOfUnique
#print axioms SFT.Chemistry.ConformerReachSet.expansionUnique
#print axioms SFT.Chemistry.ConformerReachSet.expansionRetainsPrefix
#print axioms SFT.Chemistry.ConformerReachSet.expansionInside
#print axioms SFT.Chemistry.ConformerReachSet.expansionStopsExactly
#print axioms SFT.Chemistry.ConformerReachSet.expansionGrows
#print axioms SFT.Chemistry.ConformerIdentityValues.positionWithinSupport
#print axioms SFT.Chemistry.ConformerIdentityValues.positionsUnique
#print axioms SFT.Chemistry.ConformerIdentityValues.positionsLength
#print axioms SFT.Chemistry.ConformerIdentityValues.identityActionAccepted
#print axioms SFT.Chemistry.ConformerIdentityValues.countRetainsPosition
#print axioms SFT.Chemistry.ConformerIdentityValues.reconstructPositions
#print axioms SFT.Chemistry.ConformerIdentityValues.identityCandidateConstructed
#print axioms SFT.Chemistry.ConformerIdentityFilters.identityAtomResults
#print axioms SFT.Chemistry.ConformerIdentityFilters.identityAtomFlagsPass
#print axioms SFT.Chemistry.ConformerIdentityFilters.normalizedBondFixed
#print axioms SFT.Chemistry.ConformerIdentityFilters.identityBondResults
#print axioms SFT.Chemistry.ConformerIdentityFilters.identityBondFlagsPass
#print axioms SFT.Chemistry.ConformerIdentityFilters.identityCandidatePassesFilters
#print axioms SFT.Chemistry.ConformerAdmittedGraph.normalizationProducesFixed
#print axioms SFT.Chemistry.ConformerAdmittedGraph.acceptedGraphConditions
#print axioms SFT.Chemistry.ConformerActionEnumeration.mappedResultRetained
#print axioms SFT.Chemistry.ConformerActionEnumeration.mappedInputSucceeds
#print axioms SFT.Chemistry.ConformerActionEnumeration.admittedEnumerationRetainsIdentity
#print axioms SFT.Chemistry.ConformerAlphabetProofs.checkedStatesDistinct
#print axioms SFT.Chemistry.ConformerAlphabetProofs.acceptedInputStatesDistinct
#print axioms SFT.Chemistry.ConformerAlphabetProofs.acceptedStatesRetained
#print axioms SFT.Chemistry.ConformerPrediction.identityHash
#print axioms SFT.Chemistry.ConformerPrediction.get
#print axioms SFT.Chemistry.ConformerPrediction.equal
#print axioms SFT.Chemistry.ConformerPrediction.identities
#print axioms SFT.Chemistry.ConformerPrediction.identityText
#print axioms SFT.Chemistry.ConformerPrediction.recordInstructions
#print axioms SFT.Chemistry.ConformerPrediction.predictionDocument
#print axioms SFT.Chemistry.ConformerSource.identityKeys
#print axioms SFT.Chemistry.ConformerSource.predictionMap
#print axioms SFT.Chemistry.ConformerSource.bindTarget
#print axioms SFT.Chemistry.ConformerSource.sourceRows
#print axioms SFT.Chemistry.ConformerAssignments.productStates
#print axioms SFT.Chemistry.ConformerAssignments.generate
#print axioms SFT.Chemistry.ConformerAssignments.sameSites
#print axioms SFT.Chemistry.ConformerAssignments.targetMatches
#print axioms SFT.Chemistry.ConformerAssignments.transformRotor
#print axioms SFT.Chemistry.ConformerAssignments.readback
#print axioms SFT.Chemistry.ConformerAssignments.applyAction
#print axioms SFT.Chemistry.ConformerAssignments.productEmpty
#print axioms SFT.Chemistry.ConformerAssignments.productStep
#print axioms SFT.Chemistry.ConformerCensus.containsAssignment
#print axioms SFT.Chemistry.ConformerCensus.uniqueAssignments
#print axioms SFT.Chemistry.ConformerCensus.construct
#print axioms SFT.Chemistry.ConformerCensus.quotientStep
#print axioms SFT.Chemistry.ConformerCensus.quotient
#print axioms SFT.Chemistry.ConformerCensus.census
#print axioms SFT.Chemistry.ConformerCensus.anti
#print axioms SFT.Chemistry.ConformerCensus.gaucheForward
#print axioms SFT.Chemistry.ConformerCensus.gaucheReverse
#print axioms SFT.Chemistry.ConformerCensus.butane
#print axioms SFT.Chemistry.ConformerCensus.generationWitness
#print axioms SFT.Chemistry.ConformerCensus.automorphismWitness
#print axioms SFT.Chemistry.ConformerCensus.quotientWitness
#print axioms SFT.Chemistry.ConformerCensus.partitionWitness
#print axioms SFT.Chemistry.ConformerCensus.reversalWitness
#print axioms SFT.Chemistry.ConformerCensus.pathWitness
#print axioms SFT.Chemistry.ConformerCensus.generationPassed
#print axioms SFT.Chemistry.ConformerCensus.automorphismPassed
#print axioms SFT.Chemistry.ConformerCensus.quotientPassed
#print axioms SFT.Chemistry.ConformerCensus.partitionPassed
#print axioms SFT.Chemistry.ConformerCensus.reversalPassed
#print axioms SFT.Chemistry.ConformerCensus.pathPassed
#print axioms SFT.Chemistry.ConformerAnalysis.array
#print axioms SFT.Chemistry.ConformerAnalysis.cell
#print axioms SFT.Chemistry.ConformerAnalysis.unicodeQuote
#print axioms SFT.Chemistry.ConformerAnalysis.display
#print axioms SFT.Chemistry.ConformerAnalysis.displayValues
#print axioms SFT.Chemistry.ConformerAnalysis.displayFields
#print axioms SFT.Chemistry.ConformerAnalysis.byRole
#print axioms SFT.Chemistry.ConformerAnalysis.headerRepr
#print axioms SFT.Chemistry.ConformerAnalysis.table
#print axioms SFT.Chemistry.ConformerAnalysis.valueAt
#print axioms SFT.Chemistry.ConformerAnalysis.analysis
#print axioms SFT.Chemistry.ConformerRotorAction.identicalSitesMatch
#print axioms SFT.Chemistry.ConformerRotorAction.directTargetRetained
#print axioms SFT.Chemistry.ConformerRotorAction.uniqueIdentityMatch
#print axioms SFT.Chemistry.ConformerRotorAction.identityMappedMatch
#print axioms SFT.Chemistry.ConformerRotorAction.identitySuccessfulStep
#print axioms SFT.Chemistry.ConformerIdentityFold.identityFoldRetains
#print axioms SFT.Chemistry.ConformerIdentityFold.sourceRowIndex
#print axioms SFT.Chemistry.ConformerIdentityFold.identityOriginalFold
#print axioms SFT.Chemistry.ConformerIdentityFold.originalZipCoversAssignment
#print axioms SFT.Chemistry.ConformerIdentityFold.indexedStateProjection
#print axioms SFT.Chemistry.ConformerIdentityFold.identityCompleteFold
#print axioms SFT.Chemistry.ConformerReadback.completeIndexedReadback
#print axioms SFT.Chemistry.ConformerReadback.successfulIdentityAction
#print axioms SFT.Chemistry.ConformerOrbitProgress.acceptedRotorBounds
#print axioms SFT.Chemistry.ConformerOrbitProgress.validatedRotorBounds
#print axioms SFT.Chemistry.ConformerOrbitProgress.generatedImagesContainAnchor
#print axioms SFT.Chemistry.ConformerOrbitProgress.dedupRetainsAnchor
#print axioms SFT.Chemistry.ConformerOrbitProgress.generatedOrbitContainsAnchor
#print axioms SFT.Chemistry.ConformerOrbitProgress.orbitRemovalDropsAnchor
#print axioms SFT.Chemistry.ConformerOrbitProgress.orbitRemovalShrinks
#print axioms SFT.Chemistry.ConformerAssignmentMembership.sameWordKeys
#print axioms SFT.Chemistry.ConformerAssignmentMembership.wordSelf
#print axioms SFT.Chemistry.ConformerAssignmentMembership.wordSymmetry
#print axioms SFT.Chemistry.ConformerAssignmentMembership.wordTransitivity
#print axioms SFT.Chemistry.ConformerAssignmentMembership.containsWitness
#print axioms SFT.Chemistry.ConformerAssignmentMembership.removalMember
#print axioms SFT.Chemistry.ConformerAssignmentMembership.removalContainsSubset
#print axioms SFT.Chemistry.ConformerAssignmentMembership.removalAnchorAbsent
#print axioms SFT.Chemistry.ConformerAssignmentMembership.uniqueOrigins
#print axioms SFT.Chemistry.ConformerAssignmentMembership.earliestAfterPrefix
#print axioms SFT.Chemistry.ConformerAssignmentMembership.noRemainingAfterFullScan
#print axioms SFT.Chemistry.ConformerComparison.expectedLaws
#print axioms SFT.Chemistry.ConformerComparison.cellAt
#print axioms SFT.Chemistry.ConformerComparison.compare
#print axioms SFT.Chemistry.ConformerComparison.controls
#print axioms SFT.Chemistry.ConformerComparison.analysisPassed
#print axioms SFT.Chemistry.ConformerGenerationGrammar.carrierName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.rotorName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.generationName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.symmetryName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.equivalenceName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.quotientName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.observationName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.extensionName
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceFields
#print axioms SFT.Chemistry.ConformerGenerationGrammar.candidateId
#print axioms SFT.Chemistry.ConformerGenerationGrammar.exactForm
#print axioms SFT.Chemistry.ConformerGenerationGrammar.survivorId
#print axioms SFT.Chemistry.ConformerGenerationGrammar.survives
#print axioms SFT.Chemistry.ConformerGenerationGrammar.criteriaDecision
#print axioms SFT.Chemistry.ConformerGenerationGrammar.decisionReason
#print axioms SFT.Chemistry.ConformerGenerationGrammar.generationRule
#print axioms SFT.Chemistry.ConformerGenerationGrammar.grammarBoundary
#print axioms SFT.Chemistry.ConformerGenerationGrammar.candidates
#print axioms SFT.Chemistry.ConformerGenerationGrammar.survivor
#print axioms SFT.Chemistry.ConformerGenerationGrammar.generatedCardinality
#print axioms SFT.Chemistry.ConformerGenerationGrammar.candidatesComplete
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0000
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0001
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0010
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0011
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0100
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0101
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0110
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock0111
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1000
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1001
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1010
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1011
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1100
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1101
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1110
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionBlock1111
#print axioms SFT.Chemistry.ConformerGenerationGrammar.sourceDecisionMatchesCriteria
#print axioms SFT.Chemistry.ConformerGenerationGrammar.carrierCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.rotorCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.generationCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.symmetryCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.equivalenceCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.quotientCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.observationCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.extensionCriterion
#print axioms SFT.Chemistry.ConformerGenerationGrammar.uniqueCriteriaSurvivor
#print axioms SFT.Chemistry.ConformerGenerationGrammar.uniqueSurvivor
#print axioms SFT.Chemistry.ConformerGenerationGrammar.survivorAccepted
#print axioms SFT.Chemistry.ConformerGenerationGrammar.ExactCriteria
#print axioms SFT.Chemistry.ConformerGenerationGrammar.acceptanceIffExactCriteria
#print axioms SFT.Chemistry.ConformerGenerationGrammar.carrier_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.rotor_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.generation_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.symmetry_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.equivalence_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.quotient_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.observation_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationGrammar.extension_rejected_rejected
#print axioms SFT.Chemistry.ConformerGenerationEvidence.witnesses
#print axioms SFT.Chemistry.ConformerGenerationEvidence.claimId
#print axioms SFT.Chemistry.ConformerGenerationEvidence.dependencies
#print axioms SFT.Chemistry.ConformerGenerationEvidence.candidateRecord
#print axioms SFT.Chemistry.ConformerGenerationEvidence.completenessRecord
#print axioms SFT.Chemistry.ConformerGenerationEvidence.registrationData
#print axioms SFT.Chemistry.ConformerGenerationEvidence.registration
#print axioms SFT.Chemistry.ConformerGenerationEvidence.generatedCandidateData
#print axioms SFT.Chemistry.ConformerGenerationEvidence.censusData
#print axioms SFT.Chemistry.ConformerGenerationEvidence.census
#print axioms SFT.Chemistry.ConformerGenerationEvidence.decisionData
#print axioms SFT.Chemistry.ConformerGenerationEvidence.decideCandidate
#print axioms SFT.Chemistry.ConformerGenerationEvidence.closureValue
#print axioms SFT.Chemistry.ConformerGenerationEvidence.exclusions
#print axioms SFT.Chemistry.ConformerGenerationEvidence.closureData
#print axioms SFT.Chemistry.ConformerGenerationEvidence.closure
#print axioms SFT.Chemistry.ConformerGenerationEvidence.control
#print axioms SFT.Chemistry.ConformerGenerationEvidence.runControls
#print axioms SFT.Chemistry.ConformerGenerationEvidence.registrationNoAxioms
#print axioms SFT.Chemistry.ConformerGenerationEvidence.registrationNoFreeParameters
#print axioms SFT.Chemistry.ConformerGenerationEvidence.decisionSurvival
#print axioms SFT.Chemistry.ConformerExperiment.claimId
#print axioms SFT.Chemistry.ConformerExperiment.experimentId
#print axioms SFT.Chemistry.ConformerExperiment.expectedLabel
#print axioms SFT.Chemistry.ConformerExperiment.falsification
#print axioms SFT.Chemistry.ConformerExperiment.targetRegistryHash
#print axioms SFT.Chemistry.ConformerExperiment.sourceFiles
#print axioms SFT.Chemistry.ConformerExperiment.references
#print axioms SFT.Chemistry.ConformerExperiment.registration
#print axioms SFT.Chemistry.ConformerExperiment.labelValue
#print axioms SFT.Chemistry.ConformerExperiment.envelope
#print axioms SFT.Chemistry.ConformerExperiment.specDimensions
#print axioms SFT.Chemistry.ConformerExperiment.specWitnesses
#print axioms SFT.Chemistry.ConformerExperiment.validateSpec
#print axioms SFT.Chemistry.ConformerGenerationProofs.choices
#print axioms SFT.Chemistry.ConformerGenerationProofs.generatedHasEveryChoice
#print axioms SFT.Chemistry.ConformerGenerationProofs.everyChoiceIsGenerated
#print axioms SFT.Chemistry.ConformerGenerationProofs.exactGeneratedCarrier
#print axioms SFT.Chemistry.ConformerGenerationProofs.assignmentRetainsEveryRotor
#print axioms SFT.Chemistry.ConformerGenerationProofs.productCount
#print axioms SFT.Chemistry.ConformerGenerationProofs.generatedCardinality
#print axioms SFT.Chemistry.ConformerUniqueness.generatedExactlyOnce
#print axioms SFT.Chemistry.ConformerGenerationClosure.admittedProductCompleteAndUnique
#print axioms SFT.Chemistry.ConformerOrbitOrder.orbitOrderRetained
#print axioms SFT.Chemistry.ConformerOrbitOrder.orbitMembersExact
#print axioms SFT.Chemistry.ConformerOrbitOrder.firstRemaining
#print axioms SFT.Chemistry.ConformerOrbitOrder.removalOrderRetained
#print axioms SFT.Chemistry.ConformerOrbitOrder.firstRemainingDecomposition
#print axioms SFT.Chemistry.ConformerPartition.acceptedFields
#print axioms SFT.Chemistry.ConformerPartition.acceptedRotorGuard
#print axioms SFT.Chemistry.ConformerPartition.acceptedNonemptyGuard
#print axioms SFT.Chemistry.ConformerPartition.acceptedPartitionGuard
#print axioms SFT.Chemistry.ConformerQuotientTrace.orderedScanRunsOriginal
#print axioms SFT.Chemistry.ConformerQuotientTrace.quotientRunsOriginal
#print axioms SFT.Chemistry.ConformerReachability.registeredCardinality
#print axioms SFT.Chemistry.ConformerReachability.boundedReachRunsOriginal
#print axioms SFT.Chemistry.ConformerReachability.originalRunEndsFixed
#print axioms SFT.Chemistry.ConformerReachability.initialReachRunsOriginal
#print axioms SFT.Chemistry.ConformerReachability.initialReachFixed
#print axioms SFT.Chemistry.ConformerValidation.inputValues
#print axioms SFT.Chemistry.ConformerValidation.sealPrediction
#print axioms SFT.Chemistry.ConformerValidation.certificate
#print axioms SFT.Chemistry.ConformerValidation.isolation
#print axioms SFT.Chemistry.ConformerValidation.custodyCertificate
#print axioms SFT.Chemistry.ConformerValidation.boolText
#print axioms SFT.Chemistry.ConformerValidation.rowText
#print axioms SFT.Chemistry.ConformerValidation.rowPassed
#print axioms SFT.Chemistry.ConformerValidation.measurementPayload
#print axioms SFT.Chemistry.ConformerValidation.validate

import SFT.Mathematics.FiniteRefinement
import SFT.Mathematics.FiniteDifferenceBounds
import SFT.Mathematics.DyadicClosure
import SFT.Mathematics.LimitComputations
import SFT.Mathematics.LimitContinuumGrammarBase
import SFT.Mathematics.LimitContinuumCensus0
import SFT.Mathematics.LimitContinuumCensus1
import SFT.Mathematics.LimitContinuumCensus2
import SFT.Mathematics.LimitContinuumCensus3
import SFT.Mathematics.LimitContinuumCensus4
import SFT.Mathematics.LimitContinuumCensus5
import SFT.Mathematics.LimitContinuumCensus6
import SFT.Mathematics.LimitContinuumCensus7
import SFT.Mathematics.LimitContinuumCensus8
import SFT.Mathematics.LimitContinuumCensus9
import SFT.Mathematics.LimitContinuumCensus10
import SFT.Mathematics.LimitContinuumCensus11
import SFT.Mathematics.LimitContinuumCensus12
import SFT.Mathematics.LimitContinuumCensus13
import SFT.Mathematics.LimitContinuumCensus14
import SFT.Mathematics.LimitContinuumCensus15
import SFT.Mathematics.LimitContinuumGrammar
import SFT.Mathematics.LimitContinuumWitnesses
import SFT.Mathematics.LimitContinuumControls
import SFT.Mathematics.LimitContinuumEvidence
#print axioms SFT.Mathematics.FiniteRefinement.rung
#print axioms SFT.Mathematics.FiniteRefinement.run
#print axioms SFT.Mathematics.FiniteRefinement.rungPositive
#print axioms SFT.Mathematics.FiniteRefinement.successorReturns
#print axioms SFT.Mathematics.FiniteRefinement.countedReturn
#print axioms SFT.Mathematics.FiniteRefinement.successorNotOne
#print axioms SFT.Mathematics.FiniteRefinement.remainingRung
#print axioms SFT.Mathematics.FiniteRefinement.noEarlierReturn
#print axioms SFT.Mathematics.FiniteRefinement.everyDepthHasNext
#print axioms SFT.Mathematics.FiniteRefinement.sameDenominator
#print axioms SFT.Mathematics.FiniteRefinement.dyadicRepresentation
#print axioms SFT.Mathematics.FiniteDifferenceBounds.addMul
#print axioms SFT.Mathematics.FiniteDifferenceBounds.quadraticCentered
#print axioms SFT.Mathematics.FiniteDifferenceBounds.cubicForward
#print axioms SFT.Mathematics.FiniteDifferenceBounds.errorBound
#print axioms SFT.Mathematics.FiniteDifferenceBounds.errorPositive
#print axioms SFT.Mathematics.FiniteDifferenceBounds.errorValue
#print axioms SFT.Mathematics.FiniteDifferenceBounds.dyadicDenominatorStep
#print axioms SFT.Mathematics.FiniteDifferenceBounds.errorHalves
#print axioms SFT.Mathematics.FiniteDifferenceBounds.errorStrictlyDecreases
#print axioms SFT.Mathematics.FiniteDifferenceBounds.dyadicExceedsIndex
#print axioms SFT.Mathematics.FiniteDifferenceBounds.finiteErrorCertificate
#print axioms SFT.Mathematics.DyadicClosure.weights
#print axioms SFT.Mathematics.DyadicClosure.total
#print axioms SFT.Mathematics.DyadicClosure.totalAppend
#print axioms SFT.Mathematics.DyadicClosure.totalDouble
#print axioms SFT.Mathematics.DyadicClosure.weightSuccessor
#print axioms SFT.Mathematics.DyadicClosure.completeLedger
#print axioms SFT.Mathematics.DyadicClosure.closedLedger
#print axioms SFT.Mathematics.DyadicClosure.closesToOne
#print axioms SFT.Mathematics.DyadicClosure.originalFiveTerms
#print axioms SFT.Mathematics.DyadicClosure.originalClosure
#print axioms SFT.Mathematics.LimitComputations.whole
#print axioms SFT.Mathematics.LimitComputations.spacing
#print axioms SFT.Mathematics.LimitComputations.square
#print axioms SFT.Mathematics.LimitComputations.cube
#print axioms SFT.Mathematics.LimitComputations.quadratic
#print axioms SFT.Mathematics.LimitComputations.cubic
#print axioms SFT.Mathematics.LimitComputations.cubicError
#print axioms SFT.Mathematics.LimitComputations.equalNonnegative
#print axioms SFT.Mathematics.LimitComputations.equalNegative
#print axioms SFT.Mathematics.LimitComputations.equalInt
#print axioms SFT.Mathematics.LimitComputations.equalRat
#print axioms SFT.Mathematics.LimitComputations.terms
#print axioms SFT.Mathematics.LimitComputations.ledger
#print axioms SFT.Mathematics.LimitComputations.finiteRungs
#print axioms SFT.Mathematics.LimitComputations.quadraticWitness
#print axioms SFT.Mathematics.LimitComputations.cubicWitness
#print axioms SFT.Mathematics.LimitComputations.closureWitness
#print axioms SFT.Mathematics.LimitComputations.finiteRungsPassed
#print axioms SFT.Mathematics.LimitComputations.quadraticPassed
#print axioms SFT.Mathematics.LimitComputations.cubicPassed
#print axioms SFT.Mathematics.LimitComputations.closurePassed
#print axioms SFT.Mathematics.LimitContinuumGrammar.Object
#print axioms SFT.Mathematics.LimitContinuumGrammar.objectName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Successor
#print axioms SFT.Mathematics.LimitContinuumGrammar.successorName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Refinement
#print axioms SFT.Mathematics.LimitContinuumGrammar.refinementName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Convergence
#print axioms SFT.Mathematics.LimitContinuumGrammar.convergenceName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Continuum
#print axioms SFT.Mathematics.LimitContinuumGrammar.continuumName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Cardinality
#print axioms SFT.Mathematics.LimitContinuumGrammar.cardinalityName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Generality
#print axioms SFT.Mathematics.LimitContinuumGrammar.generalityName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Addition
#print axioms SFT.Mathematics.LimitContinuumGrammar.additionName
#print axioms SFT.Mathematics.LimitContinuumGrammar.Candidate
#print axioms SFT.Mathematics.LimitContinuumGrammar.sourceFields
#print axioms SFT.Mathematics.LimitContinuumGrammar.candidateId
#print axioms SFT.Mathematics.LimitContinuumGrammar.exactForm
#print axioms SFT.Mathematics.LimitContinuumGrammar.survivorId
#print axioms SFT.Mathematics.LimitContinuumGrammar.survives
#print axioms SFT.Mathematics.LimitContinuumGrammar.criteriaDecision
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionReason
#print axioms SFT.Mathematics.LimitContinuumGrammar.generationRule
#print axioms SFT.Mathematics.LimitContinuumGrammar.grammarBoundary
#print axioms SFT.Mathematics.LimitContinuumGrammar.candidates
#print axioms SFT.Mathematics.LimitContinuumGrammar.survivor
#print axioms SFT.Mathematics.LimitContinuumGrammar.generatedCardinality
#print axioms SFT.Mathematics.LimitContinuumGrammar.candidatesComplete
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus0
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus0
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus1
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus1
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus2
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus2
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus3
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus3
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus4
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus4
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus5
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus5
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus6
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus6
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus7
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus7
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus8
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus8
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus9
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus9
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus10
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus10
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus11
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus11
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus12
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus12
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus13
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus13
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus14
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus14
#print axioms SFT.Mathematics.LimitContinuumGrammar.decisionCensus15
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCensus15
#print axioms SFT.Mathematics.LimitContinuumGrammar.sourceDecisionMatchesCriteria
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueCriteriaSurvivor
#print axioms SFT.Mathematics.LimitContinuumGrammar.uniqueSurvivor
#print axioms SFT.Mathematics.LimitContinuumGrammar.survivorAccepted
#print axioms SFT.Mathematics.LimitContinuumGrammar.ExactCriteria
#print axioms SFT.Mathematics.LimitContinuumGrammar.acceptanceIffExactCriteria
#print axioms SFT.Mathematics.LimitContinuumGrammar.object_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.successor_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.refinement_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.convergence_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.continuum_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.cardinality_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.generality_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumGrammar.addition_rejected_rejected
#print axioms SFT.Mathematics.LimitContinuumWitnesses.Witness
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check0
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check0Passed
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check1
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check1Passed
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check2
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check2Passed
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check3
#print axioms SFT.Mathematics.LimitContinuumWitnesses.check3Passed
#print axioms SFT.Mathematics.LimitContinuumWitnesses.witnesses
#print axioms SFT.Mathematics.LimitContinuumWitnesses.allWitnessesPass
#print axioms SFT.Mathematics.LimitContinuumControls.laws
#print axioms SFT.Mathematics.LimitContinuumControls.exclusions
#print axioms SFT.Mathematics.LimitContinuumControls.closureValue
#print axioms SFT.Mathematics.LimitContinuumControls.falseCandidate
#print axioms SFT.Mathematics.LimitContinuumControls.survivorIds
#print axioms SFT.Mathematics.LimitContinuumControls.distinctIdentifiers
#print axioms SFT.Mathematics.LimitContinuumControls.falsePremise
#print axioms SFT.Mathematics.LimitContinuumControls.tamperedSource
#print axioms SFT.Mathematics.LimitContinuumControls.tamperedArtifact
#print axioms SFT.Mathematics.LimitContinuumControls.boundary
#print axioms SFT.Mathematics.LimitContinuumControls.falsePremisePassed
#print axioms SFT.Mathematics.LimitContinuumControls.boundaryPassed
#print axioms SFT.Mathematics.LimitContinuumControls.controlRecords
#print axioms SFT.Mathematics.LimitContinuumControls.runControls
#print axioms SFT.Mathematics.LimitContinuumEvidence.candidateRecord
#print axioms SFT.Mathematics.LimitContinuumEvidence.completenessRecord
#print axioms SFT.Mathematics.LimitContinuumEvidence.registrationData
#print axioms SFT.Mathematics.LimitContinuumEvidence.registration
#print axioms SFT.Mathematics.LimitContinuumEvidence.generatedCandidateData
#print axioms SFT.Mathematics.LimitContinuumEvidence.censusData
#print axioms SFT.Mathematics.LimitContinuumEvidence.census
#print axioms SFT.Mathematics.LimitContinuumEvidence.decisionData
#print axioms SFT.Mathematics.LimitContinuumEvidence.decision
#print axioms SFT.Mathematics.LimitContinuumEvidence.decideCandidate
#print axioms SFT.Mathematics.LimitContinuumEvidence.closureData
#print axioms SFT.Mathematics.LimitContinuumEvidence.closure
#print axioms SFT.Mathematics.LimitContinuumEvidence.nativeDecisionPreservesSurvival
#print axioms SFT.Mathematics.LimitContinuumEvidence.nativeDecisionPreservesReason
#print axioms SFT.Mathematics.LimitContinuumEvidence.registrationHasNoAxioms
#print axioms SFT.Mathematics.LimitContinuumEvidence.registrationHasNoFreeParameters
#print axioms SFT.Mathematics.LimitContinuumEvidence.lookupDependsOnlyOnIdentifier

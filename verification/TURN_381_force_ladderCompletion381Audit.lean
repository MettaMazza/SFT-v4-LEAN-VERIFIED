import SFT.Physics.PrimeSectorLadder
import SFT.Physics.ForceLadderGrammarBase
import SFT.Physics.ForceLadderCensus0
import SFT.Physics.ForceLadderCensus1
import SFT.Physics.ForceLadderCensus2
import SFT.Physics.ForceLadderCensus3
import SFT.Physics.ForceLadderCensus4
import SFT.Physics.ForceLadderCensus5
import SFT.Physics.ForceLadderCensus6
import SFT.Physics.ForceLadderCensus7
import SFT.Physics.ForceLadderCensus8
import SFT.Physics.ForceLadderCensus9
import SFT.Physics.ForceLadderCensus10
import SFT.Physics.ForceLadderCensus11
import SFT.Physics.ForceLadderCensus12
import SFT.Physics.ForceLadderCensus13
import SFT.Physics.ForceLadderCensus14
import SFT.Physics.ForceLadderCensus15
import SFT.Physics.ForceLadderGrammar
import SFT.Physics.ForceLadderWitnesses
import SFT.Physics.ForceLadderControls
import SFT.Physics.ForceLadderEvidence
#print axioms SFT.Physics.PrimeSectorLadder.properDivisors
#print axioms SFT.Physics.PrimeSectorLadder.primeNat
#print axioms SFT.Physics.PrimeSectorLadder.isPrimeCount
#print axioms SFT.Physics.PrimeSectorLadder.primeSectorLadder
#print axioms SFT.Physics.PrimeSectorLadder.mediatorCount
#print axioms SFT.Physics.PrimeSectorLadder.sectorCoupling
#print axioms SFT.Physics.PrimeSectorLadder.completeLadder
#print axioms SFT.Physics.PrimeSectorLadder.completeTests
#print axioms SFT.Physics.PrimeSectorLadder.nextPrimeExcluded
#print axioms SFT.Physics.PrimeSectorLadder.mediatorRecord
#print axioms SFT.Physics.PrimeSectorLadder.couplingRecord
#print axioms SFT.Physics.PrimeSectorLadder.exactMediators
#print axioms SFT.Physics.PrimeSectorLadder.exactCouplings
#print axioms SFT.Physics.PrimeSectorLadder.booleanPrimeRejected
#print axioms SFT.Physics.PrimeSectorLadder.booleanSectorRejected
#print axioms SFT.Physics.ForceLadderGrammar.carrierName
#print axioms SFT.Physics.ForceLadderGrammar.dependencyName
#print axioms SFT.Physics.ForceLadderGrammar.relationName
#print axioms SFT.Physics.ForceLadderGrammar.enumerationName
#print axioms SFT.Physics.ForceLadderGrammar.minimalityName
#print axioms SFT.Physics.ForceLadderGrammar.measurementName
#print axioms SFT.Physics.ForceLadderGrammar.recordName
#print axioms SFT.Physics.ForceLadderGrammar.extensionName
#print axioms SFT.Physics.ForceLadderGrammar.sourceFields
#print axioms SFT.Physics.ForceLadderGrammar.candidateId
#print axioms SFT.Physics.ForceLadderGrammar.exactForm
#print axioms SFT.Physics.ForceLadderGrammar.survivorId
#print axioms SFT.Physics.ForceLadderGrammar.survives
#print axioms SFT.Physics.ForceLadderGrammar.criteriaDecision
#print axioms SFT.Physics.ForceLadderGrammar.decisionReason
#print axioms SFT.Physics.ForceLadderGrammar.generationRule
#print axioms SFT.Physics.ForceLadderGrammar.grammarBoundary
#print axioms SFT.Physics.ForceLadderGrammar.candidates
#print axioms SFT.Physics.ForceLadderGrammar.survivor
#print axioms SFT.Physics.ForceLadderGrammar.generatedCardinality
#print axioms SFT.Physics.ForceLadderGrammar.candidatesComplete
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus0
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus0
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus1
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus1
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus2
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus2
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus3
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus3
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus4
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus4
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus5
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus5
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus6
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus6
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus7
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus7
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus8
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus8
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus9
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus9
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus10
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus10
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus11
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus11
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus12
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus12
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus13
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus13
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus14
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus14
#print axioms SFT.Physics.ForceLadderGrammar.decisionCensus15
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCensus15
#print axioms SFT.Physics.ForceLadderGrammar.sourceDecisionMatchesCriteria
#print axioms SFT.Physics.ForceLadderGrammar.uniqueCriteriaSurvivor
#print axioms SFT.Physics.ForceLadderGrammar.uniqueSurvivor
#print axioms SFT.Physics.ForceLadderGrammar.survivorAccepted
#print axioms SFT.Physics.ForceLadderGrammar.ExactCriteria
#print axioms SFT.Physics.ForceLadderGrammar.acceptanceIffExactCriteria
#print axioms SFT.Physics.ForceLadderGrammar.carrier_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.dependency_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.relation_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.enumeration_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.minimality_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.measurement_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.record_rejected_rejected
#print axioms SFT.Physics.ForceLadderGrammar.extension_rejected_rejected
#print axioms SFT.Physics.ForceLadderWitnesses.check0
#print axioms SFT.Physics.ForceLadderWitnesses.check1
#print axioms SFT.Physics.ForceLadderWitnesses.check2
#print axioms SFT.Physics.ForceLadderWitnesses.check3
#print axioms SFT.Physics.ForceLadderWitnesses.witnesses
#print axioms SFT.Physics.ForceLadderWitnesses.check0Passed
#print axioms SFT.Physics.ForceLadderWitnesses.check1Passed
#print axioms SFT.Physics.ForceLadderWitnesses.check2Passed
#print axioms SFT.Physics.ForceLadderWitnesses.check3Passed
#print axioms SFT.Physics.ForceLadderWitnesses.allWitnessesPass
#print axioms SFT.Physics.ForceLadderControls.exclusions
#print axioms SFT.Physics.ForceLadderControls.closureValue
#print axioms SFT.Physics.ForceLadderControls.falseCandidate
#print axioms SFT.Physics.ForceLadderControls.survivorIds
#print axioms SFT.Physics.ForceLadderControls.record
#print axioms SFT.Physics.ForceLadderControls.falsePremise
#print axioms SFT.Physics.ForceLadderControls.tamperedSource
#print axioms SFT.Physics.ForceLadderControls.tamperedArtifact
#print axioms SFT.Physics.ForceLadderControls.boundary
#print axioms SFT.Physics.ForceLadderControls.falsePremisePassed
#print axioms SFT.Physics.ForceLadderControls.boundaryPassed
#print axioms SFT.Physics.ForceLadderControls.controlRecords
#print axioms SFT.Physics.ForceLadderControls.resultData
#print axioms SFT.Physics.ForceLadderControls.runControls
#print axioms SFT.Physics.ForceLadderEvidence.candidateRecord
#print axioms SFT.Physics.ForceLadderEvidence.completenessRecord
#print axioms SFT.Physics.ForceLadderEvidence.registrationData
#print axioms SFT.Physics.ForceLadderEvidence.registration
#print axioms SFT.Physics.ForceLadderEvidence.generatedCandidateData
#print axioms SFT.Physics.ForceLadderEvidence.censusData
#print axioms SFT.Physics.ForceLadderEvidence.census
#print axioms SFT.Physics.ForceLadderEvidence.decisionData
#print axioms SFT.Physics.ForceLadderEvidence.decision
#print axioms SFT.Physics.ForceLadderEvidence.decideCandidate
#print axioms SFT.Physics.ForceLadderEvidence.closureData
#print axioms SFT.Physics.ForceLadderEvidence.closure
#print axioms SFT.Physics.ForceLadderEvidence.nativeDecisionPreservesSurvival
#print axioms SFT.Physics.ForceLadderEvidence.nativeDecisionPreservesReason
#print axioms SFT.Physics.ForceLadderEvidence.registrationHasNoAxioms
#print axioms SFT.Physics.ForceLadderEvidence.registrationHasNoFreeParameters
#print axioms SFT.Physics.ForceLadderEvidence.lookupDependsOnlyOnIdentifier

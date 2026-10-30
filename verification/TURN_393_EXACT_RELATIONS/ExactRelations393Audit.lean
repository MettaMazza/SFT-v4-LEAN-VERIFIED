import SFT.Mathematics.ExactRatioRelations
import SFT.Mathematics.HoldingComplement
import SFT.Mathematics.LocalSeparation
import SFT.Mathematics.LeastCommonReturn
import SFT.Mathematics.HeldShorterPart
import SFT.Mathematics.ExactRelationsGrammarBase
import SFT.Mathematics.ExactRelationsCensus0
import SFT.Mathematics.ExactRelationsCensus1
import SFT.Mathematics.ExactRelationsCensus2
import SFT.Mathematics.ExactRelationsCensus3
import SFT.Mathematics.ExactRelationsCensus4
import SFT.Mathematics.ExactRelationsCensus5
import SFT.Mathematics.ExactRelationsCensus6
import SFT.Mathematics.ExactRelationsCensus7
import SFT.Mathematics.ExactRelationsCensus8
import SFT.Mathematics.ExactRelationsCensus9
import SFT.Mathematics.ExactRelationsCensus10
import SFT.Mathematics.ExactRelationsCensus11
import SFT.Mathematics.ExactRelationsCensus12
import SFT.Mathematics.ExactRelationsCensus13
import SFT.Mathematics.ExactRelationsCensus14
import SFT.Mathematics.ExactRelationsCensus15
import SFT.Mathematics.ExactRelationsGrammar
import SFT.Mathematics.ExactRelationsWitnesses
import SFT.Mathematics.ExactRelationsControls
import SFT.Mathematics.ExactRelationsEvidence
#print axioms SFT.Mathematics.ExactRatioRelations.ratio
#print axioms SFT.Mathematics.ExactRatioRelations.reciprocal
#print axioms SFT.Mathematics.ExactRatioRelations.compose
#print axioms SFT.Mathematics.ExactRatioRelations.ratioValue
#print axioms SFT.Mathematics.ExactRatioRelations.reciprocalValue
#print axioms SFT.Mathematics.ExactRatioRelations.composeValue
#print axioms SFT.Mathematics.ExactRatioRelations.reciprocalReturnsOne
#print axioms SFT.Mathematics.ExactRatioRelations.telescopeRaw
#print axioms SFT.Mathematics.ExactRatioRelations.equalPartsReconstruct
#print axioms SFT.Mathematics.ExactRatioRelations.cancelPositive
#print axioms SFT.Mathematics.ExactRatioRelations.interchange
#print axioms SFT.Mathematics.ExactRatioRelations.composeRepresents
#print axioms SFT.Mathematics.ExactRatioRelations.telescopeNormalized
#print axioms SFT.Mathematics.HoldingComplement.complement
#print axioms SFT.Mathematics.HoldingComplement.Holds
#print axioms SFT.Mathematics.HoldingComplement.complementValue
#print axioms SFT.Mathematics.HoldingComplement.complementHolds
#print axioms SFT.Mathematics.HoldingComplement.holdingForcesValue
#print axioms SFT.Mathematics.HoldingComplement.holdingUniqueValue
#print axioms SFT.Mathematics.HoldingComplement.binaryComplement
#print axioms SFT.Mathematics.LocalSeparation.HeldPair
#print axioms SFT.Mathematics.LocalSeparation.gap
#print axioms SFT.Mathematics.LocalSeparation.gapValue
#print axioms SFT.Mathematics.LocalSeparation.doubleDifference
#print axioms SFT.Mathematics.LocalSeparation.uncastTransport
#print axioms SFT.Mathematics.LocalSeparation.localTransportExact
#print axioms SFT.Mathematics.LocalSeparation.transportValue
#print axioms SFT.Mathematics.LocalSeparation.sharedRemoval
#print axioms SFT.Mathematics.LocalSeparation.upperBranchCast
#print axioms SFT.Mathematics.LocalSeparation.lowerBranchGap
#print axioms SFT.Mathematics.LocalSeparation.upperBranchGap
#print axioms SFT.Mathematics.LeastCommonReturn.leftFactor
#print axioms SFT.Mathematics.LeastCommonReturn.rightFactor
#print axioms SFT.Mathematics.LeastCommonReturn.returnsBoth
#print axioms SFT.Mathematics.LeastCommonReturn.returnPositive
#print axioms SFT.Mathematics.LeastCommonReturn.gcdTimesReturn
#print axioms SFT.Mathematics.LeastCommonReturn.dividesEveryReturn
#print axioms SFT.Mathematics.LeastCommonReturn.leastPositiveReturn
#print axioms SFT.Mathematics.LeastCommonReturn.allPositive
#print axioms SFT.Mathematics.LeastCommonReturn.allDivide
#print axioms SFT.Mathematics.LeastCommonReturn.joint
#print axioms SFT.Mathematics.LeastCommonReturn.dividesTrans
#print axioms SFT.Mathematics.LeastCommonReturn.jointPositive
#print axioms SFT.Mathematics.LeastCommonReturn.jointCharacterization
#print axioms SFT.Mathematics.LeastCommonReturn.jointReturnsAll
#print axioms SFT.Mathematics.LeastCommonReturn.jointIsLeast
#print axioms SFT.Mathematics.LeastCommonReturn.originalJointWitness
#print axioms SFT.Mathematics.HeldShorterPart.Side
#print axioms SFT.Mathematics.HeldShorterPart.HeldSeparation
#print axioms SFT.Mathematics.HeldShorterPart.noLonger
#print axioms SFT.Mathematics.HeldShorterPart.shorter
#print axioms SFT.Mathematics.HeldShorterPart.heldSide
#print axioms SFT.Mathematics.HeldShorterPart.selectedFromGenerated
#print axioms SFT.Mathematics.HeldShorterPart.positiveSeparation
#print axioms SFT.Mathematics.HeldShorterPart.shorterThanFirst
#print axioms SFT.Mathematics.HeldShorterPart.shorterThanSecond
#print axioms SFT.Mathematics.HeldShorterPart.sideRetained
#print axioms SFT.Mathematics.HeldShorterPart.sideDoesNotChangeMagnitude
#print axioms SFT.Mathematics.HeldShorterPart.tiePreservesExactValue
#print axioms SFT.Mathematics.ExactRelationsGrammar.Provenance
#print axioms SFT.Mathematics.ExactRelationsGrammar.provenanceName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Relation
#print axioms SFT.Mathematics.ExactRelationsGrammar.relationName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Orientation
#print axioms SFT.Mathematics.ExactRelationsGrammar.orientationName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Threshold
#print axioms SFT.Mathematics.ExactRelationsGrammar.thresholdName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Transport
#print axioms SFT.Mathematics.ExactRelationsGrammar.transportName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Composition
#print axioms SFT.Mathematics.ExactRelationsGrammar.compositionName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Generality
#print axioms SFT.Mathematics.ExactRelationsGrammar.generalityName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Addition
#print axioms SFT.Mathematics.ExactRelationsGrammar.additionName
#print axioms SFT.Mathematics.ExactRelationsGrammar.Candidate
#print axioms SFT.Mathematics.ExactRelationsGrammar.sourceFields
#print axioms SFT.Mathematics.ExactRelationsGrammar.candidateId
#print axioms SFT.Mathematics.ExactRelationsGrammar.exactForm
#print axioms SFT.Mathematics.ExactRelationsGrammar.survivorId
#print axioms SFT.Mathematics.ExactRelationsGrammar.survives
#print axioms SFT.Mathematics.ExactRelationsGrammar.criteriaDecision
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionReason
#print axioms SFT.Mathematics.ExactRelationsGrammar.generationRule
#print axioms SFT.Mathematics.ExactRelationsGrammar.grammarBoundary
#print axioms SFT.Mathematics.ExactRelationsGrammar.candidates
#print axioms SFT.Mathematics.ExactRelationsGrammar.survivor
#print axioms SFT.Mathematics.ExactRelationsGrammar.generatedCardinality
#print axioms SFT.Mathematics.ExactRelationsGrammar.candidatesComplete
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus0
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus0
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus1
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus1
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus2
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus2
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus3
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus3
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus4
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus4
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus5
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus5
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus6
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus6
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus7
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus7
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus8
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus8
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus9
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus9
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus10
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus10
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus11
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus11
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus12
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus12
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus13
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus13
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus14
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus14
#print axioms SFT.Mathematics.ExactRelationsGrammar.decisionCensus15
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCensus15
#print axioms SFT.Mathematics.ExactRelationsGrammar.sourceDecisionMatchesCriteria
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueCriteriaSurvivor
#print axioms SFT.Mathematics.ExactRelationsGrammar.uniqueSurvivor
#print axioms SFT.Mathematics.ExactRelationsGrammar.survivorAccepted
#print axioms SFT.Mathematics.ExactRelationsGrammar.ExactCriteria
#print axioms SFT.Mathematics.ExactRelationsGrammar.acceptanceIffExactCriteria
#print axioms SFT.Mathematics.ExactRelationsGrammar.provenance_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.relation_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.orientation_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.threshold_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.transport_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.composition_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.generality_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsGrammar.addition_rejected_rejected
#print axioms SFT.Mathematics.ExactRelationsWitnesses.Witness
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check0
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check0Passed
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check1
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check1Passed
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check2
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check2Passed
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check3
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check3Passed
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check4
#print axioms SFT.Mathematics.ExactRelationsWitnesses.check4Passed
#print axioms SFT.Mathematics.ExactRelationsWitnesses.witnesses
#print axioms SFT.Mathematics.ExactRelationsWitnesses.allWitnessesPass
#print axioms SFT.Mathematics.ExactRelationsControls.laws
#print axioms SFT.Mathematics.ExactRelationsControls.exclusions
#print axioms SFT.Mathematics.ExactRelationsControls.closureValue
#print axioms SFT.Mathematics.ExactRelationsControls.falseCandidate
#print axioms SFT.Mathematics.ExactRelationsControls.survivorIds
#print axioms SFT.Mathematics.ExactRelationsControls.distinctIdentifiers
#print axioms SFT.Mathematics.ExactRelationsControls.falsePremise
#print axioms SFT.Mathematics.ExactRelationsControls.tamperedSource
#print axioms SFT.Mathematics.ExactRelationsControls.tamperedArtifact
#print axioms SFT.Mathematics.ExactRelationsControls.boundary
#print axioms SFT.Mathematics.ExactRelationsControls.falsePremisePassed
#print axioms SFT.Mathematics.ExactRelationsControls.boundaryPassed
#print axioms SFT.Mathematics.ExactRelationsControls.controlRecords
#print axioms SFT.Mathematics.ExactRelationsControls.runControls
#print axioms SFT.Mathematics.ExactRelationsEvidence.candidateRecord
#print axioms SFT.Mathematics.ExactRelationsEvidence.completenessRecord
#print axioms SFT.Mathematics.ExactRelationsEvidence.registrationData
#print axioms SFT.Mathematics.ExactRelationsEvidence.registration
#print axioms SFT.Mathematics.ExactRelationsEvidence.generatedCandidateData
#print axioms SFT.Mathematics.ExactRelationsEvidence.censusData
#print axioms SFT.Mathematics.ExactRelationsEvidence.census
#print axioms SFT.Mathematics.ExactRelationsEvidence.decisionData
#print axioms SFT.Mathematics.ExactRelationsEvidence.decision
#print axioms SFT.Mathematics.ExactRelationsEvidence.decideCandidate
#print axioms SFT.Mathematics.ExactRelationsEvidence.closureData
#print axioms SFT.Mathematics.ExactRelationsEvidence.closure
#print axioms SFT.Mathematics.ExactRelationsEvidence.nativeDecisionPreservesSurvival
#print axioms SFT.Mathematics.ExactRelationsEvidence.nativeDecisionPreservesReason
#print axioms SFT.Mathematics.ExactRelationsEvidence.registrationHasNoAxioms
#print axioms SFT.Mathematics.ExactRelationsEvidence.registrationHasNoFreeParameters
#print axioms SFT.Mathematics.ExactRelationsEvidence.lookupDependsOnlyOnIdentifier

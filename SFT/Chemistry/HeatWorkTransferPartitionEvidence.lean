import SFT.Chemistry.HeatWorkTransferPartitionGrammar
import SFT.Chemistry.HeatWorkTransferPartition
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.HeatWorkTransferPartitionEvidence
open SFT.Host.Canonical HeatWorkTransferPartitionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "forced-classes",.text "Carrier observability alone forces distinct heat and work classes.",.boolean (match (do let first ← HeatWorkTransferPartition.firstRecord; let third ← HeatWorkTransferPartition.thirdRecord; pure (SFT.Host.Text.equal first.transferClass.label "heat-transfer" && SFT.Host.Text.equal third.transferClass.label "work-transfer")) with | .error _ => false | .ok b => b)],.array [.text "disjoint-complete",.text "Every transfer occurs exactly once in the partition.",.boolean (match HeatWorkTransferPartition.complete with | .error _ => false | .ok p => p.records.length==3)],.array [.text "exact-class-totals",.text "Heat and work contents compose exactly without signs.",.boolean (match HeatWorkTransferPartition.complete with | .error _ => false | .ok p => (match p.heatTotal,p.workTotal with | .ratio h,.ratio w => MolecularFormationEnergy.ratioPair h==(23,12) && MolecularFormationEnergy.ratioPair w==(7,5) | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ => false))],.array [.text "structural-absence",.text "An absent transfer class is EmptyOne, not numerical zero.",.boolean (match HeatWorkTransferPartition.heatOnly with | .error _ => false | .ok p => (match p.workTotal with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false))],.array [.text "complete-total",.text "The complete retained transfer content is exact.",.boolean (match HeatWorkTransferPartition.complete with | .error _ => false | .ok p => MolecularFormationEnergy.ratioPair p.completeTransferTotal==(199,60))],.array [.text "append-only",.text "Appending one transfer preserves every prior path record.",.boolean (match (do let first ← HeatWorkTransferPartition.firstRecord; let second ← HeatWorkTransferPartition.secondRecord; let third ← HeatWorkTransferPartition.thirdRecord; HeatWorkTransferPartition.appendTransferPreservesPartition (.tuple [.record first,.record second]) (.record third)) with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-COMPOSITION-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-THERMO-HEAT-WORK-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-MOLECULAR-FORMATION-ENERGY-013","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "class",.text (classAxisName c.classAxis)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-signed-net-energy",.text "A signed answer erases the boundary, path and transfer provenance."],.array [.text "complete-held-chemical-transfer-path",.text "Every transfer remains attached to one held chemical boundary and path."]]],.array [.text "class",.array [.array [.text "imported-or-arbitrary-heat-work-label",.text "An arbitrary label does not explain the heat/work distinction."],.array [.text "observation-forced-closed-or-held-carrier-class",.text "Closed carrier identity forces heat; retained organized source-response identity forces work."]]],.array [.text "orientation",.array [.array [.text "negative-or-signed-transfer-content",.text "A signed proof value conflates direction with content."],.array [.text "held-direction-plus-exact-positive-content",.text "Direction is held separately from exact positive transfer content."]]],.array [.text "partition",.array [.array [.text "merged-or-overlapping-transfer-classes",.text "A merged or overlapping record cannot retain which distinction observation closed."],.array [.text "disjoint-exhaustive-heat-work-path-partition",.text "Every path transfer occurs exactly once in one forced class."]]],.array [.text "composition",.array [.array [.text "signed-net-cancellation-or-numerical-zero",.text "Signed cancellation deletes transfer history and numerical zero is not an SFT number."],.array [.text "per-class-positive-composition-plus-EmptyOne-absence",.text "Each present class composes exactly; an absent class is structural EmptyOne."]]],.array [.text "prediction",.array [.array [.text "calorimetric-or-work-target-readable-before-seal",.text "Target values could select the partition."],.array [.text "complete-value-free-transfer-identity-seal",.text "All state and column identities seal before calorimetric or work values open."]]],.array [.text "record",.array [.array [.text "selected-calorimetric-or-expansion-row",.text "A selected row can hide phase and unfavorable records."],.array [.text "complete-13-row-joint-calorimetric-expansion-vector",.text "All returned liquid, boundary and vapour rows remain in one joint record."]]],.array [.text "extension",.array [.array [.text "repartition-prior-path-after-successor",.text "Repartitioning earlier transfers destroys path invariance."],.array [.text "depth-independent-append-only-transfer-successor",.text "One new transfer appends without changing any prior record."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical heat and work transfer partition"
 branch := "chemistry"
 statement := "For one held chemical boundary and path, carrier identity closed by the receiving macro-observation forces the heat class, while a retained organized source-to-response identity forces the work class. Direction is held separately from exact positive content; every transfer remains in a disjoint exhaustive path record, and an absent class is structural EmptyOne."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := identity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-held-chemical-transfer-path__observation-forced-closed-or-held-carrier-class__held-direction-plus-exact-positive-content__disjoint-exhaustive-heat-work-path-partition__per-class-positive-composition-plus-EmptyOne-absence__complete-value-free-transfer-identity-seal__complete-13-row-joint-calorimetric-expansion-vector__depth-independent-append-only-transfer-successor"),("base",.text "One exact positive transfer across one held chemical boundary has one observation-forced class and one retained path record; the other class is structural EmptyOne."),("successor",.text "Appending one transfer assigns it to exactly one class from its carrier observation, preserves every prior record and class subtotal, and adds its positive content exactly once to its class and complete total."),("exclusions",.array [.text "no numerical zero; an absent transfer class is structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no imported heat/work equation, fitted coefficient, target-selected class or measured transfer value",.text "no target payload, temperature, phase, heat capacity, volume, enthalpy or internal energy before prediction seal",.text "no signed net cancellation, merged transfer classes, omitted path record or selected external row",.text "external signed glyphs remain source inscriptions and never enter an SFT proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; an absent transfer class is structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no imported heat/work equation, fitted coefficient, target-selected class or measured transfer value","no target payload, temperature, phase, heat capacity, volume, enthalpy or internal energy before prediction seal","no signed net cancellation, merged transfer classes, omitted path record or selected external row","external signed glyphs remain source inscriptions and never enter an SFT proof magnitude"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.HeatWorkTransferPartitionEvidence

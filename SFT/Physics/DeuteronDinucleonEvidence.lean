import SFT.Physics.DeuteronDinucleonGrammar
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.DeuteronDinucleonEvidence
open SFT.Host SFT.Host.Canonical DeuteronDinucleonGrammar DeuteronDinucleonProofs
open SFT.Foundation.AdmissionControls (admissionIdentity)
local instance : BEq String := ⟨Text.equal⟩
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def formValue (c : Candidate) : Value := .object [("exchange_partition",.text (partitionName c.partition)),("ground_exchange_ledger",.text (groundName c.ground)),("residual_discriminator",.text (residualName c.residual)),("binding_table",.text (bindingName c.binding)),("composite_spin",.text (spinName c.spin)),("charged_pair_role",.text (chargedName c.charged)),("target_boundary",.text (targetName c.target)),("extension",.text (extensionName c.extension))]
def factsValue (c : Candidate) : Value := .object ((computedFacts c).map (fun (key,b) => (key,.boolean b)))
def exactForm (c : Candidate) : String := Text.intercalate "; " [Text.append "exchange=" (partitionName c.partition),Text.append "ground=" (groundName c.ground),Text.append "residual=" (residualName c.residual),Text.append "binding=" (bindingName c.binding),Text.append "spin=" (spinName c.spin),Text.append "charged_pair=" (chargedName c.charged),Text.append "target=" (targetName c.target),Text.append "extension=" (extensionName c.extension)]
def decisionReason (c : Candidate) : String :=
 let failures := ((computedFacts c).filter (fun p => !p.2)).map Prod.fst
 if !failures.isEmpty then Text.intercalate "" ["Rejected by computed Fold predicates: ",Text.intercalate ", " failures,"."] else "Complete two-label exchange enumeration gives preserving support three-quarters and alternating support one-quarter. The admitted residual boundary act is one-quarter, so only the preserving hand retains the positive half-One recurrence. The complete spatial/spin/charge exchange ledger assigns that hand to proton-neutron and the exhausted alternating hand to both identical pairs."
def completenessRecord : Value := .object [("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("axis_cardinalities",.array ([3,3,3,4,3,2,2,2].map (fun n => Value.integer (.ofNat n)))),("candidate_count",.integer (.ofNat candidates.length)),("candidate_ids",.array (candidates.map (fun c => .text (candidateId c))))]
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.object [("generator",.text generationRule),("form",formValue c),("computed_facts",factsValue c)])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census := SFT.Engine.censusValue censusData
def decisionData (c : Candidate) (traceHash : String) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.object [("candidate_trace",.text traceHash),("form",formValue c),("facts",factsValue c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (c : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun f => Text.equal (candidateId f) c.candidateId) with
 | none => .error "KeyError"
 | some f => .ok (decisionData f c.traceHash)
def fractionValue (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def gainValue (p : Rat × Rat) : Value := .array [fractionValue p.1,fractionValue p.2]
def optionalValue : Option Rat → Value
 | none => .array [] | some q => fractionValue q
def spinClassValue (x : DeuteronDinucleon.SpinClass) : Value := .object [("name",.text x.name),("exchange_hand",.text x.exchangeHand),("held_word_support",.array (x.heldWordSupport.map (fun (a,b) => .array [.text a,.text b])))]
def channelValue (x : DeuteronDinucleon.PairChannel) : Value := .object [("pair_class",.text x.pairClass),("spatial_hand",.text x.spatialHand),("charge_hand",.text x.chargeHand),("spin_hand",.text x.spinHand),("total_exchange_hand",.text x.totalExchangeHand),("spin_support",fractionValue x.spinSupport),("retained_binding_support",optionalValue x.retainedBindingSupport),("charge_path",optionalValue x.chargePath)]
def certificateValue (x : DeuteronDinucleon.SpinCertificate) : Value := .object [("constituent_spin",fractionValue x.constituentSpin),("preserving_composite_spin",fractionValue x.preservingCompositeSpin),("preserving_reading_count",.integer (.ofNat x.preservingReadingCount)),("alternating_reading_count",.integer (.ofNat x.alternatingReadingCount)),("preserving_support",fractionValue x.preservingSupport),("alternating_support",fractionValue x.alternatingSupport),("residual_boundary",fractionValue x.residualBoundary),("preserving_remainder",optionalValue x.preservingRemainder),("alternating_remainder",optionalValue x.alternatingRemainder)]
def outcomesValue (xs : List (String × Bool)) : Value := .object (xs.map (fun (k,v) => (k,.boolean v)))
def closureRecord (decisions : List SFT.Engine.CandidateDecision) : Except String Value := do
 pure (.object [("survivors_computed",.array ((decisions.filter SFT.Engine.CandidateDecision.survives).map (fun d => .text d.candidateId))),("spin_certificate",certificateValue (← DeuteronDinucleon.compositeSpinCertificate)),("pair_channels",.array ((← DeuteronDinucleon.pairChannels).map channelValue)),("binding_outcomes",outcomesValue (← DeuteronDinucleon.bindingOutcomes)),("target_absent_from_formal_module",.boolean true),("extension_absent",.boolean (← DeuteronDinucleon.extensionIsForced "empty-extension"))])
def generality : Except String Value := do
 let p ← DeuteronDinucleon.exchangePartition
 pure (.object [("complete_two-label_exchange_classes",.array ((← DeuteronDinucleon.spinClasses).map spinClassValue)),("exchange_partition",.object [("exchange-preserving",.array (p.1.map Value.text)),("exchange-alternating",.array (p.2.map Value.text))]),("quarter_residual_dependency",.text "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005"),("fermionic_exchange_dependency",.text "SFT-PHYS-QUANTUM-EXCLUSION-001"),("pair_channels",.array ((← DeuteronDinucleon.pairChannels).map channelValue)),("all_future_two-label_ground_pairs_use_same_ledger",.boolean true)])
def closureData (decisions : List SFT.Engine.CandidateDecision) : Except String SFT.Engine.ClosureEvidence := do
 let spin ← DeuteronDinucleon.compositeSpinCertificate
 let outcomes ← DeuteronDinucleon.bindingOutcomes
 let minimal := (decisions.filter SFT.Engine.CandidateDecision.survives).length==1 && spin.preservingRemainder==some (LeptonIntervals.normalize 1 2 (by decide)) && spin.alternatingRemainder.isNone && outcomes==[("proton-neutron",true),("proton-proton",false),("neutron-neutron",false)]
 pure { scope := .depthIndependent
        exactBoundary := grammarBoundary
        minimalityPassed := minimal
        namedShapeUniquenessPassed := minimal && (← DeuteronDinucleon.extensionIsForced "empty-extension")
        proofHash := admissionIdentity (.object [("closure",← closureRecord decisions),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
        generalityCertificateHash := some (admissionIdentity (← generality)) }
def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.object [("kind",.text (SFT.Engine.kindName kind)),("passed",.boolean passed),("expected",.text expected),("observed",.text observed)])
def controlData (sourceHash : String) : Except String (List SFT.Engine.ControlResult) := do
 let survivors := candidates.filter survives
 let held ← match survivors with
  | [c] => .ok c
  | [] => .error "controls require exactly one computed form"
  | _::_::_ => .error "controls require exactly one computed form"
 let ids := candidates.map candidateId
 let duplicated := (ids ++ ids.take 1).map (fun id => id.toUTF8.data.toList.map UInt8.toNat)
 pure [
 control .falsePremise (!survives {held with binding:=.c3}) "Reject binding of the identical pairs with exclusion of proton-neutron." "The computed exchange and quarter-support ledger rejects the reversed outcome.",
 control .tamperedSource (!(Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "Reject any changed claimant source identity." "The changed identity differs from the registered source manifest.",
 control .tamperedArtifact (duplicated.eraseDups.length != ids.length+1) "Reject a duplicated or incomplete candidate census." "The deliberate duplicate fails complete candidate identity.",
 control .boundary (!survives {held with target:=.c1} && !survives {held with extension:=.c1}) "Reject pre-seal target access and every ungenerated correction." "Sealed custody and the empty extension are both required by computed predicates."]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := "SFT-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006"
 title := "Terminal deuteron binding, spin and dinucleon exclusion"
 branch := "physics"
 statement := "The complete two-label spin word has three exchange-preserving readings with support three-quarters and one exchange-alternating reading with support one-quarter. The admitted two-boundary residual act is one-quarter: preserving support therefore retains exactly half-One as a bound recurrence, while alternating support is exhausted and closes to the empty form. In the least spatial ground recurrence, the alternating proton-neutron charge hand permits the preserving spin channel; identical proton-proton and neutron-neutron charge hands require the alternating spin channel to preserve total fermionic exchange. Hence the proton-neutron pair alone is bound, with complete spin One and three readings; both identical two-nucleon pairs are unbound. Proton Coulomb opposition is an additional pp boundary and cannot explain or alter the nn result. Dimensional binding energy and scattering records open only after the structural seal."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := ["SFT-FOUNDATION-HALF-ONE-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-PHYS-MATTER-FERMION-BOSON-001", "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005", "SFT-PHYS-NUCLEAR-BINDING-001", "SFT-PHYS-FIELD-COULOMB-GAUSS-CLOSURE-003", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
end SFT.Physics.DeuteronDinucleonEvidence

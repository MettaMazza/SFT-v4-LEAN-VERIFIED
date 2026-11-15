from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');s=(r/'SFT/Physics/StrongFieldValidation.lean').read_text();s=s[:s.index('def lookup')];s=s.replace('StrongField','YangMillsSpectrum').replace('open SFT.Host SFT.Host.Canonical YangMillsSpectrumPrediction YangMillsSpectrumExperiment LeptonIntervals','open SFT.Host SFT.Host.Canonical YangMillsSpectrumExperiment LeptonIntervals').replace('SFT-PHYS-STRONG-FIELD-NONLINEAR-FIXED-POINT-TERMINAL-014','SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027').replace('exact-strong-field-nonlinear-fixed-point-comparator/1','exact-yang-mills-singlet-gap-spectrum-comparator/1').replace('set_option maxRecDepth 20000','set_option maxRecDepth 100000')
s+='''def labelMatches (v : CapabilityValues.Value) : Bool := match v with
 | .label held => Text.equal held.family "physical-observation" && Text.equal held.label expectedLabel
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def replaceField (v : Value) (key : String) (value : Value) : Value := match v with
 | .object fs => .object (fs.map (fun (k,x) => (k,if Text.equal k key then value else x)))
 | .null | .boolean _ | .integer _ | .text _ | .array _ => v
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "wrong Yang-Mills spectrum seal"
 let document := programDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label held)]
 let env := envelope derivationSeal
 let originalTargets ← targets files record
 let hashes := Value.object (YangMillsSpectrumRecords.sourceHashes.map (fun (k,v) => (k,.text v)))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") originalTargets
  (admissionIdentity (.array [.text registrationHash,hashes])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "Yang-Mills prediction package audit failed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 if !labelMatches execution.output then throw "Yang-Mills spectrum prediction changed"
 let target ← match released.values with
  | (_,target)::_ => pure target
  | [] => throw "KeyError"
 let analysis ← YangMillsSpectrumMeasurement.exactSpectrumAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let formal := YangMillsSpectrumWitnesses.witnesses.all YangMillsSpectrumWitnesses.Witness.passed
 let allRows := equals "row_count" (.integer 3) && equals "quantum_number_order" (.array [.text "0++",.text "2++",.text "0-+"]) && yes "scope_rows_retained"
 let controls := yes "all_central_masses_positive" && yes "all_lower_edges_positive" && yes "intervals_strictly_ordered_and_disjoint" && yes "ground_state_scalar" && yes "first_excitation_tensor"
 let rows ← RunningConvergenceMeasurement.array (← field target "precise_lattice_rows")
 let tamperedRows ← match rows with
  | [] => .error "IndexError"
  | first::rest => .ok (replaceField first "mass_mev" (.text "2400")::rest)
 let tampered := replaceField target "precise_lattice_rows" (.array tamperedRows)
 let tamperedAnalysis ← YangMillsSpectrumMeasurement.exactSpectrumAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "intervals_strictly_ordered_and_disjoint")
 let passed := formal && allRows && controls && tamperedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("seal",.text derivationSeal),("prediction_seal",.text predictionSeal.sealHash),("source_hashes",hashes),("target_identity",.text targetIdentity),("analysis",analysis),("formal",.boolean formal),("all_rows",.boolean allRows),("controls",.boolean controls),("tampered_rejected",.boolean tamperedRejected),("trace",.text execution.traceHash)]
'''
tree=ast.parse(Path('work/yangmillsvalidation1005_original_validation.py').read_text());m=next(n for n in ast.walk(tree) if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='measurements' for t in n.targets));measurements=ast.literal_eval(m.value);s+=' let measurements := '+json.dumps(list(measurements),ensure_ascii=False)+'\n';s+=''' pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array [.text YangMillsSpectrumRecords.sourceId]),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.YangMillsSpectrumValidation
''';p=r/'SFT/Physics/YangMillsSpectrumValidation.lean';p.write_text(s);Path('work/constants-recovery/SFT/Physics/YangMillsSpectrumValidation.lean').write_text(s)

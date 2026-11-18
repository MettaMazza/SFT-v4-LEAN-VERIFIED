"""Capability-closed validation for separate ANAL-001–005 claims."""
import hashlib,json,platform
from functools import lru_cache
from pathlib import Path
from bs4 import BeautifulSoup
from pypdf import PdfReader
from sft.chemistry.generated_law import prediction_program_document
from sft.chemistry.generated_observational_law import observational_experiment_registration_record
from sft.chemistry.anal_performance_batch_v1 import ACCURACY_SPEC,ANALYSIS_PATH,AUTHORITIES,DETECTION_SPEC,PRECISION_SPEC,SELECTIVITY_SPEC,SENSITIVITY_SPEC,SPECS
from sft.claim_evidence import CapabilityClosedFoldInterpreter,CrossPlatformCustodyExchange,HostilePackageAuditor,TargetVault,fold_program_from_mapping,snapshot_protected_tree,target_identity_from_release
from sft.engine import EmpiricalValidation,seal_isolation_certificate,seal_target_custody_certificate,unsealed_isolation_certificate,unsealed_target_custody_certificate
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary,PredictionEnvelope
from sft.engine.exact import HeldLabel
from sft.engine.source import hash_file

def digest(data):return "sha256:"+hashlib.sha256(data).hexdigest()
def clean(text):return "\n".join(x.strip() for x in text.replace("\u00ad","").splitlines() if x.strip())
@lru_cache(maxsize=None)
def surface(path,kind):
 texts=(clean(BeautifulSoup(path.read_bytes(),"html.parser").get_text("\n")),) if kind=="html" else tuple(clean(x.extract_text() or "") for x in PdfReader(path).pages)
 return tuple({"page":i+1,"character_count":len(t),"text_sha256":digest(t.encode())} for i,t in enumerate(texts))

def exact_analysis(root,claim_id,omit_last=False):
 for path,expected in AUTHORITIES:
  if hash_file(root/path)!=expected:raise ValueError(f"ANAL-001–005 authority changed: {path}")
 analysis=json.loads((root/ANALYSIS_PATH).read_text());vector=dict(analysis);recorded=vector.pop("complete_result_vector_sha256")
 if recorded!=digest(json.dumps(vector,sort_keys=True,separators=(",",":")).encode()):raise ValueError("ANAL-001–005 result vector changed")
 pages=htmls=characters=0
 for source in analysis["complete_source_reconstruction"].values():
  reconstructed=surface(root/source["snapshot_path"],source["media_kind"])
  if reconstructed!=tuple(source["complete_surface_vector"]):raise ValueError("complete ANAL-001–005 source reconstruction changed")
  characters+=sum(x["character_count"] for x in reconstructed);pages+=len(reconstructed) if source["media_kind"]=="pdf" else 0;htmls+=source["media_kind"]=="html"
 if (pages,htmls,characters)!=(83,1,180366) or (pages,htmls,characters)!=(analysis["complete_pdf_page_count"],analysis["complete_html_document_count"],analysis["complete_extracted_character_count"]):raise ValueError("complete ANAL-001–005 source surface changed")
 if claim_id==ACCURACY_SPEC.claim_id:
  row=analysis["anal_001"];values=row["complete_certified_and_reference_value_vector"]
  checks={"SFT-CHEM-ANAL-001-REFERENCE":row["certified_row_count"]==6 and row["reference_noncertified_row_count"]==1,"SFT-CHEM-ANAL-001-VALUE-PAIRS":len(values)==7 and values[0]["mass_concentration_ng_mL"]=="1033 ± 97" and values[-1]["mass_concentration_ng_mL"]=="1008 ± 103","SFT-CHEM-ANAL-001-METHODS":len(row["method_vector"])==3,"SFT-CHEM-ANAL-001-UNCERTAINTY":row["coverage_factor"]=="2.1" and row["coverage_probability"]=="approximately 95%","SFT-CHEM-ANAL-001-BOUNDARY":row["use_temperature_C"]=="20 to 25" and row["serum_density_g_mL"]=="1.025","SFT-CHEM-ANAL-001-STATUS":row["certificate_issue_date"]=="21 March 2011" and row["certificate_expiry"]=="01 October 2015","SFT-CHEM-ANAL-001-ADVERSE-LIMITS":values[-1]["status"]=="reference_noncertified" and row["complete_accuracy_use_and_storage_limits_retained"],"SFT-CHEM-ANAL-001-COMPLETE-SOURCE":analysis["complete_source_count"]==6}
  summary={"certified_value_rows":6,"reference_noncertified_rows":1,"mass_concentration_vector":[x["mass_concentration_ng_mL"] for x in values],"coverage_factor":"2.1","certificate_status":"expired archived measured record"}
 elif claim_id==PRECISION_SPEC.claim_id:
  row=analysis["anal_002"]
  checks={"SFT-CHEM-ANAL-002-IDENTITY":analysis["anal_001"]["certified_row_count"]+analysis["anal_001"]["reference_noncertified_row_count"]==7,"SFT-CHEM-ANAL-002-REPLICATES":row["ntrm_batch_standard_minimum_analyses"]=="6" and row["remaining_samples_analysis"]=="duplicate","SFT-CHEM-ANAL-002-WITHIN-SET":row["gc_ms_within_set_cv_percent"]=="0.5 to 4.3" and row["lc_ms_within_set_cv_percent"]=="0.2 to 1.2","SFT-CHEM-ANAL-002-BETWEEN-SET":row["between_set_cv_percent"]=="0.1 to 1.1","SFT-CHEM-ANAL-002-METHOD-AGREEMENT":row["between_method_agreement_percent"]=="0.8 to 8.8","SFT-CHEM-ANAL-002-DRIFT":row["duplicate_and_interval_agreement_percent_relative"]=="0.2" and row["stability_reanalysis_interval_days"]=="30","SFT-CHEM-ANAL-002-ADVERSE-LIMITS":row["all_noise_drift_inhomogeneity_instability_and_discard_conditions_retained"],"SFT-CHEM-ANAL-002-COMPLETE-SOURCE":analysis["complete_source_count"]==6}
  summary={k:row[k] for k in ("gc_ms_within_set_cv_percent","lc_ms_within_set_cv_percent","between_set_cv_percent","between_method_agreement_percent")}
 elif claim_id==SENSITIVITY_SPEC.claim_id:
  row=analysis["anal_003"]
  checks={"SFT-CHEM-ANAL-003-IDENTITY":"NTRM concentration" in row["calibration_boundary"],"SFT-CHEM-ANAL-003-INPUT-SUPPORT":row["minimum_calibration_mixtures"]=="3","SFT-CHEM-ANAL-003-RESPONSE-SUPPORT":row["minimum_nonlinear_calibration_standards"]=="4","SFT-CHEM-ANAL-003-SENSITIVITY":row["required_relative_concentration_difference_sensitivity_percent"]=="0.2" and row["duplicate_agreement_acceptance_percent_relative"]=="0.2","SFT-CHEM-ANAL-003-NONLINEARITY":row["straight_quadratic_prediction_difference_trigger_percent"]=="0.5","SFT-CHEM-ANAL-003-DOMAIN":"extrapolation not recommended" in row["calibration_boundary"],"SFT-CHEM-ANAL-003-DRIFT-NOISE":len(row["drift_vector"])==4 and row["all_nonlinearity_extrapolation_drift_noise_and_case_by_case_limits_retained"],"SFT-CHEM-ANAL-003-COMPLETE-SOURCE":analysis["complete_source_count"]==6}
  summary={"minimum_calibration_mixtures":"3","minimum_nonlinear_standards":"4","relative_sensitivity_percent":"0.2","nonlinearity_trigger_percent":"0.5"}
 elif claim_id==DETECTION_SPEC.claim_id:
  row=analysis["anal_004"]
  checks={"SFT-CHEM-ANAL-004-IDENTITY":len(row["boundary_classes"])==3,"SFT-CHEM-ANAL-004-BLANK-LOW-LEVEL":row["worked_measurement"]=={"counting_time_minutes":"10","detector_efficiency_percent":"10","background_counts_per_minute":"20"},"SFT-CHEM-ANAL-004-BOUNDARIES":row["boundary_classes"]==["critical level LC","detection limit LD","determination limit LQ"],"SFT-CHEM-ANAL-004-ERRORS":row["assumptions"]["first_kind_error_percent"]=="5" and row["assumptions"]["second_kind_error_percent"]=="5","SFT-CHEM-ANAL-004-DETECTION-VALUES":row["conventional_zero_background_example"]["LD_poisson_normal_counts"]=="2.71" and row["conventional_zero_background_example"]["exact_poisson_LD_counts"]=="3.00","SFT-CHEM-ANAL-004-QUANTIFICATION":row["conventional_zero_background_example"]["LQ_counts"]=="100" and row["assumptions"]["quantitation_relative_uncertainty_percent"]=="10","SFT-CHEM-ANAL-004-ADVERSE-LIMITS":row["literature_detection_limit_span_factor"]=="nearly 1000" and row["all_conventional_zero_normal_poisson_rule_of_thumb_disagreement_and_model_assumptions_retained_as_external_provenance"],"SFT-CHEM-ANAL-004-COMPLETE-SOURCE":analysis["complete_source_count"]==6}
  summary={"recipe_count":"8","span_factor":"nearly 1000","LC_LD_LQ_counts":["0","2.71","100"],"exact_poisson_LD_counts":"3.00"}
 elif claim_id==SELECTIVITY_SPEC.claim_id:
  row=analysis["anal_005"];t2=row["complete_table_2_analyte_mobility_background_vector"];t3=row["complete_table_3_mass_tpr_fpr_vector"]
  checks={"SFT-CHEM-ANAL-005-IDENTITY":row["target_analyte_count"]==16 and row["instrument_configurations"]==2,"SFT-CHEM-ANAL-005-INTERFERENT-MATRIX":len(t2)==16 and row["background_sample_counts"]=={"AE":"9359","N/E":"1996"},"SFT-CHEM-ANAL-005-BASELINES":t2[0]["AE_K0"]=="0.9762 ± 0.0003" and t2[-1]["NE_K0"]=="1.3638 ± 0.0010","SFT-CHEM-ANAL-005-MIXTURES":"mixtures or matrices" in row["iupac_boundary"],"SFT-CHEM-ANAL-005-DISTINGUISHABILITY":row["alarm_window_cm2_V_minus1_s_minus1"]=="±0.003" and len(t3)==16,"SFT-CHEM-ANAL-005-PERFORMANCE":row["registered_screening_target"]=="TPR >=90%; FPR <=2%" and t3[9]["AE_TPR_percent"]=="90","SFT-CHEM-ANAL-005-ADVERSE-LIMITS":len(row["adverse_vector"])==7 and t2[7]["NE_background_peak_percent"]=="79.0" and row["all_instrument_mass_mobility_uncertainty_background_threshold_false_positive_false_negative_overlap_assumption_and_scope_rows_retained"],"SFT-CHEM-ANAL-005-COMPLETE-SOURCE":analysis["complete_source_count"]==6}
  summary={"analytes":16,"table_2_rows":16,"table_3_rows":16,"background_samples":{"AE":"9359","N/E":"1996"},"screening_target":"TPR >=90%; FPR <=2%"}
 else:raise ValueError("unknown ANAL-001–005 claim")
 if omit_last:checks.pop(next(reversed(checks)))
 spec=next(x for x in SPECS if x.claim_id==claim_id)
 if tuple(checks)!=tuple(x.target_id for x in spec.target_rows) or not all(checks.values()):raise ValueError(f"{claim_id} comparison changed")
 return {**summary,"complete_family_pdf_pages":pages,"complete_family_html_documents":htmls,"complete_family_characters":characters,"complete_result_vector_sha256":recorded,"all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only":True},checks

class _Validator:
 def __init__(self,root,spec):self.root,self.spec=root.resolve(),spec
 def validate(self,sealed):
  self.spec.validate();analysis,checks=exact_analysis(self.root,self.spec.claim_id);registration=observational_experiment_registration_record(self.spec);registration_hash=sha256_identity(registration);document=prediction_program_document(self.spec);program=fold_program_from_mapping(document);inputs={"registered-premise":HeldLabel("sealed-derivation",sealed.seal_hash)};envelope=PredictionEnvelope(self.spec.experiment_id,{"registered-premise":sha256_identity(inputs["registered-premise"])},tuple(checks),sealed.seal_hash,registration_hash);vault=TargetVault(experiment_id=self.spec.experiment_id,custodian_id=self.spec.experiment_id+"-external-target-custodian",targets={target:HeldLabel("external-observation",self.spec.expected_observation_label if passed else "adverse-mismatch") for target,passed in checks.items()},custody_nonce=sha256_identity((registration_hash,analysis["complete_result_vector_sha256"])),expected_envelope_hash=sha256_identity(envelope));before=snapshot_protected_tree(self.root);execution=CapabilityClosedFoldInterpreter().execute(program,inputs);boundary=BlindExperimentBoundary(envelope);prediction=boundary.seal_prediction(execution.output,execution.trace);after=snapshot_protected_tree(self.root);audited,audit=HostilePackageAuditor().audit_program_document(document,before,after)
  if sha256_identity(audited)!=execution.program_hash or not audit.passed:raise ValueError("ANAL-001–005 prediction package changed")
  release=vault.release(prediction);CrossPlatformCustodyExchange.verify(vault.commitment,release,prediction);boundary.measurement_context(release.targets);comparisons=tuple({"target_id":target,"predicted":execution.output.label,"observed":release.targets[target].label,"passed":execution.output.label==release.targets[target].label} for target in checks)
  try:exact_analysis(self.root,self.spec.claim_id,True);omission=False
  except ValueError:omission=True
  passed=all(x["passed"] for x in comparisons) and omission;isolation=seal_isolation_certificate(unsealed_isolation_certificate(executor_id=self.spec.experiment_id+"-prediction-executor",host_platform=platform.system() or "host",python_implementation=platform.python_implementation(),interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id),program_hash=execution.program_hash,input_manifest_hash=execution.input_manifest_hash,registered_target_identity_hash=vault.commitment.target_identity_hash,comparison_implementation_identity_hash=sha256_identity(("exact-anal-performance-batch/1",self.spec.claim_id,self.spec.falsification_condition)),prediction_seal_hash=prediction.seal_hash,output_hash=execution.output_hash,trace_hash=execution.trace_hash));target_identity=target_identity_from_release(release)
  if target_identity!=vault.commitment.target_identity_hash:raise ValueError("ANAL-001–005 target changed")
  custody=seal_target_custody_certificate(unsealed_target_custody_certificate(custodian_id=release.custodian_id,experiment_registration_hash=registration_hash,registered_target_identity_hash=target_identity,prediction_seal_hash=prediction.seal_hash,target_release_manifest_hash=release.release_hash));payload={"registration":registration_hash,"sealed":sealed.seal_hash,"prediction":prediction.seal_hash,"analysis":analysis,"comparisons":comparisons,"omission_rejected":omission,"trace":execution.trace_hash};notes=("complete six-source post-seal family retained as 83 PDF pages, one HTML document and 180,366 extracted characters",f"all {len(checks)} separately registered claim targets retained","all values units uncertainties assumptions corrections fits estimates losses adverse absent unavailable unresolved historical and archived-status records remain downstream provenance; disclosed pre-seal snippets are never relabelled blind");return EmpiricalValidation(sealed.seal_hash,registration_hash,isolation,custody,True,True,True,tuple(x.source_id for x in self.spec.target_rows),notes,sha256_identity(payload),self.spec.falsification_condition,passed)
class AccuracyValidator(_Validator):
 def __init__(self,root):super().__init__(root,ACCURACY_SPEC)
class PrecisionValidator(_Validator):
 def __init__(self,root):super().__init__(root,PRECISION_SPEC)
class SensitivityValidator(_Validator):
 def __init__(self,root):super().__init__(root,SENSITIVITY_SPEC)
class DetectionValidator(_Validator):
 def __init__(self,root):super().__init__(root,DETECTION_SPEC)
class SelectivityValidator(_Validator):
 def __init__(self,root):super().__init__(root,SELECTIVITY_SPEC)
__all__=("AccuracyValidator","DetectionValidator","PrecisionValidator","SelectivityValidator","SensitivityValidator","exact_analysis")

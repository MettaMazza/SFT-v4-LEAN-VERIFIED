"""Exact post-seal evaluator for the common-scale measured-value correction."""

from fractions import Fraction
import json
from pathlib import Path
import platform

from sft.claim_evidence import CapabilityClosedFoldInterpreter, CrossPlatformCustodyExchange, HostilePackageAuditor, TargetVault, fold_program_from_mapping, snapshot_protected_tree, target_identity_from_release
from sft.engine import EmpiricalValidation, seal_isolation_certificate, seal_target_custody_certificate, unsealed_isolation_certificate, unsealed_target_custody_certificate
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary, PredictionEnvelope
from sft.engine.exact import HeldLabel
from sft.engine.source import hash_file
from sft.physics.common_scale_axis_terminal_law_v1 import leading_electroweak_share, terminal_electroweak_chain
from sft.physics.common_scale_measured_value_successor_v1 import CLAIM_ID, EXPERIMENT_ID, OBSERVATION_LABEL, SOURCE_FILES, SOURCE_HASH, SOURCE_IDS, SOURCE_PATH, SPEC
from sft.physics.generated_empirical_law import experiment_registration_record, prediction_program_document


TARGET_IDS = ("PDG-COMMON-SCALE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD",)
FALSIFICATION_CONDITION = SPEC.falsification_condition


def source_hashes():
    return {SOURCE_PATH: SOURCE_HASH, **dict(SOURCE_FILES)}


def authoritative_record(root: Path):
    for relative, expected in source_hashes().items():
        if hash_file(root / relative) != expected:
            raise ValueError(f"common-scale successor source changed: {relative}")
    record = json.loads((root / SOURCE_PATH).read_text(encoding="utf-8"))
    if record.get("schema") != "sft-v3-common-scale-measured-value-successor-source-record/1":
        raise ValueError("common-scale successor schema changed")
    if record.get("formal_receipt_hash") != "sha256:44d542f87d12844c02c321ac651008ae7ddd738a3b16e7d2c3d8700ec89eca55":
        raise ValueError("common-scale formal receipt binding changed")
    if record.get("electroweak_successor_receipt_hash") != "sha256:e93f04515944a1951b78463db3083350fbc77e6d8506edbcdc13178cedfbc852":
        raise ValueError("electroweak successor receipt binding changed")
    if tuple(row.get("source_id") for row in record.get("sources", ())) != SOURCE_IDS:
        raise ValueError("complete common-scale source vector required")
    boundary = record.get("methodological_boundary", {})
    false_keys = ("measurement_selected_formal_survivor",)
    if not all(value is True for key, value in boundary.items() if key not in false_keys):
        raise ValueError("common-scale methodological boundary changed")
    if any(boundary.get(key) is not False for key in false_keys):
        raise ValueError("measurement-selection boundary changed")
    return record


def interval(center: str, uncertainty: str):
    centre, width = Fraction(center), Fraction(uncertainty)
    if centre <= width or width <= 0:
        raise ValueError("common-scale measurement interval must remain positive")
    return centre - width, centre + width


def exact_common_scale_analysis(target):
    schemes = {row["scheme"]: interval(row["center"], row["standard_uncertainty"]) for row in target["scheme_rows"]}
    low = {row["row_id"]: interval(row["center"], row["standard_uncertainty"]) for row in target["low_transfer_rows"]}
    terminal = terminal_electroweak_chain()["terminal_share"]
    support_eight = leading_electroweak_share(4)
    ms_z = schemes["MS at Z"]
    return {
        "scheme_intervals": schemes,
        "low_transfer_intervals": low,
        "terminal_inside_on_shell_interval": schemes["on-shell"][0] <= terminal <= schemes["on-shell"][1],
        "support_eight_inside_APV_interval": low["Cesium-atomic-parity-violation"][0] <= support_eight <= low["Cesium-atomic-parity-violation"][1],
        "E158_interval_above_MS_Z": low["SLAC-E158"][0] > ms_z[1],
        "APV_interval_above_MS_Z": low["Cesium-atomic-parity-violation"][0] > ms_z[1],
        "eDIS_interval_overlaps_MS_Z": not (low["Jefferson-Lab-Hall-A-eDIS"][1] < ms_z[0] or low["Jefferson-Lab-Hall-A-eDIS"][0] > ms_z[1]),
        "complete_scheme_rows": len(schemes) == 4,
        "complete_low_transfer_rows": len(low) == 4,
        "complete_displayed_classes": len(target["displayed_measurement_classes"]) == 8,
        "threshold_boundary_retained": target["below_W_effective_theory_and_beta_sign_change_retained"] is True and target["threshold_matching_discontinuities_retained"] is True,
        "strong_EM_receipt_retained": target["complete_strong_and_electromagnetic_vector_receipt_retained"] is True,
        "NuTeV_extraction_retained": target["NuTeV_extraction_retained_unchanged"] is True,
        "NuTeV_not_rewarded_as_mismatch": target["NuTeV_extraction_is_not_a_required_mismatch_or_SFT_result"] is True,
        "all_source_rows_retained": target["all_source_rows_retained_unchanged"] is True,
    }


class CommonScaleMeasuredValueSuccessorValidator:
    def __init__(self, root):
        self.root = root.resolve()

    def validate(self, sealed):
        if sealed.claim_id != CLAIM_ID:
            raise ValueError("wrong common-scale successor seal")
        registration = experiment_registration_record(SPEC)
        registration_hash = sha256_identity(registration)
        document = prediction_program_document(SPEC)
        program = fold_program_from_mapping(document)
        inputs = {"registered-premise": HeldLabel("sealed-derivation", sealed.seal_hash)}
        envelope = PredictionEnvelope(EXPERIMENT_ID, {"registered-premise": sha256_identity(inputs["registered-premise"])}, TARGET_IDS, sealed.seal_hash, registration_hash)
        target = authoritative_record(self.root)["registered_target"]
        vault = TargetVault(experiment_id=EXPERIMENT_ID, custodian_id=EXPERIMENT_ID + "-external-target-custodian", targets={TARGET_IDS[0]: target}, custody_nonce=sha256_identity((registration_hash, source_hashes())), expected_envelope_hash=sha256_identity(envelope))
        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited, audit = HostilePackageAuditor().audit_program_document(document, before, after)
        if sha256_identity(audited) != execution.program_hash or not audit.passed:
            raise ValueError("common-scale successor prediction audit failed")
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        _, context = boundary.measurement_context(release.targets)
        if not isinstance(execution.output, HeldLabel) or execution.output.label != OBSERVATION_LABEL:
            raise ValueError("common-scale successor prediction label changed")
        analysis = exact_common_scale_analysis(context[TARGET_IDS[0]])
        empirical = all(value for key, value in analysis.items() if key not in {"scheme_intervals", "low_transfer_intervals"})
        tampered_terminal = json.loads(json.dumps(context[TARGET_IDS[0]]))
        tampered_terminal["scheme_rows"][0]["center"] = "0.22000"
        tampered_terminal_rejected = not exact_common_scale_analysis(tampered_terminal)["terminal_inside_on_shell_interval"]
        tampered_apv = json.loads(json.dumps(context[TARGET_IDS[0]]))
        tampered_apv["low_transfer_rows"][3]["center"] = "0.2300"
        tampered_apv["low_transfer_rows"][3]["standard_uncertainty"] = "0.0001"
        tampered_apv_rejected = not exact_common_scale_analysis(tampered_apv)["support_eight_inside_APV_interval"]
        passed = all(row[2] for row in SPEC.operational_witnesses) and empirical and tampered_terminal_rejected and tampered_apv_rejected
        isolation = seal_isolation_certificate(unsealed_isolation_certificate(
            executor_id=EXPERIMENT_ID + "-prediction-executor", host_platform=platform.system() or "registered-host", python_implementation=platform.python_implementation(), interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id), program_hash=execution.program_hash, input_manifest_hash=execution.input_manifest_hash, registered_target_identity_hash=vault.commitment.target_identity_hash, comparison_implementation_identity_hash=sha256_identity(("exact-common-scale-measured-value-successor/1", registration_hash, FALSIFICATION_CONDITION)), prediction_seal_hash=prediction_seal.seal_hash, output_hash=execution.output_hash, trace_hash=execution.trace_hash,
        ))
        target_identity = target_identity_from_release(release)
        custody = seal_target_custody_certificate(unsealed_target_custody_certificate(custodian_id=release.custodian_id, experiment_registration_hash=registration_hash, registered_target_identity_hash=target_identity, prediction_seal_hash=prediction_seal.seal_hash, target_release_manifest_hash=release.release_hash))
        payload = {"seal": sealed.seal_hash, "sources": source_hashes(), "target": target_identity, "analysis": analysis, "tampered_terminal_rejected": tampered_terminal_rejected, "tampered_APV_rejected": tampered_apv_rejected}
        measurements = (
            "The exact forced terminal weak share lies inside [22333,22351]/100000.",
            "The exact forced support-eight share 25/106 lies inside [2331,2367]/10000.",
            "The complete E158 and APV intervals preserve the sealed below-W direction relative to the MS-Z interval.",
            "NuTeV remains unchanged as a source-identified interpretation-sensitive DIS extraction; its displacement is not an SFT result or acceptance condition.",
            "No row was deleted and no uncertainty was widened; displaced terminal and APV controls reject.",
        )
        return EmpiricalValidation(sealed.seal_hash, registration_hash, isolation, custody, True, True, analysis["all_source_rows_retained"], SOURCE_IDS, measurements, sha256_identity(payload), FALSIFICATION_CONDITION, passed)


__all__ = ("CommonScaleMeasuredValueSuccessorValidator", "FALSIFICATION_CONDITION", "TARGET_IDS", "authoritative_record", "exact_common_scale_analysis", "source_hashes")

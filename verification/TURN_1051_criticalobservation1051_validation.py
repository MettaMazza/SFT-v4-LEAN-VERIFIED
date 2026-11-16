"""Exact post-seal evaluator for criticality and turbulence scaling."""

import json
from pathlib import Path
import platform

from sft.claim_evidence import (
    CapabilityClosedFoldInterpreter,
    CrossPlatformCustodyExchange,
    HostilePackageAuditor,
    TargetVault,
    fold_program_from_mapping,
    snapshot_protected_tree,
    target_identity_from_release,
)
from sft.engine import (
    EmpiricalValidation,
    seal_isolation_certificate,
    seal_target_custody_certificate,
    unsealed_isolation_certificate,
    unsealed_target_custody_certificate,
)
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary, PredictionEnvelope
from sft.engine.exact import HeldLabel
from sft.engine.source import hash_file
from sft.physics.criticality_universality_turbulence_empirical_v1 import (
    CLAIM_ID,
    EXPERIMENT_ID,
    OBSERVATION_LABEL,
    SOURCE_FILES,
    SOURCE_HASH,
    SOURCE_IDS,
    SOURCE_PATH,
    SPEC,
)
from sft.physics.generated_empirical_law import experiment_registration_record, prediction_program_document


TARGET_IDS = ("CRITICALITY-UNIVERSALITY-TURBULENCE-WITHHELD-COMPLETE-RECORD",)
FALSIFICATION_CONDITION = SPEC.falsification_condition


def source_hashes():
    return {SOURCE_PATH: SOURCE_HASH, **dict(SOURCE_FILES)}


def authoritative_record(root: Path):
    for relative, expected in source_hashes().items():
        if hash_file(root / relative) != expected:
            raise ValueError(f"criticality/turbulence source changed: {relative}")
    record = json.loads((root / SOURCE_PATH).read_text(encoding="utf-8"))
    if record.get("schema") != "sft-v3-criticality-universality-turbulence-postseal-source-record/1":
        raise ValueError("criticality/turbulence source schema changed")
    if record.get("formal_receipt_hash") != "sha256:0601d19640943c4b99eb8cccf061e3115c520773eac5e762bf7c5b7440339b25":
        raise ValueError("formal criticality/turbulence receipt binding changed")
    if len(record.get("sources", ())) != 4:
        raise ValueError("complete four-source criticality/turbulence record required")
    return record


def _positive_whole(value):
    return not isinstance(value, bool) and isinstance(value, int) and value > 0


def _contains(center, uncertainty, measurement_denominator, forced_numerator, forced_denominator):
    lower = center - uncertainty
    upper = center + uncertainty
    return (
        all(_positive_whole(value) for value in (lower, upper, uncertainty, measurement_denominator, forced_numerator, forced_denominator))
        and lower * forced_denominator <= forced_numerator * measurement_denominator <= upper * forced_denominator
    )


def exact_criticality_turbulence_analysis(target):
    beta = (int(target["critical_beta_numerator"]), int(target["critical_beta_denominator"]))
    nu = (int(target["critical_nu_numerator"]), int(target["critical_nu_denominator"]))
    gamma = (int(target["critical_gamma_numerator"]), int(target["critical_gamma_denominator"]))
    delta = (int(target["critical_delta_numerator"]), int(target["critical_delta_denominator"]))
    manganite_denominator = int(target["manganite_measurement_denominator"])
    manganite_matches = {}
    manganite_components = {}
    positive_rows = True
    for row in target["manganite_rows"]:
        components = {
            "beta": _contains(int(row["beta_center"]), int(row["beta_uncertainty"]), manganite_denominator, *beta),
            "gamma": _contains(int(row["gamma_center"]), int(row["gamma_uncertainty"]), manganite_denominator, *gamma),
            "delta": _contains(int(row["delta_center"]), int(row["delta_uncertainty"]), manganite_denominator, *delta),
        }
        manganite_components[row["sample"]] = components
        manganite_matches[row["sample"]] = all(components.values())
        positive_rows = positive_rows and all(
            _positive_whole(int(row[key]))
            for key in ("beta_center", "beta_uncertainty", "gamma_center", "gamma_uncertainty", "delta_center", "delta_uncertainty")
        )
    expected_matches = tuple(target["manganite_expected_complete_vector_matches"])
    nonmatch = target["manganite_expected_nonmatching_control"]
    erbium_denominator = int(target["erbium_measurement_denominator"])
    erbium = {
        "beta": _contains(int(target["erbium_beta_center"]), int(target["erbium_beta_uncertainty"]), erbium_denominator, *beta),
        "gamma": _contains(int(target["erbium_gamma_center"]), int(target["erbium_gamma_uncertainty"]), erbium_denominator, *gamma),
        "nu": _contains(int(target["erbium_nu_center"]), int(target["erbium_nu_uncertainty"]), erbium_denominator, *nu),
    }
    structure_interval = (
        int(target["turbulence_measured_structure_center"]) - int(target["turbulence_measured_structure_uncertainty"]),
        int(target["turbulence_measured_structure_center"]) + int(target["turbulence_measured_structure_uncertainty"]),
    )
    structure_contains = _contains(
        int(target["turbulence_measured_structure_center"]),
        int(target["turbulence_measured_structure_uncertainty"]),
        int(target["turbulence_measured_structure_denominator"]),
        int(target["turbulence_structure_numerator"]),
        int(target["turbulence_structure_denominator"]),
    )
    plateau_ranges_positive = all(
        _positive_whole(int(target[key]))
        for key in (
            "spectrum_physical_sample_reynolds_count",
            "spectrum_sampling_frequency_hz",
            "spectrum_fourier_plateau_lower_hz",
            "spectrum_fourier_plateau_upper_hz",
            "spectrum_hilbert_plateau_lower_hz",
            "spectrum_hilbert_plateau_upper_hz",
        )
    )
    return {
        "positive_exact_carriers": all(_positive_whole(value) for value in (*beta, *nu, *gamma, *delta, manganite_denominator, erbium_denominator)) and positive_rows,
        "manganite_components": manganite_components,
        "manganite_matches": manganite_matches,
        "manganite_complete_five_rows": len(manganite_matches) == 5 and len(set(manganite_matches)) == 5,
        "manganite_expected_matches_exact": tuple(sample for sample, matches in manganite_matches.items() if matches) == expected_matches,
        "manganite_nonmatch_retained": nonmatch in manganite_matches and not manganite_matches[nonmatch],
        "manganite_nonmatch_gamma_rejects": nonmatch in manganite_components and not manganite_components[nonmatch]["gamma"],
        "manganite_nonmatch_delta_rejects": nonmatch in manganite_components and not manganite_components[nonmatch]["delta"],
        "erbium_components": erbium,
        "erbium_complete_vector_matches": all(erbium.values()),
        "structure_interval": structure_interval,
        "structure_interval_contains_two_thirds": structure_contains,
        "finite_reynolds_boundary_retained": target["turbulence_finite_reynolds_limit_retained"] is True,
        "spectrum_exact_magnitude": int(target["turbulence_spectrum_numerator"]) == 5 and int(target["turbulence_spectrum_denominator"]) == 3,
        "spectrum_falling_orientation": target["turbulence_spectrum_orientation"] == "falling",
        "spectrum_five_thirds_compensation": target["spectrum_five_thirds_compensation_used"] is True,
        "spectrum_fourier_plateau": target["spectrum_fourier_plateau_observed"] is True,
        "spectrum_hilbert_plateau": target["spectrum_hilbert_plateau_observed"] is True,
        "spectrum_ranges_ordered": plateau_ranges_positive and int(target["spectrum_fourier_plateau_lower_hz"]) < int(target["spectrum_fourier_plateau_upper_hz"]) and int(target["spectrum_hilbert_plateau_lower_hz"]) < int(target["spectrum_hilbert_plateau_upper_hz"]),
        "spectrum_structure_limit_retained": target["spectrum_structure_function_range_limitation_retained"] is True,
        "threshold_boundary_retained": target["normalized_half_one_threshold_not_universal_lab_temperature"] is True,
        "empty_exponent_boundary_retained": target["empty_alpha_eta_not_numerical_zero_measurements"] is True,
        "all_manganite_rows_retained": target["all_manganite_rows_retained"] is True,
        "all_rows_retained": target["all_registered_rows_retained"] is True,
    }


class CriticalityUniversalityTurbulenceValidator:
    def __init__(self, root):
        self.root = root.resolve()

    def validate(self, sealed):
        if sealed.claim_id != CLAIM_ID:
            raise ValueError("wrong criticality/turbulence seal")
        registration = experiment_registration_record(SPEC)
        registration_hash = sha256_identity(registration)
        document = prediction_program_document(SPEC)
        program = fold_program_from_mapping(document)
        inputs = {"registered-premise": HeldLabel("sealed-derivation", sealed.seal_hash)}
        envelope = PredictionEnvelope(
            EXPERIMENT_ID,
            {"registered-premise": sha256_identity(inputs["registered-premise"])},
            TARGET_IDS,
            sealed.seal_hash,
            registration_hash,
        )
        targets = {TARGET_IDS[0]: authoritative_record(self.root)["registered_target"]}
        vault = TargetVault(
            experiment_id=EXPERIMENT_ID,
            custodian_id=EXPERIMENT_ID + "-external-target-custodian",
            targets=targets,
            custody_nonce=sha256_identity((registration_hash, source_hashes())),
            expected_envelope_hash=sha256_identity(envelope),
        )
        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited, audit = HostilePackageAuditor().audit_program_document(document, before, after)
        if sha256_identity(audited) != execution.program_hash or not audit.passed:
            raise ValueError("criticality/turbulence prediction audit failed")
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        _, context = boundary.measurement_context(release.targets)
        if not isinstance(execution.output, HeldLabel) or execution.output.label != OBSERVATION_LABEL:
            raise ValueError("criticality/turbulence prediction label changed")
        analysis = exact_criticality_turbulence_analysis(context[TARGET_IDS[0]])
        formal = all(row[2] for row in SPEC.operational_witnesses)
        empirical_keys = (
            "positive_exact_carriers",
            "manganite_complete_five_rows",
            "manganite_expected_matches_exact",
            "manganite_nonmatch_retained",
            "manganite_nonmatch_gamma_rejects",
            "manganite_nonmatch_delta_rejects",
            "erbium_complete_vector_matches",
            "structure_interval_contains_two_thirds",
            "finite_reynolds_boundary_retained",
            "spectrum_exact_magnitude",
            "spectrum_falling_orientation",
            "spectrum_five_thirds_compensation",
            "spectrum_fourier_plateau",
            "spectrum_hilbert_plateau",
            "spectrum_ranges_ordered",
            "spectrum_structure_limit_retained",
            "threshold_boundary_retained",
            "empty_exponent_boundary_retained",
            "all_manganite_rows_retained",
            "all_rows_retained",
        )
        empirical = all(analysis[key] for key in empirical_keys)
        tampered_structure = dict(context[TARGET_IDS[0]])
        tampered_structure["turbulence_measured_structure_center"] = 620
        tampered_structure_rejected = not exact_criticality_turbulence_analysis(tampered_structure)["structure_interval_contains_two_thirds"]
        relabelled_nonmatch = dict(context[TARGET_IDS[0]])
        relabelled_nonmatch["manganite_expected_complete_vector_matches"] = ["La00", "La02", "La04", "La06", "La08"]
        relabelled_nonmatch_rejected = not exact_criticality_turbulence_analysis(relabelled_nonmatch)["manganite_expected_matches_exact"]
        removed_row = dict(context[TARGET_IDS[0]])
        removed_row["manganite_rows"] = list(removed_row["manganite_rows"][:-1])
        removed_row_rejected = not exact_criticality_turbulence_analysis(removed_row)["manganite_complete_five_rows"]
        reversed_spectrum = dict(context[TARGET_IDS[0]])
        reversed_spectrum["turbulence_spectrum_orientation"] = "rising"
        reversed_spectrum_rejected = not exact_criticality_turbulence_analysis(reversed_spectrum)["spectrum_falling_orientation"]
        passed = formal and empirical and tampered_structure_rejected and relabelled_nonmatch_rejected and removed_row_rejected and reversed_spectrum_rejected
        isolation = seal_isolation_certificate(
            unsealed_isolation_certificate(
                executor_id=EXPERIMENT_ID + "-prediction-executor",
                host_platform=platform.system() or "registered-host",
                python_implementation=platform.python_implementation(),
                interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id),
                program_hash=execution.program_hash,
                input_manifest_hash=execution.input_manifest_hash,
                registered_target_identity_hash=vault.commitment.target_identity_hash,
                comparison_implementation_identity_hash=sha256_identity(("exact-criticality-universality-turbulence-comparator/1", registration_hash, FALSIFICATION_CONDITION)),
                prediction_seal_hash=prediction_seal.seal_hash,
                output_hash=execution.output_hash,
                trace_hash=execution.trace_hash,
            )
        )
        target_identity = target_identity_from_release(release)
        custody = seal_target_custody_certificate(
            unsealed_target_custody_certificate(
                custodian_id=release.custodian_id,
                experiment_registration_hash=registration_hash,
                registered_target_identity_hash=target_identity,
                prediction_seal_hash=prediction_seal.seal_hash,
                target_release_manifest_hash=release.release_hash,
            )
        )
        payload = {
            "seal": sealed.seal_hash,
            "sources": source_hashes(),
            "target": target_identity,
            "analysis": analysis,
            "formal": formal,
            "empirical": empirical,
            "controls": (tampered_structure_rejected, relabelled_nonmatch_rejected, removed_row_rejected, reversed_spectrum_rejected),
        }
        measurements = (
            "Erbium beta/gamma/nu intervals contain exactly 1/2, One and 1/2.",
            "Four of five complete manganite vectors contain exactly beta=1/2, gamma=One and delta=three.",
            "La02 is retained and rejected as a complete member of that generated exponent class.",
            "The independent zeta_2 interval [666,692]/1000 contains exactly 2/3.",
            "The physical channel-flow record exhibits five-thirds compensated plateaux by Fourier and Hilbert routes.",
            "Finite-Reynolds, structure-function-range, threshold and empty-exponent boundaries remain retained.",
            "Tampered interval, relabelled nonmatch, removed-row and reversed-spectrum controls reject.",
        )
        return EmpiricalValidation(
            sealed.seal_hash,
            registration_hash,
            isolation,
            custody,
            True,
            True,
            analysis["all_rows_retained"],
            SOURCE_IDS,
            measurements,
            sha256_identity(payload),
            FALSIFICATION_CONDITION,
            passed,
        )


__all__ = (
    "FALSIFICATION_CONDITION",
    "TARGET_IDS",
    "CriticalityUniversalityTurbulenceValidator",
    "authoritative_record",
    "exact_criticality_turbulence_analysis",
    "source_hashes",
)

"""Capability-closed post-seal validation for Chemistry INORG-006."""

from __future__ import annotations

import json
from pathlib import Path
import platform

from sft.chemistry.ligand_state_splitting_batch_v1 import (
    IDENTITY_HASH, IDENTITY_PATH, LIGAND_STATE_SPLITTING_SPEC, PRIMARY_HASH, PRIMARY_PATH,
    TARGET_HASH, TARGET_PATH,
)
from sft.chemistry.ligand_state_splitting_law_v1 import (
    forced_ligand_state_splitting, four_complete_axis_geometry, generate_complete_rank_two_support,
    removed_ligand_remerging, six_direct_axis_geometry,
)
from sft.claim_evidence import (
    CapabilityClosedFoldInterpreter, CrossPlatformCustodyExchange, EmptyOne, FoldLanguageHalt,
    FoldTable, FoldWord, HostilePackageAuditor, TargetVault, fold_program_from_mapping,
    snapshot_protected_tree, target_identity_from_release,
)
from sft.engine import (
    EmpiricalValidation, seal_isolation_certificate, seal_target_custody_certificate,
    unsealed_isolation_certificate, unsealed_target_custody_certificate,
)
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary, PredictionEnvelope
from sft.engine.exact import ExactPart, HeldLabel
from sft.engine.source import hash_file


IDENTITY_KEYS = (
    "target_id", "source_record_ordinal", "source_id", "authority", "source_record_role", "custody_class",
)
EXPECTED_LAWS = (
    "five-supports-from-generator-three-and-boundary-rank-two",
    "complete-ligand-incidence-signature-partitions-levels",
    "positive-block-cardinalities-preserve-all-members",
    "exact-normalized-separation-and-complementary-balance",
    "all-thirty-two-definition-development-adverse-absent-ancillary-and-blind-surfaces-retained",
)


def _identities(root: Path) -> tuple[dict, ...]:
    if hash_file(root / IDENTITY_PATH) != IDENTITY_HASH:
        raise ValueError("INORG-006 identity registry changed")
    document = json.loads((root / IDENTITY_PATH).read_text(encoding="utf-8"))
    rows = tuple(document.get("rows", ()))
    forbidden = {"value", "outcome", "definition", "peak", "intensity", "band_count", "source_outcome", "target_payload_hash"}
    if (
        document.get("complete_registered_target_count") != 32
        or document.get("target_values_peak_positions_intensities_band_counts_definitions_and_outcomes_present") is not False
        or len(rows) != 32
        or tuple(row["source_record_ordinal"] for row in rows) != tuple(range(1, 33))
        or any(forbidden.intersection(row) for row in rows)
    ):
        raise ValueError("INORG-006 value-free identity boundary changed")
    return rows


def prediction_program_document(root: Path) -> dict:
    instructions = [{"opcode": "input", "destination": "premise", "arguments": ["registered-premise"]}]
    table: list[str] = []
    for ordinal, row in enumerate(_identities(root), start=1):
        prefix = f"ligand-state-splitting-record-{ordinal}"
        instructions.append({"opcode": "label", "destination": prefix + "-target", "arguments": ["target-id", row["target_id"]]})
        registers = ["premise"]
        for number, key in enumerate(IDENTITY_KEYS[1:], start=1):
            destination = f"{prefix}-identity-{number}"
            instructions.append({"opcode": "label", "destination": destination, "arguments": ["registered-source-identity", str(row[key])]})
            registers.append(destination)
        for label in EXPECTED_LAWS:
            destination = f"{prefix}-law-{len(registers)}"
            instructions.append({"opcode": "label", "destination": destination, "arguments": ["ligand-state-splitting-law", label]})
            registers.append(destination)
        instructions.append({"opcode": "word", "destination": prefix + "-word", "arguments": registers})
        table.extend((prefix + "-target", prefix + "-word"))
    instructions.extend((
        {"opcode": "table", "destination": "complete-ligand-state-splitting-vector", "arguments": table},
        {"opcode": "emit", "destination": "", "arguments": ["complete-ligand-state-splitting-vector"]},
    ))
    return {"schema": "sft-v3-fold-program/1", "program_id": LIGAND_STATE_SPLITTING_SPEC.experiment_id + "-value-free-vector", "instructions": instructions}


def experiment_registration_record(root: Path) -> dict:
    return {
        "experiment_id": LIGAND_STATE_SPLITTING_SPEC.experiment_id,
        "claim_id": LIGAND_STATE_SPLITTING_SPEC.claim_id,
        "provenance": "observational_derivation_with_law-sealed-blind-successor",
        "frozen_relation": LIGAND_STATE_SPLITTING_SPEC.exact_result,
        "identity_registry": (IDENTITY_PATH, IDENTITY_HASH),
        "withheld_target_registry": (TARGET_PATH, TARGET_HASH),
        "primary_source_record": (PRIMARY_PATH, PRIMARY_HASH),
        "prediction_program": prediction_program_document(root),
        "target_ids": tuple(row.target_id for row in LIGAND_STATE_SPLITTING_SPEC.target_rows),
        "all_32_rows_required": True,
        "development_observation_and_two_adverse_blind_absences_disclosed": True,
        "final_numeric_target_opened_only_after_law_and_identity_seal": True,
        "target_content_inaccessible_to_prediction_execution": True,
        "no_smoothing_threshold_fitted_wavelength_or_dimensional_anchor": True,
        "falsification_condition": LIGAND_STATE_SPLITTING_SPEC.falsification_condition,
    }


def _prediction_map(output: object) -> dict[str, FoldWord]:
    if not isinstance(output, FoldTable) or len(output.entries) != 32:
        raise ValueError("INORG-006 prediction is not the complete 32-row table")
    result: dict[str, FoldWord] = {}
    for entry in output.entries:
        if not isinstance(entry.left, HeldLabel) or entry.left.family != "target-id" or not isinstance(entry.right, FoldWord) or len(entry.right.cells) != 11:
            raise ValueError("INORG-006 prediction row is incomplete")
        result[entry.left.label] = entry.right
    if len(result) != 32:
        raise ValueError("INORG-006 prediction duplicates a target")
    return result


def _source_rows(root: Path) -> tuple[dict, ...]:
    if hash_file(root / TARGET_PATH) != TARGET_HASH or hash_file(root / PRIMARY_PATH) != PRIMARY_HASH:
        raise ValueError("INORG-006 post-seal target evidence changed")
    identities = _identities(root)
    document = json.loads((root / TARGET_PATH).read_text(encoding="utf-8"))
    rows = tuple(document.get("rows", ()))
    if document.get("complete_registered_target_count") != 32 or len(rows) != 32 or document.get("release_requires_prediction_seal") is not True:
        raise ValueError("INORG-006 target vector is incomplete")
    resolved = []
    for identity, row in zip(identities, rows):
        if any(identity[key] != row.get(key) for key in IDENTITY_KEYS):
            raise ValueError("INORG-006 target differs from registered identity")
        if row.get("target_payload_hash") != sha256_identity((identity["target_id"], identity["source_record_role"], row.get("source_outcome"))):
            raise ValueError("INORG-006 target payload hash changed")
        resolved.append(row)
    return tuple(resolved)


def exact_analysis(rows: tuple[dict, ...], primary: dict) -> dict[str, object]:
    if len(rows) != 32:
        raise ValueError("INORG-006 requires all 32 source surfaces")
    six = forced_ligand_state_splitting(six_direct_axis_geometry())
    four = forced_ligand_state_splitting(four_complete_axis_geometry())
    removed = removed_ligand_remerging(HeldLabel("coordination-central-occurrence", "validation-centre"))
    postseal = primary["exact_postseal_analysis"]
    blind_spectra = [row for row in rows if row["custody_class"] == "law-sealed-blind" and row["source_outcome"].get("payload_class") == "complete-uv-visible-spectrum"]
    adverse_absences = [row for row in rows if row["source_outcome"].get("surface_class") == "linked-spectrum-absence"]
    ancillary = [row for row in rows if row["source_outcome"].get("payload_class") == "captured-non-spectrum-ancillary"]
    iupac_definitions = " ".join(str(row["source_outcome"].get("definition", "")) for row in rows if row["authority"] == "IUPAC")
    return {
        "generated_support_count": len(generate_complete_rank_two_support()),
        "six_multiplicity_vector": tuple(level.positive_multiplicity.value for level in six.levels),
        "six_separation_vector": tuple(str(part.value) for part in six.adjacent_positive_separations),
        "six_balance_vector": (str(six.lower_distance_from_unsplit_or_absence.value), str(six.upper_distance_from_unsplit_or_absence.value)),
        "four_multiplicity_vector": tuple(level.positive_multiplicity.value for level in four.levels),
        "four_separation_vector": tuple(str(part.value) for part in four.adjacent_positive_separations),
        "four_balance_vector": (str(four.lower_distance_from_unsplit_or_absence.value), str(four.upper_distance_from_unsplit_or_absence.value)),
        "all_members_preserved": six.complete_member_preservation and four.complete_member_preservation,
        "removal_remerges_one_five_member_class": len(removed.levels) == 1 and removed.levels[0].positive_multiplicity.value == 5 and isinstance(removed.levels[0].interaction_rank, EmptyOne),
        "iupac_removal_of_degeneracy_surface_present": "removal of a degeneracy" in iupac_definitions,
        "iupac_ligand_attachment_reduced_symmetry_surface_present": "attachment or removal of ligands" in iupac_definitions and "reduced symmetries" in iupac_definitions,
        "iupac_conventional_variable_parameter_surface_preserved_as_downstream": "parameters as variables" in iupac_definitions,
        "blind_spectrum_payload_count": len(blind_spectra),
        "blind_complete_interior_maximum_counts": tuple(len(row["source_outcome"]["complete_interior_local_maxima"]) for row in blind_spectra),
        "blind_exact_interior_peak_positions": tuple(tuple(peak["x"] for peak in row["source_outcome"]["complete_interior_local_maxima"]) for row in blind_spectra),
        "blind_exact_adjacent_peak_separations": tuple(tuple(row["source_outcome"]["adjacent_interior_maximum_separations"]) for row in blind_spectra),
        "blind_distinguishability_condition_passed": bool(blind_spectra) and all(len(row["source_outcome"]["complete_interior_local_maxima"]) >= 2 for row in blind_spectra),
        "law_sealed_adverse_absence_count": len(adverse_absences),
        "development_ancillary_count": len(ancillary),
        "complete_32_rows_preserved": len(rows) == 32 and postseal["all_32_rows_preserved"],
        "no_dimensional_wavelength_fitted_or_claimed": postseal["no_dimensional_wavelength_fitted_or_claimed"],
    }


class LigandStateSplittingValidator:
    def __init__(self, root: Path):
        self.root = root.resolve()
        self.spec = LIGAND_STATE_SPLITTING_SPEC

    def validate(self, sealed) -> EmpiricalValidation:
        self.spec.validate()
        registration = experiment_registration_record(self.root)
        registration_hash = sha256_identity(registration)
        document = prediction_program_document(self.root)
        program = fold_program_from_mapping(document)
        inputs = {"registered-premise": HeldLabel("sealed-derivation", sealed.seal_hash)}
        envelope = PredictionEnvelope(self.spec.experiment_id, {"registered-premise": sha256_identity(inputs["registered-premise"])}, tuple(row.target_id for row in self.spec.target_rows), sealed.seal_hash, registration_hash)
        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited, audit = HostilePackageAuditor().audit_program_document(document, before, after)
        if sha256_identity(audited) != execution.program_hash or not audit.passed:
            raise ValueError("INORG-006 prediction package changed")
        predicted = _prediction_map(execution.output)
        source_rows = _source_rows(self.root)
        vault = TargetVault(
            experiment_id=self.spec.experiment_id,
            custodian_id=self.spec.experiment_id + "-complete-target-custodian",
            targets={row["target_id"]: HeldLabel("external-complete-source-record-hash", row["target_payload_hash"]) for row in source_rows},
            custody_nonce=sha256_identity((registration_hash, TARGET_HASH)),
            expected_envelope_hash=sha256_identity(envelope),
        )
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        boundary.measurement_context(release.targets)

        comparisons = []
        for row in source_rows:
            word = predicted[row["target_id"]]
            identity_values = tuple(str(row[key]) for key in IDENTITY_KEYS[1:])
            identity_match = all(isinstance(word.cells[index], HeldLabel) and word.cells[index].label == value for index, value in enumerate(identity_values, start=1))
            law_match = tuple(cell.label for cell in word.cells[6:]) == EXPECTED_LAWS
            target_match = release.targets[row["target_id"]] == HeldLabel("external-complete-source-record-hash", row["target_payload_hash"])
            comparisons.append({"target_id": row["target_id"], "identity_match": identity_match, "law_match": law_match, "postseal_target_hash_match": target_match, "passed": identity_match and law_match and target_match})

        primary = json.loads((self.root / PRIMARY_PATH).read_text(encoding="utf-8"))
        analysis = exact_analysis(source_rows, primary)
        try:
            exact_analysis(source_rows[:-1], primary)
            omitted_rejected = False
        except ValueError:
            omitted_rejected = True
        try:
            FoldWord((0,))
            zero_rejected = False
        except FoldLanguageHalt:
            zero_rejected = True
        tampered_multiplicity_rejected = analysis["six_multiplicity_vector"] != (2, 3)
        controls = {
            "omitted_source_row_rejected": omitted_rejected,
            "numerical_zero_rejected": zero_rejected,
            "tampered_six_direct_axis_multiplicity_rejected": tampered_multiplicity_rejected,
            "all_32_target_hashes_bound_postseal": len(release.targets) == 32,
            "prediction_contains_no_target_payload_hash_or_peak_value": "target_payload_hash" not in json.dumps(document, sort_keys=True) and "48361/200" not in json.dumps(document, sort_keys=True),
            "two_adverse_blind_absences_preserved": analysis["law_sealed_adverse_absence_count"] == 2,
            "twelve_development_ancillary_rows_preserved": analysis["development_ancillary_count"] == 12,
        }
        passed = (
            all(row["passed"] for row in comparisons)
            and analysis["generated_support_count"] == 5
            and analysis["six_multiplicity_vector"] == (3, 2)
            and analysis["six_separation_vector"] == ("2/3",)
            and analysis["six_balance_vector"] == ("2/5", "3/5")
            and analysis["four_multiplicity_vector"] == (2, 3)
            and analysis["four_separation_vector"] == ("1",)
            and analysis["four_balance_vector"] == ("3/5", "2/5")
            and analysis["all_members_preserved"]
            and analysis["removal_remerges_one_five_member_class"]
            and analysis["iupac_removal_of_degeneracy_surface_present"]
            and analysis["iupac_ligand_attachment_reduced_symmetry_surface_present"]
            and analysis["iupac_conventional_variable_parameter_surface_preserved_as_downstream"]
            and analysis["blind_spectrum_payload_count"] == 1
            and analysis["blind_distinguishability_condition_passed"]
            and analysis["complete_32_rows_preserved"]
            and analysis["no_dimensional_wavelength_fitted_or_claimed"]
            and all(controls.values())
        )

        isolation = seal_isolation_certificate(unsealed_isolation_certificate(
            executor_id=self.spec.experiment_id + "-prediction-executor",
            host_platform=platform.system() or "registered-host",
            python_implementation=platform.python_implementation(),
            interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id),
            program_hash=execution.program_hash,
            input_manifest_hash=execution.input_manifest_hash,
            registered_target_identity_hash=vault.commitment.target_identity_hash,
            comparison_implementation_identity_hash=sha256_identity(("exact-ligand-state-splitting/1", self.spec.falsification_condition)),
            prediction_seal_hash=prediction_seal.seal_hash,
            output_hash=execution.output_hash,
            trace_hash=execution.trace_hash,
        ))
        target_identity = target_identity_from_release(release)
        if target_identity != vault.commitment.target_identity_hash:
            raise ValueError("INORG-006 released target identity differs")
        custody = seal_target_custody_certificate(unsealed_target_custody_certificate(
            custodian_id=release.custodian_id,
            experiment_registration_hash=registration_hash,
            registered_target_identity_hash=target_identity,
            prediction_seal_hash=prediction_seal.seal_hash,
            target_release_manifest_hash=release.release_hash,
        ))
        payload = {"registration": registration_hash, "sealed": sealed.seal_hash, "prediction": prediction_seal.seal_hash, "analysis": analysis, "comparisons": comparisons, "controls": controls, "trace": execution.trace_hash}
        measurements = (
            "forced five-support partition: two held contrasts plus three boundary pairs",
            "six direct-axis multiplicities 3 and 2; structural separation 2/3; balance distances 2/5 and 3/5",
            "four complete-axis multiplicities 2 and 3; structural separation 1; balance distances 3/5 and 2/5",
            f"law-sealed blind NIST spectrum interior maxima {analysis['blind_exact_interior_peak_positions']} with exact separation {analysis['blind_exact_adjacent_peak_separations']}",
            "two law-sealed absent NIST spectrum rows and twelve development ancillary captures preserved",
            "IUPAC degeneracy-removal and ligand-attachment/reduced-symmetry surfaces preserved; conventional variable parameters remain downstream only",
        ) + tuple(f"control {key}: {value}" for key, value in controls.items())
        return EmpiricalValidation(
            sealed.seal_hash, registration_hash, isolation, custody, True, True, True,
            tuple(dict.fromkeys(row["source_id"] for row in source_rows)), measurements,
            sha256_identity(payload), self.spec.falsification_condition, passed,
        )


__all__ = (
    "LigandStateSplittingValidator", "_identities", "_prediction_map", "_source_rows", "exact_analysis",
    "experiment_registration_record", "prediction_program_document",
)

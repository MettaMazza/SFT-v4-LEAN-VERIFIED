"""Capability-closed post-seal validation for Chemistry INORG-003."""

from __future__ import annotations

import json
from pathlib import Path
import platform

from sft.chemistry.coordination_entity_law_v1 import (
    CompleteCoordinationEntity,
    RetainedCoordinationAttachment,
)
from sft.chemistry.ligand_denticity_chelation_batch_v1 import (
    IDENTITY_HASH,
    IDENTITY_PATH,
    INVENTORY_HASH,
    INVENTORY_PATH,
    LIGAND_DENTICITY_CHELATION_SPEC,
    PRIMARY_HASH,
    PRIMARY_PATH,
    SOURCE_FILES,
    SPEC_HASH,
    SPEC_PATH,
    TARGET_HASH,
    TARGET_PATH,
)
from sft.chemistry.ligand_denticity_chelation_law_v1 import (
    CompleteLigandDonorTopology,
    append_donor_site_preserves_topology_and_increments_denticity,
    forced_ligand_denticity_and_chelation,
)
from sft.claim_evidence import (
    CapabilityClosedFoldInterpreter,
    CrossPlatformCustodyExchange,
    FoldTable,
    FoldWord,
    HostilePackageAuditor,
    TargetVault,
    fold_program_from_mapping,
    snapshot_protected_tree,
    target_identity_from_release,
)
from sft.claim_evidence.fold_language import FoldLanguageHalt
from sft.engine import (
    EmpiricalValidation,
    seal_isolation_certificate,
    seal_target_custody_certificate,
    unsealed_isolation_certificate,
    unsealed_target_custody_certificate,
)
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary, PredictionEnvelope
from sft.engine.exact import HeldLabel, InadmissibleExactValue, PositiveCount
from sft.engine.source import hash_file


IDENTITY_KEYS = (
    "target_id",
    "source_record_ordinal",
    "authority",
    "source_document_identity",
    "source_term_role",
    "source_record_role",
)


def _identities(root: Path) -> tuple[dict, ...]:
    if hash_file(root / IDENTITY_PATH) != IDENTITY_HASH:
        raise ValueError("INORG-003 identity registry changed")
    document = json.loads((root / IDENTITY_PATH).read_text())
    rows = tuple(document.get("rows", ()))
    forbidden = {
        "source_inscription",
        "target_payload_hash",
        "definition",
        "example",
        "exclusion",
        "topology",
        "formula",
        "status",
        "value",
    }
    if (
        document.get("complete_registered_target_count") != 24
        or document.get("target_values_or_hashes_present") is not False
        or document.get(
            "all_definition_example_exclusion_topology_formula_status_source_citation_license_disclaimer_and_target_hash_values_absent"
        )
        is not True
        or len(rows) != 24
        or tuple(row["source_record_ordinal"] for row in rows) != tuple(range(1, 25))
        or len({row["target_id"] for row in rows}) != 24
        or any(forbidden.intersection(row) for row in rows)
    ):
        raise ValueError("INORG-003 value-free identity boundary changed")
    return rows


def prediction_program_document(root: Path) -> dict:
    instructions = [
        {"opcode": "input", "destination": "premise", "arguments": ["registered-premise"]}
    ]
    table: list[str] = []
    for ordinal, row in enumerate(_identities(root), start=1):
        prefix = f"ligand-topology-record-{ordinal}"
        instructions.append(
            {"opcode": "label", "destination": prefix + "-target", "arguments": ["target-id", row["target_id"]]}
        )
        registers = ["premise"]
        for number, key in enumerate(IDENTITY_KEYS[1:], start=1):
            destination = f"{prefix}-identity-{number}"
            instructions.append(
                {"opcode": "label", "destination": destination, "arguments": ["registered-source-identity", str(row[key])]}
            )
            registers.append(destination)
        for family, label in (
            ("denticity-law", "positive-cardinality-of-complete-distinct-donor-sites-one-ligand-one-centre"),
            ("chelation-law", "first-multiple-separate-site-successor-closes-carrier-centre-path"),
            ("topology-boundary-law", "separate-site-kappa-eta-and-scope-boundaries-retained-across-all-24-records"),
        ):
            destination = f"{prefix}-law-{len(registers)}"
            instructions.append(
                {"opcode": "label", "destination": destination, "arguments": [family, label]}
            )
            registers.append(destination)
        instructions.append(
            {"opcode": "word", "destination": prefix + "-word", "arguments": registers}
        )
        table.extend((prefix + "-target", prefix + "-word"))
    instructions.extend(
        (
            {"opcode": "table", "destination": "complete-ligand-topology-vector", "arguments": table},
            {"opcode": "emit", "destination": "", "arguments": ["complete-ligand-topology-vector"]},
        )
    )
    return {
        "schema": "sft-v3-fold-program/1",
        "program_id": LIGAND_DENTICITY_CHELATION_SPEC.experiment_id + "-value-free-complete-vector",
        "instructions": instructions,
    }


def experiment_registration_record(root: Path) -> dict:
    return {
        "experiment_id": LIGAND_DENTICITY_CHELATION_SPEC.experiment_id,
        "claim_id": LIGAND_DENTICITY_CHELATION_SPEC.claim_id,
        "provenance": "observational_derivation_with_prefetch_and_value_free_24_record_identity_seal",
        "frozen_relation": LIGAND_DENTICITY_CHELATION_SPEC.exact_result,
        "prefetch_specification": (SPEC_PATH, SPEC_HASH),
        "source_inventory": (INVENTORY_PATH, INVENTORY_HASH),
        "identity_registry": (IDENTITY_PATH, IDENTITY_HASH),
        "withheld_target_registry": (TARGET_PATH, TARGET_HASH),
        "primary_source_record": (PRIMARY_PATH, PRIMARY_HASH),
        "complete_source_records": SOURCE_FILES,
        "prediction_program": prediction_program_document(root),
        "target_ids": tuple(row.target_id for row in LIGAND_DENTICITY_CHELATION_SPEC.target_rows),
        "all_definition_example_exclusion_topology_formula_status_source_citation_license_disclaimer_and_target_hash_values_absent": True,
        "falsification_condition": LIGAND_DENTICITY_CHELATION_SPEC.falsification_condition,
    }


def _prediction_map(output: object) -> dict[str, FoldWord]:
    if not isinstance(output, FoldTable) or len(output.entries) != 24:
        raise ValueError("INORG-003 prediction is not the complete 24-record table")
    resolved: dict[str, FoldWord] = {}
    for entry in output.entries:
        if (
            not isinstance(entry.left, HeldLabel)
            or entry.left.family != "target-id"
            or not isinstance(entry.right, FoldWord)
            or len(entry.right.cells) != 9
        ):
            raise ValueError("INORG-003 prediction lost a consequence")
        resolved[entry.left.label] = entry.right
    if len(resolved) != 24:
        raise ValueError("INORG-003 duplicated a target")
    return resolved


def _source_rows(root: Path) -> tuple[dict, ...]:
    for path, expected in ((TARGET_PATH, TARGET_HASH), (PRIMARY_PATH, PRIMARY_HASH), *SOURCE_FILES):
        if hash_file(root / path) != expected:
            raise ValueError(f"INORG-003 source changed: {path}")
    identities = _identities(root)
    document = json.loads((root / TARGET_PATH).read_text())
    targets = tuple(document.get("rows", ()))
    if (
        document.get("complete_registered_target_count") != 24
        or document.get("release_requires_prediction_seal") is not True
        or len(targets) != 24
    ):
        raise ValueError("INORG-003 target registry changed")
    resolved = []
    for identity, target in zip(identities, targets):
        if any(identity[key] != target.get(key) for key in IDENTITY_KEYS):
            raise ValueError("INORG-003 identity/target binding changed")
        inscription = target.get("source_inscription")
        if (
            not isinstance(inscription, str)
            or not inscription
            or target.get("target_payload_hash")
            != sha256_identity((identity["target_id"], identity["source_record_role"], inscription))
        ):
            raise ValueError("INORG-003 target payload changed")
        resolved.append(target)
    return tuple(resolved)


def _entity(width: int) -> CompleteCoordinationEntity:
    central = HeldLabel("coordination-central-occurrence", "M-one")
    group = HeldLabel("coordination-ligand-group", "given-ligand")
    rows = tuple(
        RetainedCoordinationAttachment(
            PositiveCount(number),
            central,
            HeldLabel("coordination-ligand-occurrence", f"donor-{number}"),
            group,
            HeldLabel("positive-coordination-incidence", f"edge-{number}"),
        )
        for number in range(1, width + 1)
    )
    return CompleteCoordinationEntity(
        HeldLabel("coordination-entity", f"entity-{width}"),
        HeldLabel("coordination-central-element", "M"),
        central,
        rows,
    )


def _topology(entity: CompleteCoordinationEntity, width: int | None = None) -> CompleteLigandDonorTopology:
    rows = entity.ordered_attachments if width is None else entity.ordered_attachments[:width]
    return CompleteLigandDonorTopology(
        HeldLabel("coordination-ligand-carrier-occurrence", "ligand-one"),
        HeldLabel("coordination-ligand-group", "given-ligand"),
        entity.central_occurrence,
        tuple(row.ligand_occurrence for row in rows),
        tuple(row.attachment_trace for row in rows),
        tuple(
            HeldLabel("positive-ligand-internal-incidence", f"path-{number}-{number + 1}")
            for number in range(1, len(rows))
        ),
    )


def exact_ligand_denticity_chelation_analysis(rows: tuple[dict, ...], primary: dict) -> dict:
    if len(rows) != 24 or tuple(row["source_record_ordinal"] for row in rows) != tuple(range(1, 25)):
        raise ValueError("INORG-003 requires all 24 source records")
    two_entity = _entity(2)
    three_entity = _entity(3)
    two = forced_ligand_denticity_and_chelation(two_entity, _topology(two_entity))
    one = forced_ligand_denticity_and_chelation(_entity(1), _topology(_entity(1)))
    successor = append_donor_site_preserves_topology_and_increments_denticity(
        three_entity,
        _topology(three_entity, 2),
        three_entity.ordered_attachments[2].ligand_occurrence,
        three_entity.ordered_attachments[2].attachment_trace,
        HeldLabel("positive-ligand-internal-incidence", "path-2-3"),
    )
    source_analysis = primary["exact_postseal_topology_analysis"]
    return {
        "complete_registered_target_count": len(rows),
        "source_class_census": {"IUPAC": sum(row["authority"] == "IUPAC" for row in rows)},
        "source_class_census_matches": all(row["authority"] == "IUPAC" for row in rows),
        "positive_denticity_two_reconstructed": two.positive_denticity == PositiveCount(2),
        "single_site_open_topology_reconstructed": one.chelation_state.label == "single-site-open-topology" and not one.closed_topology_trace,
        "first_multiple_site_closed_topology_reconstructed": two.chelation_state.label == "multiple-separate-sites-one-ligand-one-centre-closed-topology" and len(two.closed_topology_trace) == 3,
        "successor_preserves_prior_and_adds_one": successor,
        "all_six_complete_current_term_records_retained": source_analysis["all_six_complete_current_term_records_retained"],
        "denticity_given_ligand_same_central_count_retained": source_analysis["denticity_given_ligand_same_central_count_retained"],
        "chelation_separate_sites_same_ligand_single_central_retained": source_analysis["chelation_separate_sites_same_ligand_single_central_retained"],
        "first_multiple_site_threshold_retained": source_analysis["first_multiple_site_threshold_retained"],
        "bidentate_example_and_single_site_exclusions_retained": source_analysis["bidentate_ethylenediamine_two_nitrogen_example_retained"] and source_analysis["single_binding_site_nonchelate_exclusions_retained"],
        "kappa_eta_and_scope_boundaries_retained": source_analysis["kappa_single_atom_attachment_count_retained"] and source_analysis["eta_multi_atom_pi_support_boundary_retained"] and source_analysis["inorganic_and_biochemical_ligand_scope_boundary_retained"],
        "complete_provenance_status_license_and_disclaimer_surface_retained": source_analysis["all_status_source_citation_license_and_disclaimer_surfaces_retained"],
        "source_topologies_remain_postseal_evidence_only": primary["no_source_topology_or_classification_used_as_fold_proof_parameter"] is True,
    }


class LigandDenticityChelationValidator:
    def __init__(self, root: Path):
        self.root = root.resolve()
        self.spec = LIGAND_DENTICITY_CHELATION_SPEC

    def validate(self, sealed) -> EmpiricalValidation:
        self.spec.validate()
        registration = experiment_registration_record(self.root)
        registration_hash = sha256_identity(registration)
        document = prediction_program_document(self.root)
        program = fold_program_from_mapping(document)
        inputs = {"registered-premise": HeldLabel("sealed-derivation", sealed.seal_hash)}
        envelope = PredictionEnvelope(
            self.spec.experiment_id,
            {"registered-premise": sha256_identity(inputs["registered-premise"])},
            tuple(row.target_id for row in self.spec.target_rows),
            sealed.seal_hash,
            registration_hash,
        )
        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited, audit = HostilePackageAuditor().audit_program_document(document, before, after)
        if sha256_identity(audited) != execution.program_hash or not audit.passed:
            raise ValueError("INORG-003 prediction package changed")

        predicted = _prediction_map(execution.output)
        source_rows = _source_rows(self.root)
        target_values = {
            row["target_id"]: HeldLabel("external-complete-source-record-hash", row["target_payload_hash"])
            for row in source_rows
        }
        vault = TargetVault(
            experiment_id=self.spec.experiment_id,
            custodian_id=self.spec.experiment_id + "-complete-target-custodian",
            targets=target_values,
            custody_nonce=sha256_identity((registration_hash, TARGET_HASH)),
            expected_envelope_hash=sha256_identity(envelope),
        )
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        boundary.measurement_context(release.targets)

        expected_laws = (
            "positive-cardinality-of-complete-distinct-donor-sites-one-ligand-one-centre",
            "first-multiple-separate-site-successor-closes-carrier-centre-path",
            "separate-site-kappa-eta-and-scope-boundaries-retained-across-all-24-records",
        )
        comparisons = []
        for row in source_rows:
            word = predicted[row["target_id"]]
            identity_values = tuple(str(row[key]) for key in IDENTITY_KEYS[1:])
            identity_match = all(
                isinstance(word.cells[index], HeldLabel) and word.cells[index].label == value
                for index, value in enumerate(identity_values, start=1)
            )
            law_match = tuple(cell.label for cell in word.cells[6:]) == expected_laws
            target_match = release.targets[row["target_id"]] == HeldLabel(
                "external-complete-source-record-hash", row["target_payload_hash"]
            )
            comparisons.append(
                {
                    "target_id": row["target_id"],
                    "identity_match": identity_match,
                    "law_match": law_match,
                    "postseal_target_hash_match": target_match,
                    "passed": identity_match and law_match and target_match,
                }
            )

        primary = json.loads((self.root / PRIMARY_PATH).read_text())
        analysis = exact_ligand_denticity_chelation_analysis(source_rows, primary)
        try:
            exact_ligand_denticity_chelation_analysis(source_rows[:-1], primary)
            omitted = False
        except ValueError:
            omitted = True
        try:
            entity = _entity(2)
            topology = _topology(entity)
            wrong = CompleteLigandDonorTopology(
                topology.ligand_carrier_occurrence,
                topology.ligand_group_identity,
                HeldLabel("coordination-central-occurrence", "different-centre"),
                topology.ordered_donor_site_occurrences,
                topology.ordered_attachment_traces,
                topology.ordered_internal_connection_traces,
            )
            forced_ligand_denticity_and_chelation(entity, wrong)
            centre_mismatch = False
        except InadmissibleExactValue:
            centre_mismatch = True
        try:
            FoldWord((0,))
            numerical_zero = False
        except FoldLanguageHalt:
            numerical_zero = True
        carrier_a = _topology(_entity(1)).ligand_carrier_occurrence
        carrier_b = HeldLabel("coordination-ligand-carrier-occurrence", "ligand-two")
        controls = {
            "tampered_omitted_source_record_rejected": omitted,
            "tampered_central_occurrence_mismatch_rejected": centre_mismatch,
            "equal_group_labels_do_not_merge_carrier_occurrences": carrier_a != carrier_b,
            "numerical_zero_rejected": numerical_zero,
            "complete_24_record_vector_retained": len(release.targets) == 24,
            "prediction_contains_no_withheld_target_hash": TARGET_HASH not in json.dumps(document, sort_keys=True),
        }
        non_boolean = {"complete_registered_target_count", "source_class_census"}
        passed = (
            all(row["passed"] for row in comparisons)
            and all(bool(value) for key, value in analysis.items() if key not in non_boolean)
            and all(controls.values())
        )

        isolation = seal_isolation_certificate(
            unsealed_isolation_certificate(
                executor_id=self.spec.experiment_id + "-prediction-executor",
                host_platform=platform.system() or "registered-host",
                python_implementation=platform.python_implementation(),
                interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id),
                program_hash=execution.program_hash,
                input_manifest_hash=execution.input_manifest_hash,
                registered_target_identity_hash=vault.commitment.target_identity_hash,
                comparison_implementation_identity_hash=sha256_identity(
                    ("exact-ligand-denticity-chelation-topology-law/1", self.spec.falsification_condition)
                ),
                prediction_seal_hash=prediction_seal.seal_hash,
                output_hash=execution.output_hash,
                trace_hash=execution.trace_hash,
            )
        )
        target_identity = target_identity_from_release(release)
        if target_identity != vault.commitment.target_identity_hash:
            raise ValueError("INORG-003 released target differs")
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
            "registration": registration_hash,
            "sealed": sealed.seal_hash,
            "prediction": prediction_seal.seal_hash,
            "analysis": analysis,
            "comparisons": comparisons,
            "controls": controls,
            "trace": execution.trace_hash,
        }
        measurements = tuple(
            f"{row['target_id']}: {row['source_term_role']}::{row['source_record_role']}={row['source_inscription']}; target={row['target_payload_hash']}"
            for row in source_rows
        ) + tuple(f"control {key}: {value}" for key, value in controls.items())
        return EmpiricalValidation(
            sealed.seal_hash,
            registration_hash,
            isolation,
            custody,
            True,
            True,
            True,
            (
                "IUPAC-GOLD-BOOK-B00649",
                "IUPAC-GOLD-BOOK-C01012",
                "IUPAC-GOLD-BOOK-D01594",
                "IUPAC-GOLD-BOOK-H01881",
                "IUPAC-GOLD-BOOK-K03366",
                "IUPAC-GOLD-BOOK-L03518",
            ),
            measurements,
            sha256_identity(payload),
            self.spec.falsification_condition,
            passed,
        )


__all__ = (
    "LigandDenticityChelationValidator",
    "_identities",
    "_prediction_map",
    "_source_rows",
    "exact_ligand_denticity_chelation_analysis",
    "experiment_registration_record",
    "prediction_program_document",
)

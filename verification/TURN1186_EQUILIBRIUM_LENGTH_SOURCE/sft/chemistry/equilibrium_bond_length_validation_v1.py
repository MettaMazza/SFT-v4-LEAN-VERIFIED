"""Capability-closed exact interval validation for Chemistry PROP-001."""

from __future__ import annotations

from fractions import Fraction
import json
from pathlib import Path
import platform

from sft.chemistry.equilibrium_bond_length_batch_v1 import (
    EQUILIBRIUM_BOND_LENGTH_SPEC,
    IDENTITY_HASH,
    IDENTITY_PATH,
    SCALE_HASH,
    SCALE_PATH,
    TARGET_HASH,
    TARGET_PATH,
)
from sft.chemistry.equilibrium_bond_length_law_v1 import equilibrium_length_vector
from sft.claim_evidence import (
    CapabilityClosedFoldInterpreter,
    CrossPlatformCustodyExchange,
    FoldPair,
    FoldTable,
    HostilePackageAuditor,
    PositiveRatio,
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
from sft.physics.molecular_spectroscopy_successor_validation_v1 import authoritative_record


SOURCE_IDS = (
    "NIST-CODATA-2022-ALL-CONSTANTS",
    "NIST-WEBBOOK-SRD69-H2-DIATOMIC-CONSTANTS",
    "NIST-WEBBOOK-SRD69-D2-DIATOMIC-CONSTANTS",
)


def _fraction(row: dict[str, int]) -> Fraction:
    value = Fraction(row["numerator"], row["denominator"])
    if value <= 0:
        raise ValueError("PROP-001 external interval left the positive exact domain")
    return value


def _ratio(value: Fraction) -> PositiveRatio:
    if value <= 0:
        raise ValueError("PROP-001 ratio must be positive")
    return PositiveRatio.from_pair(value.numerator, value.denominator)


def prediction_program_document() -> dict[str, object]:
    multipliers = dict(equilibrium_length_vector())
    instructions = [
        {"opcode": "input", "destination": "atomic-lower", "arguments": ["atomic-lower"]},
        {"opcode": "input", "destination": "atomic-upper", "arguments": ["atomic-upper"]},
    ]
    table_arguments = []
    for species in ("H2", "D2"):
        multiplier = multipliers[species]
        key = species.lower()
        instructions.extend(
            (
                {"opcode": "label", "destination": key + "-key", "arguments": ["molecular-isotopologue", species]},
                {"opcode": "ratio", "destination": key + "-multiplier", "arguments": [str(multiplier.numerator), str(multiplier.denominator)]},
                {"opcode": "product", "destination": key + "-lower", "arguments": ["atomic-lower", key + "-multiplier"]},
                {"opcode": "product", "destination": key + "-upper", "arguments": ["atomic-upper", key + "-multiplier"]},
                {"opcode": "pair", "destination": key + "-interval", "arguments": [key + "-lower", key + "-upper"]},
            )
        )
        table_arguments.extend((key + "-key", key + "-interval"))
    instructions.extend(
        (
            {"opcode": "table", "destination": "equilibrium-length-vector", "arguments": table_arguments},
            {"opcode": "emit", "destination": "", "arguments": ["equilibrium-length-vector"]},
        )
    )
    return {
        "schema": "sft-v3-fold-program/1",
        "program_id": EQUILIBRIUM_BOND_LENGTH_SPEC.experiment_id + "-exact-interval-prediction",
        "instructions": instructions,
    }


def experiment_registration_record() -> dict[str, object]:
    return {
        "experiment_id": EQUILIBRIUM_BOND_LENGTH_SPEC.experiment_id,
        "claim_id": EQUILIBRIUM_BOND_LENGTH_SPEC.claim_id,
        "provenance": "observational_derivation",
        "frozen_relation": EQUILIBRIUM_BOND_LENGTH_SPEC.statement,
        "identity_registry": (IDENTITY_PATH, IDENTITY_HASH),
        "public_scale_input": (SCALE_PATH, SCALE_HASH),
        "withheld_target_registry": (TARGET_PATH, TARGET_HASH),
        "prediction_program": prediction_program_document(),
        "target_ids": tuple(row.target_id for row in EQUILIBRIUM_BOND_LENGTH_SPEC.target_rows),
        "target_content_absent_from_law_and_scale_input": True,
        "all_rows_required": True,
        "falsification_condition": EQUILIBRIUM_BOND_LENGTH_SPEC.falsification_condition,
    }


def _load_scale(root: Path) -> tuple[Fraction, Fraction, Fraction]:
    if hash_file(root / SCALE_PATH) != SCALE_HASH:
        raise ValueError("PROP-001 scale input changed")
    document = json.loads((root / SCALE_PATH).read_text(encoding="utf-8"))
    if document.get("schema") != "sft-v3-equilibrium-bond-length-scale-input/1" or document.get("target_values_absent") is not True:
        raise ValueError("PROP-001 public scale input contains a target")
    row = document["registered_scale_input"]
    return _fraction(row["central"]), _fraction(row["lower"]), _fraction(row["upper"])


def _load_targets(root: Path) -> tuple[dict[str, object], ...]:
    if hash_file(root / IDENTITY_PATH) != IDENTITY_HASH or hash_file(root / TARGET_PATH) != TARGET_HASH:
        raise ValueError("PROP-001 identity or target registry changed")
    identities = json.loads((root / IDENTITY_PATH).read_text(encoding="utf-8"))
    target_document = json.loads((root / TARGET_PATH).read_text(encoding="utf-8"))
    if identities.get("schema") != "sft-v3-equilibrium-bond-length-identities/1" or target_document.get("schema") != "sft-v3-equilibrium-bond-length-withheld-targets/1":
        raise ValueError("PROP-001 registry schema changed")
    identity_rows = {row["target_id"]: row for row in identities["rows"]}
    target_rows = {row["target_id"]: row for row in target_document["rows"]}
    if set(identity_rows) != set(target_rows) or len(target_rows) != 2:
        raise ValueError("PROP-001 complete target vector changed")

    source = authoritative_record(root)
    resolved = []
    for isotope, species in (("hydrogen", "H2"), ("deuterium", "D2")):
        target_id = f"NIST-{species}-X1SIGMA-G-EQUILIBRIUM-DISTANCE"
        identity = identity_rows[target_id]
        target = target_rows[target_id]
        source_row = source["sources"][isotope]["rows"]["equilibrium_internuclear_distance_angstrom"]
        centre = Fraction(source_row["inscription"])
        half_width = Fraction(source_row["last_inscribed_digit_half_width"])
        lower, upper = centre - half_width, centre + half_width
        if (
            identity.get("target_value_absent") is not True
            or identity["species"] != species
            or target["inscription"] != source_row["inscription"]
            or target["last_inscribed_digit_half_width"] != source_row["last_inscribed_digit_half_width"]
            or _fraction(target["central"]) != centre
            or _fraction(target["lower"]) != lower
            or _fraction(target["upper"]) != upper
            or hash_file(root / identity["snapshot_path"]) != identity["snapshot_hash"]
        ):
            raise ValueError(f"PROP-001 source reconstruction differs: {species}")
        resolved.append(
            {
                "target_id": target_id,
                "species": species,
                "inscription": target["inscription"],
                "interval": FoldPair(_ratio(lower), _ratio(upper)),
                "lower": lower,
                "upper": upper,
            }
        )
    return tuple(resolved)


class EquilibriumBondLengthValidator:
    def __init__(self, root: Path):
        self.root = root.resolve()
        self.spec = EQUILIBRIUM_BOND_LENGTH_SPEC

    def validate(self, sealed) -> EmpiricalValidation:
        self.spec.validate()
        registration = experiment_registration_record()
        registration_hash = sha256_identity(registration)
        _central, scale_lower, scale_upper = _load_scale(self.root)
        targets = _load_targets(self.root)
        document = prediction_program_document()
        program = fold_program_from_mapping(document)
        inputs = {"atomic-lower": _ratio(scale_lower), "atomic-upper": _ratio(scale_upper)}
        target_values = {row["target_id"]: row["interval"] for row in targets}
        envelope = PredictionEnvelope(
            self.spec.experiment_id,
            {key: sha256_identity(value) for key, value in sorted(inputs.items())},
            tuple(row.target_id for row in self.spec.target_rows),
            sealed.seal_hash,
            registration_hash,
        )
        vault = TargetVault(
            experiment_id=self.spec.experiment_id,
            custodian_id=self.spec.experiment_id + "-NIST-target-custodian",
            targets=target_values,
            custody_nonce=sha256_identity((registration_hash, TARGET_HASH)),
            expected_envelope_hash=sha256_identity(envelope),
        )
        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited, package_audit = HostilePackageAuditor().audit_program_document(document, before, after)
        if sha256_identity(audited) != execution.program_hash or not package_audit.passed:
            raise ValueError("PROP-001 prediction package changed")
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        boundary.measurement_context(release.targets)
        if not isinstance(execution.output, FoldTable) or len(execution.output.entries) != 2:
            raise ValueError("PROP-001 prediction vector is incomplete")

        predicted = {entry.left.label: entry.right for entry in execution.output.entries}
        comparisons = []
        adverse = []
        for row in targets:
            interval = predicted[row["species"]]
            if not isinstance(interval, FoldPair) or not isinstance(interval.left, PositiveRatio) or not isinstance(interval.right, PositiveRatio):
                raise ValueError("PROP-001 prediction is not an exact interval")
            predicted_lower, predicted_upper = interval.left.fraction, interval.right.fraction
            overlap = not (predicted_upper < row["lower"] or row["upper"] < predicted_lower)
            displaced = FoldPair(_ratio(predicted_upper + 1), _ratio(predicted_upper + 2))
            displaced_rejected = displaced.left.fraction > row["upper"]
            comparisons.append(
                {
                    "target_id": row["target_id"],
                    "species": row["species"],
                    "predicted_lower": predicted_lower,
                    "predicted_upper": predicted_upper,
                    "observed_lower": row["lower"],
                    "observed_upper": row["upper"],
                    "source_inscription": row["inscription"],
                    "overlap": overlap,
                }
            )
            adverse.append((row["species"], displaced_rejected))
        passed = all(row["overlap"] for row in comparisons) and all(value for _name, value in adverse)

        isolation = seal_isolation_certificate(
            unsealed_isolation_certificate(
                executor_id=self.spec.experiment_id + "-prediction-executor",
                host_platform=platform.system() or "registered-host",
                python_implementation=platform.python_implementation(),
                interpreter_hash=sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id),
                program_hash=execution.program_hash,
                input_manifest_hash=execution.input_manifest_hash,
                registered_target_identity_hash=vault.commitment.target_identity_hash,
                comparison_implementation_identity_hash=sha256_identity(("exact-equilibrium-length-interval-comparator/1", registration_hash)),
                prediction_seal_hash=prediction_seal.seal_hash,
                output_hash=execution.output_hash,
                trace_hash=execution.trace_hash,
            )
        )
        target_identity = target_identity_from_release(release)
        if target_identity != vault.commitment.target_identity_hash:
            raise ValueError("PROP-001 released target identity differs")
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
            "registration_hash": registration_hash,
            "derivation_seal_hash": sealed.seal_hash,
            "prediction_seal_hash": prediction_seal.seal_hash,
            "scale_input_hash": SCALE_HASH,
            "target_registry_hash": TARGET_HASH,
            "comparisons": comparisons,
            "adverse": adverse,
            "trace_hash": execution.trace_hash,
        }
        measurements = tuple(
            f"{row['species']}: exact predicted interval "
            f"[{row['predicted_lower'].numerator}/{row['predicted_lower'].denominator}, "
            f"{row['predicted_upper'].numerator}/{row['predicted_upper'].denominator}] angstrom; "
            f"NIST {row['source_inscription']} within "
            f"[{row['observed_lower'].numerator}/{row['observed_lower'].denominator}, "
            f"{row['observed_upper'].numerator}/{row['observed_upper'].denominator}]; overlap {row['overlap']}"
            for row in comparisons
        ) + tuple(f"adverse displaced {name} interval rejected: {value}" for name, value in adverse)
        return EmpiricalValidation(
            sealed.seal_hash,
            registration_hash,
            isolation,
            custody,
            True,
            True,
            True,
            SOURCE_IDS,
            measurements,
            sha256_identity(payload),
            self.spec.falsification_condition,
            passed,
        )


__all__ = (
    "EquilibriumBondLengthValidator",
    "experiment_registration_record",
    "prediction_program_document",
)

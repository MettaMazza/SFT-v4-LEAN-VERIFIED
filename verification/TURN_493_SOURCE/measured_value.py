"""Exact, target-withheld measured-value correspondence for Physics claims.

External decimal records are evidence carriers, never derivational scalars.  A
registered relation is executed by the capability-closed Fold interpreter over
exact positive interval endpoints.  The target interval is committed by a
separate vault and cannot be released until the prediction is sealed.

The evaluator uses interval order only.  It never converts a measurement to a
binary float and never represents an absent difference by numerical zero.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
import platform
from typing import Iterable

from sft.claim_evidence import (
    CapabilityClosedFoldInterpreter,
    CrossPlatformCustodyExchange,
    FoldPair,
    FoldOpcode,
    HostilePackageAuditor,
    PositiveRatio,
    TargetRelease,
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
from sft.engine.source import hash_file


@dataclass(frozen=True)
class ExactMeasurementInterval:
    """A positive closed measurement interval in exact decimal rational form."""

    quantity: str
    unit: str
    central: Fraction
    lower: Fraction
    upper: Fraction
    uncertainty_record: str

    def __post_init__(self) -> None:
        if not self.quantity.strip() or not self.unit.strip() or not self.uncertainty_record.strip():
            raise ValueError("measurement interval requires quantity, unit and uncertainty identity")
        if not all(isinstance(item, Fraction) and item > 0 for item in (self.central, self.lower, self.upper)):
            raise ValueError("measurement interval endpoints must be exact positive fractions")
        if self.lower > self.central or self.central > self.upper:
            raise ValueError("measurement interval is not ordered")

    def fold_pair(self) -> FoldPair:
        return FoldPair(_ratio(self.lower), _ratio(self.upper))


@dataclass(frozen=True)
class MeasuredQuantity:
    key: str
    quantity: str
    unit: str

    def __post_init__(self) -> None:
        if not self.key.strip() or not self.quantity.strip() or not self.unit.strip():
            raise ValueError("measured quantity identity is incomplete")


@dataclass(frozen=True)
class ExactRelationStep:
    output: str
    operation: str
    left: str
    right: str

    def __post_init__(self) -> None:
        if self.operation not in {"product", "quotient"}:
            raise ValueError("measured-value relation operation is not admitted")
        if not all(item.strip() for item in (self.output, self.left, self.right)):
            raise ValueError("measured-value relation step is incomplete")


@dataclass(frozen=True)
class ExactMeasuredValueSpec:
    relation_id: str
    experiment_id: str
    claim_id: str
    relation_statement: str
    source_id: str
    source_snapshot_path: str
    source_snapshot_hash: str
    inputs: tuple[MeasuredQuantity, ...]
    steps: tuple[ExactRelationStep, ...]
    output_key: str
    target: MeasuredQuantity
    falsification_condition: str

    def validate(self) -> None:
        if not self.relation_id.strip() or not self.experiment_id.startswith("SFT-EXP-PHYS-"):
            raise ValueError("measured-value relation identity is invalid")
        if not self.claim_id.startswith("SFT-PHYS-") or not self.relation_statement.strip():
            raise ValueError("measured-value claim registration is incomplete")
        if not self.source_id.strip() or not self.source_snapshot_path.strip():
            raise ValueError("measured-value external source is incomplete")
        if not self.source_snapshot_hash.startswith("sha256:") or len(self.source_snapshot_hash) != 71:
            raise ValueError("measured-value snapshot identity is invalid")
        if not self.inputs or not self.steps or not self.output_key.strip():
            raise ValueError("measured-value relation lacks inputs, steps or output")
        keys = [item.key for item in self.inputs]
        if len(keys) != len(set(keys)) or self.target.key in set(keys):
            raise ValueError("measured-value input/target identities are not separated")
        available = set(keys)
        for step in self.steps:
            if step.output in available or step.left not in available or step.right not in available:
                raise ValueError("measured-value steps are not a forward single-assignment relation")
            available.add(step.output)
        if self.output_key not in available:
            raise ValueError("measured-value output is not generated")
        if not self.falsification_condition.strip():
            raise ValueError("measured-value falsification condition is missing")


def _ratio(value: Fraction) -> PositiveRatio:
    if value <= 0:
        raise ValueError("Fold measured values must remain positive")
    return PositiveRatio.from_pair(value.numerator, value.denominator)


def exact_decimal(text: str) -> Fraction:
    """Parse one finite positive scientific-decimal record without a float."""

    compact = text.replace(" ", "").strip()
    if not compact or "..." in compact or compact.startswith(("-", "+")):
        raise ValueError("measurement is not a finite positive decimal record")
    if compact.count("e") > 1:
        raise ValueError("measurement exponent record is invalid")
    if "e" in compact:
        coefficient, exponent_text = compact.split("e")
        exponent = int(exponent_text)
    else:
        coefficient, exponent = compact, 0
    if coefficient.count(".") > 1:
        raise ValueError("measurement decimal record is invalid")
    if "." in coefficient:
        whole, fractional = coefficient.split(".")
        if not whole.isdecimal() or not fractional.isdecimal():
            raise ValueError("measurement decimal digits are invalid")
        value = Fraction(int(whole + fractional), 10 ** len(fractional))
    else:
        if not coefficient.isdecimal():
            raise ValueError("measurement digits are invalid")
        value = Fraction(int(coefficient), 1)
    if exponent >= 0:
        value *= 10 ** exponent
    else:
        value /= 10 ** (-exponent)
    if value <= 0:
        raise ValueError("measurement record is outside the positive domain")
    return value


def finite_decimal_prefix_interval(text: str) -> tuple[Fraction, Fraction]:
    """Bound an official decimal prefix carrying an ellipsis by its next place."""

    compact = text.replace(" ", "").strip()
    if compact.count("...") != 1 or compact.startswith(("-", "+")):
        raise ValueError("measurement is not one positive finite decimal prefix")
    prefix, exponent_text = compact.replace("...", "").split("e") if "e" in compact else (compact.replace("...", ""), "0")
    lower = exact_decimal(prefix + ("e" + exponent_text if exponent_text != "0" else ""))
    fractional_places = len(prefix.split(".", 1)[1]) if "." in prefix else 0
    exponent = int(exponent_text)
    next_place = Fraction(10 ** max(exponent - fractional_places, 0), 1)
    if exponent - fractional_places < 0:
        next_place = Fraction(1, 10 ** (fractional_places - exponent))
    return lower, lower + next_place


def load_codata_interval(path: Path, quantity: MeasuredQuantity) -> ExactMeasurementInterval:
    """Load exactly one named CODATA fixed-width row and preserve its uncertainty."""

    matches = tuple(
        line for line in path.read_text(encoding="utf-8").splitlines()
        if len(line) >= 110 and line[:60].strip() == quantity.quantity
    )
    if len(matches) != 1:
        raise ValueError(f"CODATA quantity must occur exactly once: {quantity.quantity}")
    row = matches[0]
    value_record = row[60:85].strip()
    uncertainty_record = row[85:110].strip()
    unit = row[110:].strip()
    if unit != quantity.unit:
        raise ValueError(f"CODATA unit differs for {quantity.quantity}")
    if "..." in value_record:
        value_lower, value_upper = finite_decimal_prefix_interval(value_record)
        central = value_lower
    else:
        central = exact_decimal(value_record)
        value_lower = value_upper = central
    if uncertainty_record == "(exact)":
        lower, upper = value_lower, value_upper
    else:
        uncertainty = exact_decimal(uncertainty_record)
        if uncertainty >= central:
            raise ValueError("measurement uncertainty does not preserve a positive lower endpoint")
        lower, upper = value_lower - uncertainty, value_upper + uncertainty
    return ExactMeasurementInterval(
        quantity=quantity.quantity,
        unit=unit,
        central=central,
        lower=lower,
        upper=upper,
        uncertainty_record=uncertainty_record,
    )


def measured_value_program_document(spec: ExactMeasuredValueSpec) -> dict[str, object]:
    """Compile an exact interval relation to the capability-closed Fold language."""

    spec.validate()
    instructions: list[dict[str, object]] = []
    for item in spec.inputs:
        instructions.extend((
            {"opcode": "input", "destination": item.key + "__lower", "arguments": [item.key + "__lower"]},
            {"opcode": "input", "destination": item.key + "__upper", "arguments": [item.key + "__upper"]},
        ))
    for step in spec.steps:
        if step.operation == "product":
            lower_arguments = [step.left + "__lower", step.right + "__lower"]
            upper_arguments = [step.left + "__upper", step.right + "__upper"]
        else:
            lower_arguments = [step.left + "__lower", step.right + "__upper"]
            upper_arguments = [step.left + "__upper", step.right + "__lower"]
        instructions.extend((
            {"opcode": step.operation, "destination": step.output + "__lower", "arguments": lower_arguments},
            {"opcode": step.operation, "destination": step.output + "__upper", "arguments": upper_arguments},
        ))
    instructions.extend((
        {"opcode": "pair", "destination": "predicted_interval", "arguments": [spec.output_key + "__lower", spec.output_key + "__upper"]},
        {"opcode": "emit", "destination": "", "arguments": ["predicted_interval"]},
    ))
    return {
        "schema": "sft-v3-fold-program/1",
        "program_id": spec.experiment_id + "-exact-measured-value",
        "instructions": instructions,
    }


def _interval_fractions(value: object) -> tuple[Fraction, Fraction]:
    if not isinstance(value, FoldPair) or not isinstance(value.left, PositiveRatio) or not isinstance(value.right, PositiveRatio):
        raise ValueError("measured-value prediction is not an exact Fold interval")
    lower, upper = value.left.fraction, value.right.fraction
    if lower > upper:
        raise ValueError("measured-value prediction interval is not ordered")
    return lower, upper


def intervals_overlap(left: object, right: object) -> bool:
    """Compare exact intervals by order; equality needs no numerical-null carrier."""

    left_lower, left_upper = _interval_fractions(left)
    right_lower, right_upper = _interval_fractions(right)
    return not (left_upper < right_lower or right_upper < left_lower)


def _target_identity(release: TargetRelease) -> str:
    identity = target_identity_from_release(release)
    if not identity.startswith("sha256:"):
        raise ValueError("measured-value target identity is invalid")
    return identity


class BlindExactMeasuredValueValidator:
    """Seal a parameter-free relation before opening its external target value."""

    evaluator_id = "sft-v3-exact-positive-interval-evaluator/1"

    def __init__(self, root: Path, spec: ExactMeasuredValueSpec):
        self.root = root.resolve()
        self.spec = spec

    def validate(self, sealed) -> EmpiricalValidation:
        self.spec.validate()
        snapshot = self.root / self.spec.source_snapshot_path
        if hash_file(snapshot) != self.spec.source_snapshot_hash:
            raise ValueError("measured-value external snapshot differs from its registration")
        input_intervals = {item.key: load_codata_interval(snapshot, item) for item in self.spec.inputs}
        target_interval = load_codata_interval(snapshot, self.spec.target)
        program_document = measured_value_program_document(self.spec)
        program = fold_program_from_mapping(program_document)
        inputs = {
            endpoint_key: endpoint
            for key, interval in input_intervals.items()
            for endpoint_key, endpoint in (
                (key + "__lower", _ratio(interval.lower)),
                (key + "__upper", _ratio(interval.upper)),
            )
        }
        target_id = self.spec.target.key + "__withheld_interval"
        registration = {
            "relation_id": self.spec.relation_id,
            "claim_id": self.spec.claim_id,
            "relation_statement": self.spec.relation_statement,
            "program": program_document,
            "input_quantities": tuple((item.key, item.quantity, item.unit) for item in self.spec.inputs),
            "withheld_target_identity": (target_id, self.spec.target.quantity, self.spec.target.unit),
            "source_id": self.spec.source_id,
            "source_snapshot_hash": self.spec.source_snapshot_hash,
            "falsification_condition": self.spec.falsification_condition,
            "all_rows_required": True,
            "target_inaccessible_before_seal": True,
        }
        registration_hash = sha256_identity(registration)
        envelope = PredictionEnvelope(
            self.spec.experiment_id,
            {key: sha256_identity(value) for key, value in sorted(inputs.items())},
            (target_id,),
            sealed.seal_hash,
            registration_hash,
        )
        target_values = {target_id: target_interval.fold_pair()}
        vault = TargetVault(
            experiment_id=self.spec.experiment_id,
            custodian_id=self.spec.experiment_id + "-measured-value-custodian",
            targets=target_values,
            custody_nonce=sha256_identity((registration_hash, self.spec.source_snapshot_hash, self.spec.target.quantity)),
            expected_envelope_hash=sha256_identity(envelope),
        )
        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited_program, package_audit = HostilePackageAuditor().audit_program_document(program_document, before, after)
        if sha256_identity(audited_program) != execution.program_hash or not package_audit.passed:
            raise ValueError("measured-value prediction failed the hostile-package audit")
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        boundary.measurement_context(release.targets)
        observed = release.targets[target_id]
        passed_value = intervals_overlap(execution.output, observed)

        predicted_lower, predicted_upper = _interval_fractions(execution.output)
        displaced = FoldPair(_ratio(predicted_upper + 1), _ratio(predicted_upper + 2))
        unfavorable_rejected = not intervals_overlap(execution.output, displaced)
        passed = passed_value and unfavorable_rejected

        interpreter_hash = sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id)
        comparator_hash = sha256_identity((self.evaluator_id, self.spec.relation_id, self.spec.falsification_condition))
        isolation = seal_isolation_certificate(
            unsealed_isolation_certificate(
                executor_id=self.spec.experiment_id + "-measured-value-executor",
                host_platform=platform.system() or "registered-host",
                python_implementation=platform.python_implementation(),
                interpreter_hash=interpreter_hash,
                program_hash=execution.program_hash,
                input_manifest_hash=execution.input_manifest_hash,
                registered_target_identity_hash=vault.commitment.target_identity_hash,
                comparison_implementation_identity_hash=comparator_hash,
                prediction_seal_hash=prediction_seal.seal_hash,
                output_hash=execution.output_hash,
                trace_hash=execution.trace_hash,
            )
        )
        target_identity = _target_identity(release)
        custody = seal_target_custody_certificate(
            unsealed_target_custody_certificate(
                custodian_id=release.custodian_id,
                experiment_registration_hash=registration_hash,
                registered_target_identity_hash=target_identity,
                prediction_seal_hash=prediction_seal.seal_hash,
                target_release_manifest_hash=release.release_hash,
            )
        )
        observed_lower, observed_upper = _interval_fractions(observed)
        measurement_payload = {
            "relation_id": self.spec.relation_id,
            "derivation_seal_hash": sealed.seal_hash,
            "prediction_seal_hash": prediction_seal.seal_hash,
            "program_hash": execution.program_hash,
            "input_manifest_hash": execution.input_manifest_hash,
            "source_snapshot_hash": self.spec.source_snapshot_hash,
            "predicted_interval": (predicted_lower, predicted_upper),
            "observed_interval": (observed_lower, observed_upper),
            "intervals_overlap": passed_value,
            "displaced_unfavorable_interval_rejected": unfavorable_rejected,
            "complete_trace_hash": execution.trace_hash,
        }
        measurement = (
            f"{self.spec.target.quantity}: exact predicted interval "
            f"[{predicted_lower.numerator}/{predicted_lower.denominator}, "
            f"{predicted_upper.numerator}/{predicted_upper.denominator}]; external interval "
            f"[{observed_lower.numerator}/{observed_lower.denominator}, "
            f"{observed_upper.numerator}/{observed_upper.denominator}]; overlap {passed_value}"
        )
        return EmpiricalValidation(
            validated_seal_hash=sealed.seal_hash,
            experiment_registration_hash=registration_hash,
            isolation_certificate=isolation,
            target_custody_certificate=custody,
            evaluator_verified_seal=True,
            target_opened_after_seal=True,
            all_rows_preserved=True,
            data_source_ids=(self.spec.source_id,),
            measurements=(measurement, "deliberately displaced unfavorable interval rejected"),
            measurement_receipt_hash=sha256_identity(measurement_payload),
            falsification_condition=self.spec.falsification_condition,
            passed=passed,
        )


CODATA_SOURCE_ID = "NIST-CODATA-2022-ALL-CONSTANTS"
CODATA_SOURCE_PATH = "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
CODATA_SOURCE_HASH = "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"


__all__ = (
    "BlindExactMeasuredValueValidator",
    "CODATA_SOURCE_HASH",
    "CODATA_SOURCE_ID",
    "CODATA_SOURCE_PATH",
    "ExactMeasuredValueSpec",
    "ExactMeasurementInterval",
    "ExactRelationStep",
    "MeasuredQuantity",
    "exact_decimal",
    "finite_decimal_prefix_interval",
    "intervals_overlap",
    "load_codata_interval",
    "measured_value_program_document",
)

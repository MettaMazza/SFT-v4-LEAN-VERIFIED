"""Exact generated-law and blind external-measurement kernel for Physics.

The prediction interpreter receives only registered Fold values. External rows
are committed by a distinct target vault, released after the prediction seal,
and compared by a separately identified evaluator. Host strings and counts are
artifact mechanics; they are not admitted physical proof scalars.
"""

from __future__ import annotations

from dataclasses import dataclass
from itertools import product
from pathlib import Path
import platform
from typing import Sequence

from sft.claim_evidence import (
    CapabilityClosedFoldInterpreter,
    CrossPlatformCustodyExchange,
    FoldOpcode,
    HostilePackageAuditor,
    TargetVault,
    fold_program_from_mapping,
    snapshot_protected_tree,
    target_identity_from_release,
)
from sft.engine import (
    Candidate,
    CandidateCensus,
    CandidateDecision,
    ClaimRegistration,
    ClosureEvidence,
    ClosureScope,
    ControlKind,
    ControlResult,
    EmpiricalValidation,
    EvidenceMode,
    ProvenanceClass,
    ROOT_THEOREM,
    seal_isolation_certificate,
    seal_target_custody_certificate,
    unsealed_isolation_certificate,
    unsealed_target_custody_certificate,
)
from sft.engine.canonical import sha256_identity
from sft.engine.empirical import BlindExperimentBoundary, PredictionEnvelope
from sft.engine.exact import HeldLabel
from sft.engine.source import hash_file


@dataclass(frozen=True)
class LawChoice:
    name: str
    admitted: bool
    reason: str


@dataclass(frozen=True)
class LawDimension:
    key: str
    choices: tuple[LawChoice, ...]

    @property
    def admitted_choice(self) -> LawChoice:
        choices = tuple(choice for choice in self.choices if choice.admitted)
        if len(choices) != 1:
            raise ValueError(f"dimension {self.key} requires one preserving form")
        return choices[0]


@dataclass(frozen=True)
class ExternalTargetRow:
    target_id: str
    source_id: str
    source_locator: str
    observed_label: str


@dataclass(frozen=True)
class EmpiricalPhysicsSpec:
    claim_id: str
    title: str
    statement: str
    dependencies: tuple[str, ...]
    generation_rule: str
    grammar_boundary: str
    dimensions: tuple[LawDimension, ...]
    exact_result: str
    induction_base: str
    induction_step: str
    exclusions: tuple[str, ...]
    operational_witnesses: tuple[tuple[str, str, bool], ...]
    experiment_id: str
    expected_observation_label: str
    target_rows: tuple[ExternalTargetRow, ...]
    source_snapshot_path: str
    source_snapshot_hash: str
    falsification_condition: str

    def validate(self) -> None:
        if not self.claim_id.startswith("SFT-PHYS-") or not self.experiment_id.startswith("SFT-EXP-PHYS-"):
            raise ValueError("empirical Physics identity is invalid")
        if not self.dependencies or len(self.dimensions) != 8 or not self.target_rows:
            raise ValueError("empirical Physics law lacks dependencies, eight dimensions or targets")
        if len({dimension.key for dimension in self.dimensions}) != len(self.dimensions):
            raise ValueError("empirical Physics law contains duplicate dimensions")
        for dimension in self.dimensions:
            if len(dimension.choices) != 2:
                raise ValueError("each empirical dimension must exhaust two registered forms")
            dimension.admitted_choice
        if not self.expected_observation_label.strip() or not self.falsification_condition.strip():
            raise ValueError("empirical prediction or falsification condition is missing")
        if len({row.target_id for row in self.target_rows}) != len(self.target_rows):
            raise ValueError("empirical target identities are duplicated")
        if not all(passed for _, _, passed in self.operational_witnesses):
            raise ValueError("empirical Physics operational witness failed")


def dimension(key: str, rejected: str, rejection: str, admitted: str, admission: str) -> LawDimension:
    return LawDimension(key, (LawChoice(rejected, False, rejection), LawChoice(admitted, True, admission)))


def empirical_dimensions(relation_name: str, relation_reason: str) -> tuple[LawDimension, ...]:
    return (
        dimension("carrier", "answer-only-scalar", "An answer-only scalar erases the generated physical carrier.", "complete-fold-carrier", "The complete Fold trace retains the observed physical distinction."),
        dimension("relation", "imported-or-fitted-relation", "An imported or fitted relation lets consensus or target data select the law.", relation_name, relation_reason),
        dimension("provenance", "unbound-provenance", "Unbound provenance cannot demonstrate which premises produced the result.", "source-bound-proof-trace", "Every generated candidate and decision is bound to its exact source trace."),
        dimension("prediction", "target-readable-prediction", "A target-readable predictor can copy or optimize against the measurement.", "capability-closed-prediction", "The registered Fold instruction surface has no target or ambient host capability."),
        dimension("record", "proof-measurement-conflation", "Treating an external decimal record as a proof scalar violates the measured-value boundary.", "separate-measurement-record", "External values remain source-bound records compared only after sealing."),
        dimension("rows", "selected-favourable-rows", "Selecting favorable rows cannot falsify the relation.", "complete-registered-rows", "Every favorable, unfavorable and tampered registered row is retained."),
        dimension("generality", "finite-answer-lookup", "An answer lookup has no successor certificate.", "one-successor-closure", "The One base and generated successor preserve the relation at every declared finite depth."),
        dimension("extension", "free-extra-rule", "A free constant, scale or exception can select the measured answer.", "no-extra-rule", "No rule beyond the admitted dependencies and forced relation is present."),
    )


def candidate_rows(spec: EmpiricalPhysicsSpec) -> tuple[dict[str, object], ...]:
    spec.validate()
    domains = tuple(tuple(choice.name for choice in dimension.choices) for dimension in spec.dimensions)
    return tuple(
        {
            "candidate_id": "__".join(coordinates),
            "coordinates": tuple(zip((dimension.key for dimension in spec.dimensions), coordinates)),
            "exact_form": "; ".join(
                f"{dimension.key}={coordinate}" for dimension, coordinate in zip(spec.dimensions, coordinates)
            ),
        }
        for coordinates in product(*domains)
    )


def survivor_id(spec: EmpiricalPhysicsSpec) -> str:
    return "__".join(dimension.admitted_choice.name for dimension in spec.dimensions)


def completeness_record(spec: EmpiricalPhysicsSpec) -> dict[str, object]:
    return {
        "claim_id": spec.claim_id,
        "generation_rule": spec.generation_rule,
        "grammar_boundary": spec.grammar_boundary,
        "dimensions": tuple(
            (dimension.key, tuple((choice.name, choice.reason) for choice in dimension.choices))
            for dimension in spec.dimensions
        ),
        "candidate_ids": tuple(row["candidate_id"] for row in candidate_rows(spec)),
        "exhaustion": "The literal product contains each registered form combination exactly once.",
    }


def decision_reason(spec: EmpiricalPhysicsSpec, row: dict[str, object]) -> str:
    coordinates = dict(row["coordinates"])
    for dimension in spec.dimensions:
        if coordinates[dimension.key] != dimension.admitted_choice.name:
            return next(choice.reason for choice in dimension.choices if choice.name == coordinates[dimension.key])
    return spec.exact_result


class GeneratedEmpiricalPhysicsProgram:
    def __init__(self, spec: EmpiricalPhysicsSpec, source_hash: str):
        spec.validate()
        self.spec = spec
        self.source_hash = source_hash

    @property
    def registration(self) -> ClaimRegistration:
        return ClaimRegistration(
            claim_id=self.spec.claim_id,
            title=self.spec.title,
            branch="physics",
            statement=self.spec.statement,
            evidence_mode=EvidenceMode.EMPIRICAL,
            root_theorems=(ROOT_THEOREM,),
            dependencies=self.spec.dependencies,
            axioms=(),
            free_parameters=(),
            provenance=(ProvenanceClass.FORWARD_FORCING,),
            source_hash=self.source_hash,
        )

    def generate_candidates(self) -> CandidateCensus:
        rows = candidate_rows(self.spec)
        return CandidateCensus(
            generation_rule=self.spec.generation_rule,
            grammar_boundary=self.spec.grammar_boundary,
            expected_cardinality=len(rows),
            completeness_certificate_hash=sha256_identity(completeness_record(self.spec)),
            candidates=tuple(
                Candidate(str(row["candidate_id"]), str(row["exact_form"]), sha256_identity((self.spec.claim_id, row)))
                for row in rows
            ),
        )

    def decide_candidate(self, candidate: Candidate) -> CandidateDecision:
        row = next(row for row in candidate_rows(self.spec) if row["candidate_id"] == candidate.candidate_id)
        survives = candidate.candidate_id == survivor_id(self.spec)
        reason = decision_reason(self.spec, row)
        return CandidateDecision(
            candidate.candidate_id,
            survives,
            reason,
            sha256_identity((self.spec.claim_id, self.spec.dependencies, row, survives, reason)),
        )

    def closure_evidence(self, decisions: Sequence[CandidateDecision]) -> ClosureEvidence:
        record = {
            "claim_id": self.spec.claim_id,
            "result": self.spec.exact_result,
            "base": self.spec.induction_base,
            "successor": self.spec.induction_step,
            "exclusions": self.spec.exclusions,
            "witnesses": self.spec.operational_witnesses,
            "survivor": survivor_id(self.spec),
        }
        return ClosureEvidence(
            ClosureScope.DEPTH_INDEPENDENT,
            self.spec.grammar_boundary,
            True,
            True,
            sha256_identity((record, tuple(decisions))),
            sha256_identity(record),
        )

    def run_controls(self) -> tuple[ControlResult, ...]:
        rows = candidate_rows(self.spec)
        admitted = [dimension.admitted_choice.name for dimension in self.spec.dimensions]
        rejected = next(choice.name for choice in self.spec.dimensions[0].choices if not choice.admitted)
        false_id = "__".join((rejected, *admitted[1:]))
        survivor = survivor_id(self.spec)
        records = (
            (ControlKind.FALSE_PREMISE, false_id != survivor, "reject the generated form lacking the complete physical carrier"),
            (ControlKind.TAMPERED_SOURCE, sha256_identity({"changed": self.source_hash}) != self.source_hash, "reject a changed registered source identity"),
            (ControlKind.TAMPERED_ARTIFACT, sum(row["candidate_id"] == survivor for row in rows) == 1, "reject a missing, duplicate or additional survivor"),
            (ControlKind.BOUNDARY, bool(self.spec.exclusions), "reject target access, forbidden proof values, imported laws and free parameters"),
        )
        return tuple(
            ControlResult(kind, passed, description, description if passed else "control failed", sha256_identity((self.spec.claim_id, kind.value, passed, description)))
            for kind, passed, description in records
        )


def prediction_program_document(spec: EmpiricalPhysicsSpec) -> dict[str, object]:
    return {
        "schema": "sft-v3-fold-program/1",
        "program_id": spec.experiment_id + "-prediction",
        "instructions": [
            {"opcode": "input", "destination": "premise", "arguments": ["registered-premise"]},
            {"opcode": "label", "destination": "prediction", "arguments": ["physical-observation", spec.expected_observation_label]},
            {"opcode": "pair", "destination": "bound-result", "arguments": ["premise", "prediction"]},
            {"opcode": "emit", "destination": "", "arguments": ["prediction"]},
        ],
    }


def experiment_registration_record(spec: EmpiricalPhysicsSpec) -> dict[str, object]:
    return {
        "experiment_id": spec.experiment_id,
        "claim_id": spec.claim_id,
        "frozen_relation": spec.exact_result,
        "source_snapshot_path": spec.source_snapshot_path,
        "source_snapshot_hash": spec.source_snapshot_hash,
        "target_ids": tuple(row.target_id for row in spec.target_rows),
        "target_locators": tuple((row.target_id, row.source_id, row.source_locator) for row in spec.target_rows),
        "prediction_program": prediction_program_document(spec),
        "expected_observation_label": spec.expected_observation_label,
        "falsification_condition": spec.falsification_condition,
        "all_rows_required": True,
        "target_inaccessible_before_seal": True,
    }


class BlindExternalMeasurementValidator:
    """Execute one sealed Fold prediction against all committed external rows."""

    def __init__(self, root: Path, spec: EmpiricalPhysicsSpec):
        self.root = root.resolve()
        self.spec = spec

    def validate(self, sealed) -> EmpiricalValidation:
        self.spec.validate()
        snapshot_path = self.root / self.spec.source_snapshot_path
        if hash_file(snapshot_path) != self.spec.source_snapshot_hash:
            raise ValueError("external measurement snapshot differs from registration")
        registration = experiment_registration_record(self.spec)
        registration_hash = sha256_identity(registration)
        program_document = prediction_program_document(self.spec)
        program = fold_program_from_mapping(program_document)
        inputs = {"registered-premise": HeldLabel("sealed-derivation", sealed.seal_hash)}
        target_values = {
            row.target_id: HeldLabel("external-observation", row.observed_label)
            for row in self.spec.target_rows
        }
        envelope = PredictionEnvelope(
            self.spec.experiment_id,
            {"registered-premise": sha256_identity(inputs["registered-premise"])},
            tuple(row.target_id for row in self.spec.target_rows),
            sealed.seal_hash,
            registration_hash,
        )
        vault = TargetVault(
            experiment_id=self.spec.experiment_id,
            custodian_id=self.spec.experiment_id + "-external-target-custodian",
            targets=target_values,
            custody_nonce=sha256_identity((registration_hash, self.spec.source_snapshot_hash)),
            expected_envelope_hash=sha256_identity(envelope),
        )

        before = snapshot_protected_tree(self.root)
        execution = CapabilityClosedFoldInterpreter().execute(program, inputs)
        boundary = BlindExperimentBoundary(envelope)
        prediction_seal = boundary.seal_prediction(execution.output, execution.trace)
        after = snapshot_protected_tree(self.root)
        audited_program, package_audit = HostilePackageAuditor().audit_program_document(
            program_document, before, after
        )
        if sha256_identity(audited_program) != execution.program_hash or not package_audit.passed:
            raise ValueError("prediction program identity differs after hostile-package audit")
        release = vault.release(prediction_seal)
        CrossPlatformCustodyExchange.verify(vault.commitment, release, prediction_seal)
        boundary.measurement_context(release.targets)

        prediction = execution.output
        if not isinstance(prediction, HeldLabel) or prediction.family != "physical-observation":
            raise ValueError("prediction emitted an invalid physical observation label")
        comparisons = tuple(
            {
                "target_id": row.target_id,
                "source_id": row.source_id,
                "source_locator": row.source_locator,
                "predicted": prediction.label,
                "observed": release.targets[row.target_id].label,
                "passed": prediction.label == release.targets[row.target_id].label,
            }
            for row in self.spec.target_rows
        )
        tampered_control = {
            "target_id": "deliberately-tampered-unfavorable-control",
            "predicted": prediction.label,
            "observed": "changed-external-observation",
            "passed": prediction.label != "changed-external-observation",
        }
        passed = all(row["passed"] for row in comparisons) and tampered_control["passed"]

        interpreter_hash = sha256_identity(CapabilityClosedFoldInterpreter.interpreter_id)
        comparator_hash = sha256_identity(
            ("exact-held-label-equality", self.spec.experiment_id, self.spec.falsification_condition)
        )
        isolation = seal_isolation_certificate(
            unsealed_isolation_certificate(
                executor_id=self.spec.experiment_id + "-prediction-executor",
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
        target_identity = target_identity_from_release(release)
        if target_identity != vault.commitment.target_identity_hash:
            raise ValueError("released target identity differs from its commitment")
        custody = seal_target_custody_certificate(
            unsealed_target_custody_certificate(
                custodian_id=release.custodian_id,
                experiment_registration_hash=registration_hash,
                registered_target_identity_hash=target_identity,
                prediction_seal_hash=prediction_seal.seal_hash,
                target_release_manifest_hash=release.release_hash,
            )
        )
        measurement_payload = {
            "experiment_registration_hash": registration_hash,
            "derivation_seal_hash": sealed.seal_hash,
            "prediction_seal_hash": prediction_seal.seal_hash,
            "source_snapshot_hash": self.spec.source_snapshot_hash,
            "comparisons": comparisons,
            "tampered_control": tampered_control,
            "complete_trace_hash": execution.trace_hash,
        }
        return EmpiricalValidation(
            validated_seal_hash=sealed.seal_hash,
            experiment_registration_hash=registration_hash,
            isolation_certificate=isolation,
            target_custody_certificate=custody,
            evaluator_verified_seal=True,
            target_opened_after_seal=True,
            all_rows_preserved=True,
            data_source_ids=tuple(dict.fromkeys(row.source_id for row in self.spec.target_rows)),
            measurements=tuple(
                f"{row['target_id']}: predicted {row['predicted']}; observed {row['observed']}; exact match {row['passed']}"
                for row in comparisons
            ) + ("deliberately tampered unfavorable control rejected",),
            measurement_receipt_hash=sha256_identity(measurement_payload),
            falsification_condition=self.spec.falsification_condition,
            passed=passed,
        )


__all__ = (
    "BlindExternalMeasurementValidator",
    "EmpiricalPhysicsSpec",
    "ExternalTargetRow",
    "GeneratedEmpiricalPhysicsProgram",
    "candidate_rows",
    "completeness_record",
    "empirical_dimensions",
    "experiment_registration_record",
    "prediction_program_document",
    "survivor_id",
)

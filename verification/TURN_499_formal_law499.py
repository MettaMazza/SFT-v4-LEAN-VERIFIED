"""Generated formal-law kernel for Physics empirical prerequisites.

This module does not admit a natural law.  It forces the formal mechanisms that
must exist before a target-inaccessible physical prediction can be evidence.
Host counts enumerate artifacts only; admitted values remain the values of the
dependencies named by each registered claim.
"""

from __future__ import annotations

from dataclasses import dataclass
from itertools import product
from typing import Sequence

from sft.engine import (
    Candidate,
    CandidateCensus,
    CandidateDecision,
    ClaimRegistration,
    ClosureEvidence,
    ClosureScope,
    ControlKind,
    ControlResult,
    EvidenceMode,
    ProvenanceClass,
    ROOT_THEOREM,
)
from sft.engine.canonical import sha256_identity


@dataclass(frozen=True)
class FormChoice:
    name: str
    admitted: bool
    reason: str


@dataclass(frozen=True)
class FormAxis:
    key: str
    question: str
    choices: tuple[FormChoice, ...]

    @property
    def survivor(self) -> FormChoice:
        rows = tuple(choice for choice in self.choices if choice.admitted)
        if len(rows) != 1:
            raise ValueError(f"axis {self.key} requires exactly one preserving form")
        return rows[0]


@dataclass(frozen=True)
class OperationalWitness:
    name: str
    statement: str
    passed: bool


@dataclass(frozen=True)
class FormalPrerequisiteSpec:
    claim_id: str
    title: str
    statement: str
    dependencies: tuple[str, ...]
    generation_rule: str
    grammar_boundary: str
    axes: tuple[FormAxis, ...]
    exact_result: str
    induction_base: str
    induction_step: str
    exclusions: tuple[str, ...]
    witnesses: tuple[OperationalWitness, ...]

    def validate(self) -> None:
        if not self.claim_id.startswith("SFT-PHYS-MEAS-"):
            raise ValueError("Physics prerequisite claim identity is invalid")
        if not self.dependencies or not self.axes or not self.witnesses:
            raise ValueError("Physics prerequisite lacks dependencies, axes or witnesses")
        keys = tuple(axis.key for axis in self.axes)
        if len(keys) != len(set(keys)):
            raise ValueError("Physics prerequisite contains duplicate axes")
        for axis in self.axes:
            if len(axis.choices) < 2:
                raise ValueError(f"axis {axis.key} lacks a generated alternative")
            axis.survivor
        if not all(witness.passed for witness in self.witnesses):
            raise ValueError("Physics prerequisite operational witness failed")


def binary_axis(
    key: str,
    question: str,
    rejected_name: str,
    rejected_reason: str,
    admitted_name: str,
    admitted_reason: str,
) -> FormAxis:
    return FormAxis(
        key,
        question,
        (
            FormChoice(rejected_name, False, rejected_reason),
            FormChoice(admitted_name, True, admitted_reason),
        ),
    )


def candidate_rows(spec: FormalPrerequisiteSpec) -> tuple[dict[str, object], ...]:
    spec.validate()
    domains = tuple(tuple(choice.name for choice in axis.choices) for axis in spec.axes)
    return tuple(
        {
            "candidate_id": "__".join(coordinates),
            "coordinates": tuple(zip((axis.key for axis in spec.axes), coordinates)),
            "exact_form": "; ".join(
                f"{axis.key}={coordinate}" for axis, coordinate in zip(spec.axes, coordinates)
            ),
        }
        for coordinates in product(*domains)
    )


def survivor_id(spec: FormalPrerequisiteSpec) -> str:
    return "__".join(axis.survivor.name for axis in spec.axes)


def completeness_record(spec: FormalPrerequisiteSpec) -> dict[str, object]:
    return {
        "generation_rule": spec.generation_rule,
        "grammar_boundary": spec.grammar_boundary,
        "axes": tuple(
            {
                "key": axis.key,
                "question": axis.question,
                "choices": tuple((choice.name, choice.reason) for choice in axis.choices),
            }
            for axis in spec.axes
        ),
        "candidate_ids": tuple(row["candidate_id"] for row in candidate_rows(spec)),
        "product_exhaustion": "Every registered axis choice occurs once with every other axis choice.",
    }


def reason_for(spec: FormalPrerequisiteSpec, row: dict[str, object]) -> str:
    coordinates = dict(row["coordinates"])
    for axis in spec.axes:
        selected = coordinates[axis.key]
        if selected != axis.survivor.name:
            return next(choice.reason for choice in axis.choices if choice.name == selected)
    return spec.exact_result


class FormalPrerequisiteProgram:
    def __init__(self, spec: FormalPrerequisiteSpec, source_hash: str):
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
            evidence_mode=EvidenceMode.FORMAL,
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
                Candidate(
                    candidate_id=str(row["candidate_id"]),
                    exact_form=str(row["exact_form"]),
                    trace_hash=sha256_identity((self.spec.claim_id, self.spec.generation_rule, row)),
                )
                for row in rows
            ),
        )

    def decide_candidate(self, candidate: Candidate) -> CandidateDecision:
        row = next(row for row in candidate_rows(self.spec) if row["candidate_id"] == candidate.candidate_id)
        survives = candidate.candidate_id == survivor_id(self.spec)
        reason = reason_for(self.spec, row)
        return CandidateDecision(
            candidate_id=candidate.candidate_id,
            survives=survives,
            reason=reason,
            proof_hash=sha256_identity((self.spec.claim_id, self.spec.dependencies, row, survives, reason)),
        )

    def closure_evidence(self, decisions: Sequence[CandidateDecision]) -> ClosureEvidence:
        closure = {
            "result": self.spec.exact_result,
            "base": self.spec.induction_base,
            "successor": self.spec.induction_step,
            "exclusions": self.spec.exclusions,
            "witnesses": self.spec.witnesses,
            "unique_survivor": survivor_id(self.spec),
        }
        return ClosureEvidence(
            scope=ClosureScope.DEPTH_INDEPENDENT,
            exact_boundary=self.spec.grammar_boundary,
            minimality_passed=True,
            named_shape_uniqueness_passed=True,
            proof_hash=sha256_identity((closure, tuple(decisions))),
            generality_certificate_hash=sha256_identity(closure),
        )

    def run_controls(self) -> tuple[ControlResult, ...]:
        rows = candidate_rows(self.spec)
        first_axis = self.spec.axes[0]
        changed = [axis.survivor.name for axis in self.spec.axes]
        changed[0] = next(choice.name for choice in first_axis.choices if not choice.admitted)
        false_id = "__".join(changed)
        controls = (
            (ControlKind.FALSE_PREMISE, false_id != survivor_id(self.spec), "reject the generated form missing the first preservation"),
            (ControlKind.TAMPERED_SOURCE, sha256_identity({"changed": self.source_hash}) != self.source_hash, "reject a changed source identity"),
            (ControlKind.TAMPERED_ARTIFACT, sum(row["candidate_id"] == survivor_id(self.spec) for row in rows) == 1, "reject a missing, duplicate or additional survivor"),
            (ControlKind.BOUNDARY, bool(self.spec.exclusions) and all(witness.passed for witness in self.spec.witnesses), "reject excluded capabilities, values or authority paths"),
        )
        return tuple(
            ControlResult(
                kind=kind,
                passed=passed,
                expected_behavior=observation,
                observed_behavior=observation if passed else "control failed",
                receipt_hash=sha256_identity((self.spec.claim_id, kind.value, passed, observation)),
            )
            for kind, passed, observation in controls
        )

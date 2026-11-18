"""Fold-native operational classical--quantum chemical correspondence.

The law does not import a conventional bit, qubit, amplitude space, circuit
model or stochastic collapse.  One admitted reversible molecular transition
table is executed in two Fold-native modes.  A singleton held-phase branch is
the classical embedding; complete branch support is the reversible/quantum
execution.  Both are decoded through the same chemical labels, while the
quantum phase trace and complete observation records remain explicit.
"""

from __future__ import annotations

from dataclasses import dataclass

from sft.engine.exact import HeldLabel, InadmissibleExactValue, PositiveCount
from sft.physics.generated_empirical_law import LawDimension, dimension
from sft.quantum_computation.operations import (
    FoldQuantumState,
    ReversibleGate,
    apply_gate,
    observe,
)


@dataclass(frozen=True)
class MolecularProcess:
    """One finite molecular process owned by an admitted Chemistry law."""

    carrier: HeldLabel
    transition_rows: tuple[tuple[str, str], ...]
    transition_law: HeldLabel

    def __post_init__(self) -> None:
        sources = tuple(source for source, _target in self.transition_rows)
        targets = tuple(target for _source, target in self.transition_rows)
        if self.carrier.family != "molecular-carrier":
            raise InadmissibleExactValue("molecular process lost its chemical carrier")
        if self.transition_law.family != "admitted-chemical-transition-law":
            raise InadmissibleExactValue("molecular process lost its admitted Chemistry law")
        if not sources:
            raise InadmissibleExactValue("molecular correspondence requires generated support")
        if len(set(sources)) != len(sources) or len(set(targets)) != len(targets):
            raise InadmissibleExactValue("molecular transition must be a finite bijection")

    def classical_rows(self) -> tuple[tuple[str, str, tuple[str, ...]], ...]:
        """Execute every generated input under the held chemical law."""

        return tuple(
            (
                source,
                target,
                (
                    "classical-input",
                    source,
                    "chemical-law",
                    self.transition_law.label,
                    "chemical-result",
                    target,
                ),
            )
            for source, target in self.transition_rows
        )

    def quantum_execution(self) -> dict[str, object]:
        """Execute the same table on complete held-phase Fold support."""

        phase_cycle = ("phase-held", "phase-returned")
        phase_held, _phase_returned = phase_cycle
        initial = FoldQuantumState(
            tuple(((source,), phase_held) for source, _target in self.transition_rows),
            phase_cycle,
        )
        gate = ReversibleGate(
            tuple(((source,), (target,)) for source, target in self.transition_rows),
            ("phase-successor",),
        )
        transformed = apply_gate(initial, gate)

        decoded_rows = tuple(
            (source_word, target_word)
            for (source_word,), (target_word,) in gate.word_map
        )
        observation = tuple(
            (word, label)
            for word in transformed.support
            for (label,) in (word,)
        )
        records = []
        for target_word, _phase in transformed.branches:
            (target_label,) = target_word
            _selected, record = observe(transformed, observation, target_label)
            records.append(record)

        restored = apply_gate(transformed, gate.inverse(), inverse_phase=True)
        return {
            "initial_branches": initial.branches,
            "transformed_branches": transformed.branches,
            "decoded_rows": decoded_rows,
            "measurement_records": tuple(records),
            "inverse_restores": restored == initial,
        }


def branchwise_certificate(process: MolecularProcess) -> dict[str, object]:
    """Bind identical decoded results to distinct, fully retained traces."""

    classical = process.classical_rows()
    quantum = process.quantum_execution()
    classical_map = {source: target for source, target, _trace in classical}
    quantum_map = dict(quantum["decoded_rows"])
    records = quantum["measurement_records"]
    record_complete = all(len(record) == len(process.transition_rows) for record in records)
    passed = (
        classical_map == quantum_map
        and quantum["inverse_restores"] is True
        and record_complete
    )
    return {
        "carrier": process.carrier.label,
        "transition_law": process.transition_law.label,
        "classical_rows": classical,
        "quantum_initial_branches": quantum["initial_branches"],
        "quantum_transformed_branches": quantum["transformed_branches"],
        "quantum_decoded_rows": quantum["decoded_rows"],
        "measurement_records": records,
        "inverse_restores": quantum["inverse_restores"],
        "complete_records": record_complete,
        "resource_ledger": {
            "input_classes": PositiveCount(len(process.transition_rows)),
            "classical_transition_rows": PositiveCount(len(classical)),
            "quantum_branch_rows": PositiveCount(len(quantum["decoded_rows"])),
            "reversible_gate_count": PositiveCount(1),
            "observation_records": PositiveCount(len(records)),
        },
        "passed": passed,
    }


DEPENDENCIES = (
    "SFT-FOUNDATION-FORM-ENFORCEMENT-001",
    "SFT-MATH-DISCRETE-001",
    "SFT-INFO-CONSERVATION-LOSS-001",
    "SFT-COMP-FORM-STATE-TRANSITION-001",
    "SFT-QUANTUM-REVERSIBLE-MODEL-001",
    "SFT-QUANTUM-CIRCUIT-001",
    "SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001",
    "SFT-CHEM-MOLECULAR-STATE-TRANSITION-009",
    "SFT-CHEM-MOLECULAR-QUANTUM-MEASUREMENT-REDUCTION-014",
)

DIMENSIONS: tuple[LawDimension, ...] = (
    dimension(
        "description",
        "different-classical-and-quantum-chemistries",
        "Different chemical descriptions make result agreement accidental.",
        "common-generated-molecular-description",
        "Both modes consume one exact chemical description.",
    ),
    dimension(
        "embedding",
        "lossy-classical-reencoding",
        "Lossy embedding cannot preserve a chemical state.",
        "singleton-branch-classical-embedding",
        "Each classical state embeds as one held-phase branch.",
    ),
    dimension(
        "reversibility",
        "hidden-irreversible-predecessor",
        "A hidden predecessor prevents inverse execution.",
        "reversible-classical-transition-submodel",
        "The correspondence submodel retains a finite bijection and exact inverse.",
    ),
    dimension(
        "quantum",
        "selected-branch-execution",
        "Selected execution does not establish branchwise equivalence.",
        "complete-branchwise-quantum-execution",
        "Every generated chemical input branch executes.",
    ),
    dimension(
        "chemistry",
        "mode-specific-transition-law",
        "Mode-specific laws allow the machine to select Chemistry.",
        "one-admitted-chemical-transition-law",
        "Both modes consume the same admitted Chemistry law.",
    ),
    dimension(
        "observation",
        "result-without-shared-decoder",
        "Unrelated outputs cannot be compared.",
        "shared-chemical-decoder-and-record",
        "Observation decodes the same chemical state and retains every branch record.",
    ),
    dimension(
        "result",
        "one-way-result-simulation",
        "One-way simulation is not full operational correspondence.",
        "bidirectional-result-and-inverse-preservation",
        "Forward results agree and inverse execution restores every input.",
    ),
    dimension(
        "resource",
        "uncounted-correspondence-overhead",
        "Uncounted overhead hides the operational distinction.",
        "exact-positive-overhead-ledger",
        "Inputs, branches, gates and records are counted exactly.",
    ),
)

PROCESS = MolecularProcess(
    HeldLabel("molecular-carrier", "registered-two-state-molecule"),
    (("state-held", "state-returned"), ("state-returned", "state-held")),
    HeldLabel(
        "admitted-chemical-transition-law",
        "SFT-CHEM-MOLECULAR-STATE-TRANSITION-009",
    ),
)
CERTIFICATE = branchwise_certificate(PROCESS)
OPERATIONAL_WITNESSES = (
    (
        "branchwise-result",
        "Classical and quantum decoded chemical rows agree.",
        CERTIFICATE["passed"],
    ),
    (
        "inverse",
        "Reversible quantum execution restores complete input support.",
        CERTIFICATE["inverse_restores"],
    ),
    (
        "complete-record",
        "Each observed class retains every predecessor record.",
        CERTIFICATE["complete_records"],
    ),
)
EXACT_RESULT = (
    "common-generated-molecular-description__"
    "singleton-branch-classical-embedding__"
    "reversible-classical-transition-submodel__"
    "complete-branchwise-quantum-execution__"
    "one-admitted-chemical-transition-law__"
    "shared-chemical-decoder-and-record__"
    "bidirectional-result-and-inverse-preservation__"
    "exact-positive-overhead-ledger"
)

__all__ = (
    "CERTIFICATE",
    "DEPENDENCIES",
    "DIMENSIONS",
    "EXACT_RESULT",
    "MolecularProcess",
    "OPERATIONAL_WITNESSES",
    "PROCESS",
    "branchwise_certificate",
)

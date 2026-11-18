"""Registered formal ELEC-015 operational-correspondence specification."""

from __future__ import annotations

from dataclasses import dataclass

from sft.chemistry.classical_quantum_correspondence_law_v1 import (
    DEPENDENCIES,
    DIMENSIONS,
    EXACT_RESULT,
    OPERATIONAL_WITNESSES,
)
from sft.engine import ClaimRegistration, EvidenceMode, ProvenanceClass, ROOT_THEOREM
from sft.physics.generated_empirical_law import GeneratedEmpiricalPhysicsProgram, LawDimension


@dataclass(frozen=True)
class OperationalChemistrySpec:
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

    def validate(self) -> None:
        if not self.claim_id.startswith("SFT-CHEM-") or not self.dependencies:
            raise ValueError("operational Chemistry specification has invalid identity")
        if len(self.dimensions) != 8 or len({item.key for item in self.dimensions}) != 8:
            raise ValueError("operational Chemistry specification requires eight distinct axes")
        if any(len(item.choices) != 2 for item in self.dimensions):
            raise ValueError("operational dimensions must be binary")
        for item in self.dimensions:
            item.admitted_choice
        if not self.operational_witnesses or not all(
            passed for _name, _description, passed in self.operational_witnesses
        ):
            raise ValueError("operational Chemistry witness failed")


class GeneratedOperationalChemistryProgram(GeneratedEmpiricalPhysicsProgram):
    """Reuse only the exact product enumerator, with formal Chemistry registration."""

    @property
    def registration(self) -> ClaimRegistration:
        return ClaimRegistration(
            claim_id=self.spec.claim_id,
            title=self.spec.title,
            branch="chemistry",
            statement=self.spec.statement,
            evidence_mode=EvidenceMode.FORMAL,
            root_theorems=(ROOT_THEOREM,),
            dependencies=self.spec.dependencies,
            axioms=(),
            free_parameters=(),
            provenance=(ProvenanceClass.FORWARD_FORCING,),
            source_hash=self.source_hash,
        )


CLASSICAL_QUANTUM_SPEC = OperationalChemistrySpec(
    claim_id="SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015",
    title="Exact operational classical--quantum chemical correspondence",
    statement=(
        "One admitted molecular process description embeds every classical chemical state "
        "into the reversible Fold-quantum submodel. Complete branchwise quantum execution, "
        "shared observation decoding, exact inverse restoration and a positive resource "
        "ledger preserve every classical result bidirectionally. Phase-labelled quantum "
        "traces remain explicit and are not collapsed into the classical trace."
    ),
    dependencies=DEPENDENCIES,
    generation_rule=(
        "Generate the literal product of description, embedding, reversibility, quantum "
        "execution, Chemistry ownership, observation, result and resource forms; decide "
        "all 256 only from admitted molecular transition, measurement and classical--"
        "quantum computation laws."
    ),
    grammar_boundary=(
        "Every positive finite reversible molecular transition table under one admitted "
        "Chemistry law, with complete classical rows, quantum branches, observation "
        "records, inverse trace and exact positive resource ledger."
    ),
    dimensions=DIMENSIONS,
    exact_result=EXACT_RESULT,
    induction_base=(
        "One retained molecular carrier with one reversible transition row embeds as one "
        "classical state and one held-phase quantum branch; both decode the same terminal "
        "chemical state and the inverse restores the input."
    ),
    induction_step=(
        "Appending one distinct reversible transition row adds exactly its classical "
        "execution, singleton embedding, quantum branch, complete observation record and "
        "inverse row while preserving every earlier result and exact resource count."
    ),
    exclusions=(
        "no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value",
        "no imported bit, qubit, amplitude, Hilbert space, stochastic collapse or conventional circuit premise",
        "no fitted, learned, hardware or application parameter",
        "no mode-specific chemical law or target-selected molecular process",
        "no claim that phase-sensitive or nonfactorable quantum traces are identical to classical traces",
    ),
    operational_witnesses=OPERATIONAL_WITNESSES,
)
CLASSICAL_QUANTUM_SPEC.validate()

__all__ = (
    "CLASSICAL_QUANTUM_SPEC",
    "GeneratedOperationalChemistryProgram",
    "OperationalChemistrySpec",
)

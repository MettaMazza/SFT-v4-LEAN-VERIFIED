"""Registered quantitative PROP-001 equilibrium-length specification."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Sequence

from sft.chemistry.equilibrium_bond_length_law_v1 import (
    DEPENDENCIES,
    DIMENSIONS,
    EXACT_RESULT,
    OPERATIONAL_WITNESSES,
)
from sft.chemistry.generated_law import ChemistryTargetReference, EmpiricalChemistrySpec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine import ClosureEvidence, ClosureScope
from sft.engine.canonical import sha256_identity
from sft.engine.model import CandidateDecision
from sft.engine.source import hash_file
from sft.physics.generated_empirical_law import survivor_id


ROOT = Path(__file__).resolve().parents[2]
IDENTITY_PATH = "experiments/external_sources/chemistry/equilibrium_bond_length_target_identities_v1.json"
IDENTITY_HASH = "sha256:539cefd200cd81a2cd3a9d8986f7c4b531999bdf1b633b621eaecf4fecb75cd8"
SCALE_PATH = "experiments/external_sources/chemistry/equilibrium_bond_length_scale_input_v1.json"
SCALE_HASH = "sha256:c29c269b522c73f2bdc08dc10ac2bf9599de5ce35edd4b5992fb27e2b874af53"
TARGET_PATH = "experiments/external_sources/chemistry/equilibrium_bond_length_withheld_targets_v1.json"
TARGET_HASH = "sha256:2223ed429a82a16bf2945235ba19941aea7553238fbf9c990f4f37662d5c6f9f"

for _path, _hash in (
    (IDENTITY_PATH, IDENTITY_HASH),
    (SCALE_PATH, SCALE_HASH),
    (TARGET_PATH, TARGET_HASH),
):
    if hash_file(ROOT / _path) != _hash:
        raise ValueError(f"PROP-001 registered source changed: {_path}")

_identity_document = json.loads((ROOT / IDENTITY_PATH).read_text(encoding="utf-8"))
if (
    _identity_document.get("schema") != "sft-v3-equilibrium-bond-length-identities/1"
    or len(_identity_document.get("rows", ())) != 2
    or not all(row.get("target_value_absent") is True for row in _identity_document["rows"])
):
    raise ValueError("PROP-001 identity registry is incomplete or contains a target")

TARGET_REFERENCES = tuple(
    ChemistryTargetReference(
        target_id=str(row["target_id"]),
        source_id=str(row["source_id"]),
        source_locator=str(row["source_locator"]),
        snapshot_path=str(row["snapshot_path"]),
        snapshot_hash=str(row["snapshot_hash"]),
    )
    for row in _identity_document["rows"]
)


class GeneratedFiniteQuantitativeChemistryProgram(GeneratedObservationalChemistryProgram):
    """Use the standard sealed product engine but retain the finite vector boundary."""

    def closure_evidence(self, decisions: Sequence[CandidateDecision]) -> ClosureEvidence:
        record = {
            "claim_id": self.spec.claim_id,
            "result": self.spec.exact_result,
            "boundary": self.spec.grammar_boundary,
            "base": self.spec.induction_base,
            "successor": self.spec.induction_step,
            "exclusions": self.spec.exclusions,
            "witnesses": self.spec.operational_witnesses,
            "survivor": survivor_id(self.spec),
        }
        return ClosureEvidence(
            ClosureScope.FINITE_COMPLETE,
            self.spec.grammar_boundary,
            True,
            True,
            sha256_identity((record, tuple(decisions))),
            None,
        )


EQUILIBRIUM_BOND_LENGTH_SPEC = EmpiricalChemistrySpec(
    claim_id="SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001",
    title="Exact H2/D2 equilibrium bond-length relation",
    statement=(
        "For the complete registered gas-phase H2/D2 X-state boundary, the common Fold electronic base is "
        "seven-fifths of the held atomic-length carrier. The binary-order alpha return adds twenty-one alpha "
        "squared for H2 and twenty-four alpha squared for D2. Thus r_e(H2)/a0=7/5+21 alpha^2 and "
        "r_e(D2)/a0=7/5+24 alpha^2 before either NIST distance target is released."
    ),
    dependencies=DEPENDENCIES,
    generation_rule=(
        "Generate the literal product of molecular identity, equilibrium ownership, scale, common base, "
        "correction order, isotopologue route, measurement custody and extension forms; decide all 256 "
        "from the admitted Fold support and spectroscopy carriers."
    ),
    grammar_boundary=(
        "The complete registered H2 and D2 homonuclear-hydrogen X 1Sigma_g+ gas-phase equilibrium-distance "
        "vector, using one held atomic-length reference, the exact alpha carrier and each generated up, down, "
        "generator and terminal support only in its typed slot."
    ),
    dimensions=DIMENSIONS,
    exact_result=EXACT_RESULT,
    induction_base=(
        "The admitted equal electronic support fixes one common up/down equilibrium base for the light "
        "homonuclear state; the binary alpha return supplies its first closed positive correction."
    ),
    induction_step=(
        "Replacing both retained light nuclei by the admitted heavy isotope preserves the common electronic "
        "base and forces the distinct terminal-plus-up-plus-One correction route; the two-row registered "
        "vector is then exhausted."
    ),
    exclusions=(
        "no numerical zero, negative, irrational, imaginary, floating, signed or continuum proof value",
        "no NIST distance, CODATA scale inscription or angstrom conversion in the executable law",
        "no imported wavefunction, potential, rigid-rotor length equation or conventional molecular model",
        "no fitted bond parameter, selected decimal coefficient, species lookup or free correction term",
        "no target access before the exact interval vector is sealed",
        "no claim beyond the registered H2/D2 X-state gas-phase boundary",
    ),
    operational_witnesses=OPERATIONAL_WITNESSES,
    experiment_id="SFT-EXP-CHEM-EQUILIBRIUM-BOND-LENGTH-001",
    expected_observation_label="exact-H2-D2-equilibrium-length-interval-vector-contained",
    target_rows=TARGET_REFERENCES,
    observation_registry_path=TARGET_PATH,
    falsification_condition=(
        "The claim fails if either exact sealed physical interval does not overlap its complete NIST displayed "
        "equilibrium-distance interval; if species, isotopologue, X state, gas-phase condition, CODATA scale "
        "provenance or source uncertainty is erased; if either target is readable before sealing; if any extra "
        "coefficient or species rule is appended; or if a deliberately displaced interval is accepted."
    ),
)
EQUILIBRIUM_BOND_LENGTH_SPEC.validate()

__all__ = (
    "EQUILIBRIUM_BOND_LENGTH_SPEC",
    "GeneratedFiniteQuantitativeChemistryProgram",
    "IDENTITY_HASH",
    "IDENTITY_PATH",
    "SCALE_HASH",
    "SCALE_PATH",
    "TARGET_HASH",
    "TARGET_PATH",
    "TARGET_REFERENCES",
)

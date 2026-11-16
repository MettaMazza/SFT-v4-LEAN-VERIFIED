"""Measured-value successor for the exact common Fold scale axis."""

from dataclasses import replace
from fractions import Fraction

from sft.engine import ProvenanceClass
from sft.physics.common_scale_axis_terminal_law_v1 import leading_electroweak_share, terminal_electroweak_chain
from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, GeneratedEmpiricalPhysicsProgram, empirical_dimensions


CLAIM_ID = "SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054"
EXPERIMENT_ID = "SFT-EXP-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054"
SOURCE_PATH = "experiments/external_sources/physics/snapshots/common-scale-measured-value-successor-source-record.json"
SOURCE_HASH = "sha256:4143fd2a2b5f480bc35c84e83b3febd9e04f72661b6c1607ba9bc7204ac61d00"
SOURCE_FILES = (
    ("experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf", "sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),
    ("experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json", "sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),
    ("claims/SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030/certificate.json", "sha256:904ba1d325c5e5200cacb4ff09fdb0abe1b8328d6ae16177e29f2e596d4138bb"),
    ("claims/SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053/certificate.json", "sha256:3a19d721c429874f404e7b75601511f8ba0c39a68fae6f2c46f2010d12a492a4"),
    ("claims/SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006/certificate.json", "sha256:f598cd663a76f8137cf2e40c5e8154083b8196ec399751da8577ce9769f688d6"),
)
SOURCE_IDS = ("PDG-2026-ELECTROWEAK-SCALE-VECTOR", "PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR")
OBSERVATION_LABEL = "common-scale-terminal-and-support-eight-values-inside-like-typed-measurements__running-direction-preserved__NuTeV-extraction-retained-but-not-rewarded-as-mismatch"


class ObservationalEmpiricalPhysicsProgram(GeneratedEmpiricalPhysicsProgram):
    @property
    def registration(self):
        return replace(super().registration, provenance=(ProvenanceClass.OBSERVATIONAL_DERIVATION,))


SPEC = EmpiricalPhysicsSpec(
    claim_id=CLAIM_ID,
    title="Common Fold scale measured-value correction",
    statement=(
        "The admitted common-axis law independently fixes the terminal weak share and the support-eight share 25/106. "
        "The terminal value lies in the direct on-shell interval and 25/106 lies in the complete cesium atomic-parity-"
        "violation interval. The registered below-W direction is preserved. The NuTeV DIS extraction is retained "
        "unchanged with its source-reported interpretation concerns, but its displacement is neither an SFT result nor "
        "an acceptance condition."
    ),
    dependencies=(
        "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030",
        "SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053",
        "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006",
        "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
        "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    ),
    generation_rule="Generate the complete eight-axis product of common-scale carrier, target-free relation, provenance, custody, proof/measurement separation, row completeness, successor closure and absence of extra rules.",
    grammar_boundary="The admitted common-axis receipt; terminal and support-eight exact shares; all four scheme rows; all four numeric low-transfer rows; all eight plotted measurement classes; threshold boundaries; complete strong/electromagnetic receipt; and exact source identities.",
    dimensions=empirical_dimensions(
        "sealed-common-scale-values-versus-like-typed-measurements",
        "The exact terminal and support-eight shares are sealed before the on-shell and APV targets open; other rows retain their measurement and method types.",
    ),
    exact_result=(
        "The terminal on-shell share lies inside [22333,22351]/100000. The support-eight share 25/106 lies inside "
        "[2331,2367]/10000. The complete registered low-transfer vector preserves the sub-W direction. No mismatch, "
        "uncertainty multiplier, fitted rung or measurement-selected exception is admitted."
    ),
    induction_base="One exact common axis and its first complete support successor are fixed by the admitted formal receipt.",
    induction_step="Every support successor preserves the same generated axis and exact dimensionless comparison; measurement rows remain post-seal records and cannot modify the axis.",
    exclusions=(
        "no measured weak angle in the formal common-axis construction",
        "no fitted support, coefficient, correction, uncertainty multiplier or selected central value",
        "no NuTeV displacement relabelled as successful empirical closure",
        "no deletion, alteration or silent retyping of any registered measurement row",
        "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude",
    ),
    operational_witnesses=(
        ("support-eight-exact", "The forced support-eight share is exactly 25/106.", leading_electroweak_share(4) == Fraction(25, 106)),
        ("terminal-exact", "The terminal share is an exact proper Fold fraction.", Fraction(1, 5) < terminal_electroweak_chain()["terminal_share"] < Fraction(1, 4)),
    ),
    experiment_id=EXPERIMENT_ID,
    expected_observation_label=OBSERVATION_LABEL,
    target_rows=(
        ExternalTargetRow("PDG-COMMON-SCALE-ON-SHELL", SOURCE_IDS[0], "printed page 23 on-shell row", OBSERVATION_LABEL),
        ExternalTargetRow("PDG-COMMON-SCALE-LOW-TRANSFER", SOURCE_IDS[0], "printed page 25 complete numeric low-transfer vector", OBSERVATION_LABEL),
        ExternalTargetRow("PDG-COMPLETE-STRONG-EM-RUNNING", SOURCE_IDS[1], "complete admitted strong/electromagnetic source vector", OBSERVATION_LABEL),
    ),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition=(
        "Reject if a source or dependency changes; either forced value leaves its like-typed measured interval; the "
        "below-W direction reverses; a row or threshold boundary is omitted; NuTeV displacement is made a passing "
        "result; any uncertainty is widened; or target data alter the formal survivor."
    ),
)

SPEC.validate()

__all__ = ("CLAIM_ID", "EXPERIMENT_ID", "OBSERVATION_LABEL", "ObservationalEmpiricalPhysicsProgram", "SOURCE_FILES", "SOURCE_HASH", "SOURCE_IDS", "SOURCE_PATH", "SPEC")

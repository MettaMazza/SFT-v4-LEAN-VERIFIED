"""Post-seal external empirical test of criticality and turbulence scaling."""

from dataclasses import replace

from sft.engine import ProvenanceClass
from sft.physics.criticality_universality_turbulence_terminal_law_v1 import theorem_certificate
from sft.physics.generated_empirical_law import (
    EmpiricalPhysicsSpec,
    ExternalTargetRow,
    GeneratedEmpiricalPhysicsProgram,
    empirical_dimensions,
)


CLAIM_ID = "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048"
EXPERIMENT_ID = "SFT-EXP-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048"
SOURCE_PATH = "experiments/external_sources/physics/snapshots/criticality-universality-turbulence-postseal-source-record.json"
SOURCE_HASH = "sha256:7c3cb34584f3581b46c9c9e1f91d2c550cfd8441761a512fee767baf8cc801fa"
SOURCE_FILES = (
    ("experiments/external_sources/physics/snapshots/cetin-manganite-critical-exponents-2026.html", "sha256:afd0f783bd40b8ed376238eda9b254387c75c0c26ecc57488ab9b81b33d1d455"),
    ("experiments/external_sources/physics/snapshots/lin-erbium-critical-scattering-1993.html", "sha256:d8b6495b7defb46daa4d1162967d11b4680012ebd4a8e6d60e8892b83b9b3564"),
    ("experiments/external_sources/physics/snapshots/mccomb-turbulence-structure-exponent-2014.pdf", "sha256:0c9f4321b52f78fe64b02684b4139a450955c12092c4faf8487f49bf6ff1d0f5"),
    ("experiments/external_sources/physics/snapshots/huang-turbulence-spectrum-2010.pdf", "sha256:1bff196a24bc3f852dd384469c5f8e4112fcdf717c2416190ad44b0012ac06cb"),
)
SOURCE_IDS = (
    "SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026",
    "MCMASTER-LIN-ERBIUM-CRITICAL-SCATTERING-1993",
    "APS-MCCOMB-TURBULENCE-STRUCTURE-2014",
    "APS-HUANG-TURBULENCE-SPECTRUM-2010",
)
OBSERVATION_LABEL = "sealed-criticality-and-cascade__complete-exponent-intervals-and-five-thirds-plateaux__nonmatching-row-and-boundaries-retained"


class ObservationalEmpiricalPhysicsProgram(GeneratedEmpiricalPhysicsProgram):
    @property
    def registration(self):
        return replace(super().registration, provenance=(ProvenanceClass.OBSERVATIONAL_DERIVATION,))


SPEC = EmpiricalPhysicsSpec(
    claim_id=CLAIM_ID,
    title="Post-seal critical-exponent, universality and turbulence-scaling test",
    statement=(
        "After Claim 047 and its complete 256-form derivation were officially sealed, four independent records were bound. Neutron scattering in erbium measures beta, gamma and nu intervals containing the sealed 1/2, One and 1/2 vector. Five manganite compositions report beta, gamma and delta: La00, La04, La06 and La08 contain the complete sealed 1/2, One and three vector, while La02 does not and is retained as an unfavorable class-membership control. An independent turbulence computation measures zeta_2=(679 +/- 13)/1000, whose exact interval contains 2/3, and a physical turbulent-channel experiment observes five-thirds compensated spectral plateaux by both Fourier and Hilbert routes. Finite-Reynolds and structure-function-range limitations remain explicit; no measured value selected or altered the formal law."
    ),
    dependencies=(
        "SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047",
        "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
        "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
        "SFT-PHYS-MEAS-UNCERTAINTY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    ),
    generation_rule="Generate the complete eight-axis product of the sealed criticality/cascade law, exact external intervals, universality membership, complete-row custody, method agreement, limitation retention and proof/measurement separation.",
    grammar_boundary="The admitted 256-form formal survivor; all four bound source records; every reported erbium and five-composition manganite exponent interval; the complete turbulence structure interval; both physical spectrum-analysis routes; every unfavorable row, limitation and custody record.",
    dimensions=empirical_dimensions(
        "sealed-criticality-and-cascade-law-versus-complete-postseal-exponent-and-turbulence-vector",
        "Claim 047 and receipt sha256:0601d19640943c4b99eb8cccf061e3115c520773eac5e762bf7c5b7440339b25 were fixed before the four target snapshots were bound.",
    ),
    exact_result=(
        "The erbium intervals [46,50]/100 for beta, [90,102]/100 for gamma and [47,51]/100 for nu contain exactly 1/2, One and 1/2. Of the complete five-row manganite record, La00, La04, La06 and La08 contain the entire beta=1/2, gamma=One, delta=three vector; La02 excludes gamma=One and delta=three and therefore cannot be admitted to that generated universality class. The independent turbulence interval [666,692]/1000 contains exactly 2/3. A Reynolds-count-720 physical flow exhibits five-thirds compensated plateaux over 40--4000 Hz by Fourier analysis and 20--2000 Hz by Hilbert analysis. The nonmatching composition, finite-Reynolds correction boundary, structure-function range limitation, normalized-threshold boundary and empty-exponent typing are all retained."
    ),
    induction_base="The admitted formal receipt fixes the two generated classes and all six exact exponent carriers before any measurement target is released.",
    induction_step="Each additional source, sample, interval, analysis route and limitation is retained exactly once and cannot modify the sealed formal survivor or its generated class key.",
    exclusions=(
        "no critical exponent, sample class, Reynolds record, structure exponent or spectrum slope readable by the formal generator",
        "no fitted exponent, uncertainty interval, intermittency correction or measurement-selected universality class",
        "no omission of La02 or any other unfavorable measurement row",
        "no conversion of the normalized half-One threshold into a universal laboratory temperature",
        "no conversion of typed empty alpha or eta into a numerical-zero measurement",
        "no claim that every physical transition shares the binary self-antipodal exponent vector",
        "no conventional numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude",
    ),
    operational_witnesses=(
        ("critical-powers", "The complete exact critical perfect-power census is closed.", theorem_certificate()["mean_field"]),
        ("identities", "All exact critical scaling identities are closed.", theorem_certificate()["identities"]),
        ("cascade", "The complete cube/square/fifth-power cascade census is closed.", theorem_certificate()["cascade"]),
        ("classes", "The declared generated universality classes are distinct and complete.", theorem_certificate()["classes"]),
    ),
    experiment_id=EXPERIMENT_ID,
    expected_observation_label=OBSERVATION_LABEL,
    target_rows=tuple(
        ExternalTargetRow(target, source, description, OBSERVATION_LABEL)
        for target, source, description in (
            ("MANGANITE-CRITICAL-VECTOR", SOURCE_IDS[0], "Complete five-composition beta/gamma/delta interval vector, including nonmatch"),
            ("ERBIUM-CRITICAL-VECTOR", SOURCE_IDS[1], "Physical beta/gamma/nu neutron-scattering interval vector"),
            ("TURBULENCE-STRUCTURE-EXPONENT", SOURCE_IDS[2], "Independent computational zeta_2 interval and finite-Reynolds boundary"),
            ("TURBULENCE-SPECTRUM", SOURCE_IDS[3], "Physical five-thirds compensated plateaux by two analysis routes"),
        )
    ),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition=(
        "Reject if any source or reported row changes; the erbium vector excludes a sealed carrier; fewer than the registered four manganite rows match or La02 is concealed or relabelled as a complete match; the zeta_2 interval excludes 2/3; either registered physical spectrum route lacks its five-thirds plateau; any limitation is omitted; or target data alter the sealed survivor."
    ),
)


SPEC.validate()


__all__ = (
    "CLAIM_ID",
    "EXPERIMENT_ID",
    "OBSERVATION_LABEL",
    "ObservationalEmpiricalPhysicsProgram",
    "SOURCE_FILES",
    "SOURCE_HASH",
    "SOURCE_IDS",
    "SOURCE_PATH",
    "SPEC",
)

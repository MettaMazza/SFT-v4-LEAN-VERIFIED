"""Post-seal NIST comparison for terminal molecular spectroscopy."""

from __future__ import annotations

from fractions import Fraction
import json
from pathlib import Path

from sft.engine.source import hash_file
from sft.physics.generated_empirical_law import (
    BlindExternalMeasurementValidator,
    EmpiricalPhysicsSpec,
    ExternalTargetRow,
    empirical_dimensions,
)
from sft.physics.molecular_spectroscopy_successor_laws_v1 import (
    MOLECULAR_SPECTROSCOPY_TERMINAL_ID,
    deuterium_rotational_transport,
    deuterium_vibrational_squared_transport,
    hydrogen_anharmonic_to_vibrational,
    hydrogen_rotational_to_vibrational,
)
from sft.physics.prior_value_laws import positive_take


SOURCE_ID = "NIST-MOLECULAR-SPECTROSCOPY-H2-D2-SUCCESSOR"
SOURCE_PATH = "experiments/external_sources/physics/snapshots/molecular-spectroscopy-successor-source-record.json"
SOURCE_HASH = "sha256:211fb30414204bcc61f9fb4a69a451db24cb5d5aaaacb2bb3b85fc83429388a9"
COMPONENT_HASHES = {
    "hydrogen": "sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24",
    "deuterium": "sha256:790276cd493dbede03fc9e83db95bc0808a36838eb31473aaf923493b4749936",
}
MEASURED_LABEL = (
    "terminal-molecular-JJplusOne-anharmonic-and-isotope-relations-contained-in-complete-NIST-H2-D2-displayed-resolution-vector"
    "__observational-prediction-protocol-passed"
)


def authoritative_record(root: Path) -> dict[str, object]:
    path = root / SOURCE_PATH
    if hash_file(path) != SOURCE_HASH:
        raise ValueError("molecular spectroscopy source record identity changed")
    payload = json.loads(path.read_text(encoding="utf-8"))
    custody = payload.get("custody", {})
    required = {
        "development_targets_already_known": True,
        "classification": "observational_derivation",
        "protocol_classification": "observational-data-informed_target-inaccessible_sealed-prediction",
        "empirical_prediction_protocol": True,
        "target_inaccessible_during_prediction_execution": True,
        "formal_relations_contain_measurement": False,
        "measurements_select_formal_survivors": False,
        "engine_prediction_sealed_before_target_release_within_run": True,
        "reported_digits_retained_without_reinterpretation": True,
        "last_inscribed_digit_enclosures_are_comparison_resolutions_not_reported_uncertainties": True,
        "earlier_leading_and_adverse_receipts_preserved": True,
    }
    if any(custody.get(key) != value for key, value in required.items()):
        raise ValueError("molecular spectroscopy custody disclosure changed")
    sources = payload.get("sources", {})
    if set(sources) != set(COMPONENT_HASHES):
        raise ValueError("molecular spectroscopy source set changed")
    for isotope, expected_hash in COMPONENT_HASHES.items():
        row = sources[isotope]
        component = root / row.get("snapshot_path", "missing")
        if row.get("snapshot_hash") != expected_hash or hash_file(component) != expected_hash:
            raise ValueError(f"molecular spectroscopy component identity changed: {isotope}")
    policy = payload.get("comparison_policy", {})
    if policy.get("provenance") != (
        "Observation informed the explicit frozen successor relations. The executable law module contains none of these values and cannot open this record. Complete grammar enumeration, unique selection and sealing precede target release."
    ):
        raise ValueError("molecular spectroscopy provenance disclosure changed")
    predecessor = payload.get("predecessor_disposition", {})
    if predecessor.get("immutable_leading_claim") != "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004":
        raise ValueError("molecular spectroscopy predecessor identity changed")
    return payload


def source_interval(root: Path, isotope: str, row_name: str) -> tuple[Fraction, Fraction]:
    row = authoritative_record(root)["sources"][isotope]["rows"][row_name]
    centre = Fraction(row["inscription"])
    half_width = Fraction(row["last_inscribed_digit_half_width"])
    return positive_take(centre, half_width), centre + half_width


def outward_ratio_interval(
    numerator: tuple[Fraction, Fraction],
    denominator: tuple[Fraction, Fraction],
) -> tuple[Fraction, Fraction]:
    if numerator[0] <= 0 or denominator[0] <= 0:
        raise ValueError("ratio interval requires positive endpoints")
    return numerator[0] / denominator[1], numerator[1] / denominator[0]


def squared_interval(interval: tuple[Fraction, Fraction]) -> tuple[Fraction, Fraction]:
    if interval[0] <= 0:
        raise ValueError("squared interval requires positive endpoints")
    return interval[0] ** 2, interval[1] ** 2


def measured_ratio_intervals(root: Path) -> dict[str, tuple[Fraction, Fraction]]:
    h_vibration = source_interval(root, "hydrogen", "vibrational_constant_cm_inverse")
    h_anharmonic = source_interval(root, "hydrogen", "anharmonic_constant_cm_inverse")
    h_rotation = source_interval(root, "hydrogen", "rotational_constant_cm_inverse")
    d_vibration = source_interval(root, "deuterium", "vibrational_constant_cm_inverse")
    d_rotation = source_interval(root, "deuterium", "rotational_constant_cm_inverse")
    return {
        "hydrogen_rotation_over_vibration": outward_ratio_interval(h_rotation, h_vibration),
        "hydrogen_anharmonic_over_vibration": outward_ratio_interval(h_anharmonic, h_vibration),
        "deuterium_rotation_over_hydrogen_rotation": outward_ratio_interval(d_rotation, h_rotation),
        "deuterium_vibration_over_hydrogen_vibration_squared": squared_interval(
            outward_ratio_interval(d_vibration, h_vibration)
        ),
    }


def sealed_ratio_vector() -> dict[str, Fraction]:
    return {
        "hydrogen_rotation_over_vibration": hydrogen_rotational_to_vibrational(),
        "hydrogen_anharmonic_over_vibration": hydrogen_anharmonic_to_vibrational(),
        "deuterium_rotation_over_hydrogen_rotation": deuterium_rotational_transport(),
        "deuterium_vibration_over_hydrogen_vibration_squared": deuterium_vibrational_squared_transport(),
    }


def molecular_spectroscopy_classification(root: Path) -> str:
    record = authoritative_record(root)
    intervals = measured_ratio_intervals(root)
    sealed = sealed_ratio_vector()
    for key, prediction in sealed.items():
        lower, upper = intervals[key]
        if not lower <= prediction <= upper:
            raise ValueError(f"sealed molecular ratio left the complete NIST displayed-resolution interval: {key}")

    h = record["sources"]["hydrogen"]["rows"]
    d = record["sources"]["deuterium"]["rows"]
    h_values = tuple(Fraction(h[name]["inscription"]) for name in (
        "vibrational_constant_cm_inverse",
        "anharmonic_constant_cm_inverse",
        "rotational_constant_cm_inverse",
    ))
    d_values = tuple(Fraction(d[name]["inscription"]) for name in (
        "vibrational_constant_cm_inverse",
        "anharmonic_constant_cm_inverse",
        "rotational_constant_cm_inverse",
    ))
    if not (h_values[0] > h_values[1] > h_values[2] > 0):
        raise ValueError("NIST H2 hierarchy no longer confirms distinct positive carriers")
    if not (d_values[0] > d_values[1] > d_values[2] > 0):
        raise ValueError("NIST D2 hierarchy no longer confirms distinct positive carriers")
    if not all(d_value < h_value for d_value, h_value in zip(d_values, h_values)):
        raise ValueError("NIST isotope direction no longer confirms the heavier-carrier shift")
    return MEASURED_LABEL


MOLECULAR_EMPIRICAL_SPEC = EmpiricalPhysicsSpec(
    claim_id=MOLECULAR_SPECTROSCOPY_TERMINAL_ID,
    title="Terminal molecular spectroscopy post-seal NIST H2/D2 comparison",
    statement=(
        "Observation informed the explicit molecular successor relations.  The two NIST source components "
        "remain capability-closed while the engine exhausts the formal grammar and seals the exact ladder and "
        "ratio vector; post-seal exact outward interval propagation contains all four sealed ratios and preserves "
        "the distinct-carrier hierarchy and heavier-isotope direction."
    ),
    dependencies=(
        MOLECULAR_SPECTROSCOPY_TERMINAL_ID,
        "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
        "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
        "SFT-PHYS-MEAS-UNCERTAINTY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    ),
    generation_rule="Generate the complete eight-axis post-seal NIST H2/D2 molecular-spectroscopy comparison product.",
    grammar_boundary="The complete registered NIST H2 and D2 ground-state constant rows, their displayed resolutions, immutable predecessor receipts, disclosed observational development and sealed target-inaccessible molecular relation vector.",
    dimensions=empirical_dimensions(
        "sealed-terminal-molecular-ratio-vector-versus-complete-NIST-H2-D2-displayed-resolution-intervals",
        "Every exact relation, registered displayed digit, source identity, predecessor and unfavorable receipt remains visible while the post-seal interval decision is exact.",
    ),
    exact_result=(
        "The sealed J(J+1), 2J, oscillator/anharmonic and four-ratio molecular successor passes the complete "
        "registered NIST H2/D2 comparison vector at the sources' displayed resolutions."
    ),
    induction_base="The source record retains both ground-state rows, every displayed digit, the sealed relation vector and the immutable predecessor disposition.",
    induction_step="Every later source revision forms a new comparison receipt and cannot rewrite this seal, either component snapshot, the adverse predecessor result or any earlier relation.",
    exclusions=(
        "no source value readable by the executable law",
        "no measured value selecting the formal survivor",
        "no hidden development provenance or reinterpretation of displayed resolution as reported uncertainty",
        "no floating-point interval decision",
        "no erased leading or adverse receipt",
    ),
    operational_witnesses=((
        "target-free-exact-vector",
        "All four molecular carriers are exact positive fractions before source release.",
        all(isinstance(value, Fraction) and value > 0 for value in sealed_ratio_vector().values()),
    ),),
    experiment_id="SFT-EXP-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005",
    expected_observation_label=MEASURED_LABEL,
    target_rows=(ExternalTargetRow(
        "NIST-MOLECULAR-H2-D2-COMPLETE-VECTOR",
        SOURCE_ID,
        "NIST Chemistry WebBook SRD 69 H2 and D2 X 1Sigma_g+ ground-state omega_e, omega_e*x_e, B_e and r_e rows",
        MEASURED_LABEL,
    ),),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition=(
        "The claim fails if any sealed ratio leaves its complete registered exact displayed-resolution interval, "
        "the J(J+1), 2J or positive anharmonic ladder identity fails, either isotope hierarchy or source hash "
        "changes, a target becomes readable before sealing, development provenance is hidden, or an immutable "
        "leading or adverse receipt is erased."
    ),
)


class MolecularSpectroscopyValidator:
    def __init__(self, root: Path):
        self.root = root.resolve()

    def validate(self, sealed):
        validation = BlindExternalMeasurementValidator(self.root, MOLECULAR_EMPIRICAL_SPEC).validate(sealed)
        if molecular_spectroscopy_classification(self.root) != MEASURED_LABEL or not validation.passed:
            raise ValueError("terminal molecular spectroscopy authoritative classification changed")
        return validation


MOLECULAR_EMPIRICAL_SPEC.validate()


__all__ = (
    "MEASURED_LABEL",
    "MOLECULAR_EMPIRICAL_SPEC",
    "MolecularSpectroscopyValidator",
    "SOURCE_HASH",
    "SOURCE_ID",
    "SOURCE_PATH",
    "authoritative_record",
    "measured_ratio_intervals",
    "molecular_spectroscopy_classification",
    "sealed_ratio_vector",
)

"""Post-seal authoritative validation of matter and flavour successors."""

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
from sft.physics.matter_flavour_laws_v1 import (
    CKM_PHYSICAL_ID,
    MAGNETIC_ANOMALY_ID,
    MAJORANA_ID,
    NEUTRINO_MASS_ID,
    NEUTRINO_SPLITTING_ID,
    PMNS_CP_ID,
    PROTON_ELECTRON_ID,
    QUARK_DRESSING_ID,
    QUARK_CUBICS_ID,
    ZERO_NU_ID,
    bisect_bracket,
    bisect_square,
    isolate_cubic_roots,
    neutrino_mass_squares,
    pmns_cp_structure,
    quark_cubic_invariants,
    quark_dressing_factors,
)


QUARK_CKM_VALIDATION_ID = "SFT-PHYS-VALIDATION-QUARK-CKM-003"
PROTON_VALIDATION_ID = "SFT-PHYS-VALIDATION-PROTON-ELECTRON-003"
NEUTRINO_VALIDATION_ID = "SFT-PHYS-VALIDATION-NEUTRINO-MASS-MIXING-003"
MAJORANA_VALIDATION_ID = "SFT-PHYS-VALIDATION-MAJORANA-ZERO-NU-003"
MAGNETIC_VALIDATION_ID = "SFT-PHYS-VALIDATION-MAGNETIC-ANOMALIES-003"

SOURCE_ID = "MATTER-FLAVOUR-AUTHORITATIVE-2022-2026"
SOURCE_PATH = "experiments/external_sources/physics/snapshots/matter-flavour-source-record.json"
SOURCE_HASH = "sha256:6e56fcdd94371ebf396b9600a1431fd448075f69073572b9cb0660959329b9fe"

QUARK_CKM_LABEL = "dressed-sd-and-bs-inside-complete-PDG-intervals__tc-is-a-sealed-exact-prediction-with-no-registered-direct-scheme-matched-measurement__CKM-hierarchy-and-s12-s13-J-supported-with-s23-three-sigma-tension-retained"
PROTON_LABEL = "sealed-proton-electron-reconstruction-near-scale-but-outside-complete-CODATA-uncertainty__unfavorable-result-retained"
NEUTRINO_LABEL = "positive-normal-neutrino-mass-structure-PMNS-and-CP-inside-registered-three-sigma-support__mass-sum-below-direct-and-cosmological-bounds__ordering-preference-not-decisive"
MAJORANA_LABEL = "Majorana-and-zero-nu-beta-beta-formally-forced-and-closed-as-predictions__not-yet-observed__predicted-effective-mass-below-current-experimental-upper-bound"
MAGNETIC_LABEL = "bare-g-and-terminal-alpha-leading-structure-compared-only-with-raw-electron-and-muon-measurements__consensus-model-interpretation-excluded"

COMPONENT_HASHES = {
    "nist-codata-2022-allascii.txt": "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67",
    "pdg-2025-quark-masses.pdf": "sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae",
    "pdg-2025-ckm-matrix.pdf": "sha256:a0a78578971f38ff89c6fc5579bc608de41ec383a205dc25cba1d26f7145610a",
    "pdg-2025-neutrino-mixing.pdf": "sha256:d7067e2e3c9098cc924f10ffbca579c557fb8e848bf3acc17f9815598cdda7a6",
    "fermilab-muon-g2-result-2025.pdf": "sha256:22fa2f99c52932ed012dc222eb821c2cb1a3d387671d650b23fbbed87a6e80a0",
}


def decimal(value: str) -> Fraction:
    return Fraction(value)


def authoritative_record(root: Path) -> dict[str, object]:
    path = root / SOURCE_PATH
    if hash_file(path) != SOURCE_HASH:
        raise ValueError("matter/flavour source record identity changed")
    payload = json.loads(path.read_text(encoding="utf-8"))
    if payload.get("custody", {}).get("formal_seal_completed_before_source_open") is not True:
        raise ValueError("matter/flavour post-seal custody changed")
    if len(payload.get("sources", ())) != 6:
        raise ValueError("matter/flavour source vector is incomplete")
    for item in payload["sources"]:
        snapshot = item.get("snapshot_path", "").split("/")[-1]
        if snapshot in COMPONENT_HASHES and hash_file(root / item["snapshot_path"]) != COMPONENT_HASHES[snapshot]:
            raise ValueError("matter/flavour component identity changed")
    return payload


def source_rows(root: Path, source_id: str) -> dict[str, object]:
    for item in authoritative_record(root)["sources"]:
        if item["source_id"] == source_id:
            return item["rows"]
    raise ValueError(f"missing registered source {source_id}")


def refined_quark_roots() -> dict[str, tuple[tuple[Fraction, Fraction], ...]]:
    result = {}
    for name, values in quark_cubic_invariants().items():
        brackets = isolate_cubic_roots(values[1], values[2])
        # The source precision is at worst five decimal places.  Refine until
        # every root interval is narrower than one part in 10^12; this is a
        # post-seal enclosure precision and cannot select the polynomial.
        while any(upper - lower > Fraction(1, 10 ** 12) for lower, upper in brackets):
            brackets = tuple(bisect_bracket(row, values[1], values[2]) for row in brackets)
        result[name] = brackets
    return result


def square_ratio_interval(numerator: tuple[Fraction, Fraction], denominator: tuple[Fraction, Fraction]) -> tuple[Fraction, Fraction]:
    lower = (numerator[0] / denominator[1]) ** 2
    upper = (numerator[1] / denominator[0]) ** 2
    return lower, upper


def scaled(interval: tuple[Fraction, Fraction], factor: Fraction) -> tuple[Fraction, Fraction]:
    return interval[0] * factor, interval[1] * factor


def inverted(interval: tuple[Fraction, Fraction]) -> tuple[Fraction, Fraction]:
    return Fraction(1, 1) / interval[1], Fraction(1, 1) / interval[0]


def overlaps(interval: tuple[Fraction, Fraction], target: tuple[Fraction, Fraction]) -> bool:
    return interval[0] <= target[1] and target[0] <= interval[1]


def quark_prediction_intervals() -> dict[str, tuple[Fraction, Fraction]]:
    roots = refined_quark_roots()
    factors = quark_dressing_factors()
    down, up = roots["down"], roots["up"]
    bare_sd = square_ratio_interval(down[1], down[0])
    bare_bs = square_ratio_interval(down[2], down[1])
    bare_tc = square_ratio_interval(up[2], up[1])
    return {
        "s_over_d": scaled(bare_sd, factors["central_down_lift"]),
        "b_over_s": scaled(bare_bs, Fraction(1, 1) / factors["central_down_lift"]),
        "t_over_c": scaled(bare_tc, factors["upper_up_retention"]),
    }


def ckm_prediction_intervals() -> dict[str, tuple[Fraction, Fraction]]:
    roots = refined_quark_roots(); down, up = roots["down"], roots["up"]
    s12_sq = square_ratio_interval(down[0], down[1])
    down_slope = (down[1][0] / down[2][1], down[1][1] / down[2][0])
    up_slope = (up[1][0] / up[2][1], up[1][1] / up[2][0])
    s23 = (down_slope[0] - up_slope[1], down_slope[1] - up_slope[0])
    if s23[0] <= 0:
        raise ValueError("CKM positive slope separation failed")
    s23_sq = (s23[0] ** 2, s23[1] ** 2)
    s13_sq = (s12_sq[0] * s23_sq[0] / 6, s12_sq[1] * s23_sq[1] / 6)
    # On these intervals x(1-x) is increasing, so direct endpoint bounds apply.
    first = (s12_sq[0] * (1 - s12_sq[0]), s12_sq[1] * (1 - s12_sq[1]))
    second = (s23_sq[0] * (1 - s23_sq[0]), s23_sq[1] * (1 - s23_sq[1]))
    third = (s13_sq[0] * (1 - s13_sq[1]) ** 2, s13_sq[1] * (1 - s13_sq[0]) ** 2)
    j_sq = (first[0] * second[0] * third[0], first[1] * second[1] * third[1])
    return {"s12_squared": s12_sq, "s23_squared": s23_sq, "s13_squared": s13_sq, "jarlskog_squared": j_sq}


def quark_ckm_classification(root: Path) -> str:
    quark = source_rows(root, "PDG-2025-QUARK-MASSES")
    ckm = source_rows(root, "PDG-2025-CKM-MATRIX")
    predictions = quark_prediction_intervals()
    sd_target = (
        (decimal(quark["ms_MeV_MSbar_2GeV"]["value"]) - decimal(quark["ms_MeV_MSbar_2GeV"]["total_uncertainty"])) /
        (decimal(quark["md_MeV_MSbar_2GeV"]["value"]) + decimal(quark["md_MeV_MSbar_2GeV"]["total_uncertainty"])),
        (decimal(quark["ms_MeV_MSbar_2GeV"]["value"]) + decimal(quark["ms_MeV_MSbar_2GeV"]["total_uncertainty"])) /
        (decimal(quark["md_MeV_MSbar_2GeV"]["value"]) - decimal(quark["md_MeV_MSbar_2GeV"]["total_uncertainty"])),
    )
    mcms = quark["mc_over_ms"]; mbmc = quark["mb_over_mc"]
    bs_target = (
        (decimal(mcms["value"]) - decimal(mcms["total_uncertainty"])) * (decimal(mbmc["value"]) - decimal(mbmc["total_uncertainty"])),
        (decimal(mcms["value"]) + decimal(mcms["total_uncertainty"])) * (decimal(mbmc["value"]) + decimal(mbmc["total_uncertainty"])),
    )
    if not overlaps(predictions["s_over_d"], sd_target) or not overlaps(predictions["b_over_s"], bs_target):
        raise ValueError("sealed dressed quark ratios miss complete PDG intervals")
    if quark["top_over_charm"]["measurement_status"] != "no exact scheme-matched direct measurement registered":
        raise ValueError("top/charm direct-measurement status changed")
    if quark["top_over_charm"]["formal_status_consequence"] != "the independently sealed SFT value remains a prediction":
        raise ValueError("top/charm prediction status changed")
    cpred = ckm_prediction_intervals()
    checks = {}
    for key, source_key in (("s12_squared", "sin_theta12"), ("s23_squared", "sin_theta23"), ("s13_squared", "sin_theta13"), ("jarlskog_squared", "jarlskog")):
        row = ckm[source_key]; centre = decimal(row["value"]); low = decimal(row["lower_uncertainty"]); high = decimal(row["upper_uncertainty"])
        target = ((centre - 3 * low) ** 2, (centre + 3 * high) ** 2)
        checks[key] = overlaps(cpred[key], target)
    if not (checks["s12_squared"] and checks["s13_squared"] and checks["jarlskog_squared"] and not checks["s23_squared"]):
        raise ValueError("complete CKM support/tension pattern changed")
    return QUARK_CKM_LABEL


def proton_ratio_interval() -> tuple[Fraction, Fraction]:
    pair, product_value = Fraction(1, 6), Fraction(1, 485)
    brackets = isolate_cubic_roots(pair, product_value)
    while any(upper - lower > Fraction(1, 10 ** 15) for lower, upper in brackets[:2]):
        brackets = tuple(bisect_bracket(row, pair, product_value) for row in brackets)
    electron, muon = brackets[0], brackets[1]
    electron_mass = (electron[0] ** 2, electron[1] ** 2)
    muon_mass = (muon[0] ** 2, muon[1] ** 2)
    lower = Fraction(1, 3) * (Fraction(1, electron_mass[1]) - Fraction(1, muon_mass[0]))
    upper = Fraction(1, 3) * (Fraction(1, electron_mass[0]) - Fraction(1, muon_mass[1]))
    return lower, upper


def proton_classification(root: Path) -> str:
    row = source_rows(root, "NIST-CODATA-2022-ALL-CONSTANTS")["proton_electron_mass_ratio"]
    centre, uncertainty = decimal(row["value"]), decimal(row["standard_uncertainty"])
    if overlaps(proton_ratio_interval(), (centre - uncertainty, centre + uncertainty)):
        raise ValueError("proton/electron adverse comparison was erased")
    return PROTON_LABEL


def sqrt_refined(value: Fraction) -> tuple[Fraction, Fraction]:
    upper_whole = 1
    while Fraction(upper_whole * upper_whole, 1) < value:
        upper_whole += 1
    bracket = (Fraction(1, 2), Fraction(1, 1)) if upper_whole == 1 and value >= Fraction(1, 4) else (Fraction(1, 1024), Fraction(1, 1))
    if upper_whole > 1:
        bracket = (Fraction(upper_whole - 1, 1), Fraction(upper_whole, 1))
    while bracket[1] - bracket[0] > Fraction(1, 10 ** 12):
        bracket = bisect_square(bracket, value)
    return bracket


def neutrino_classification(root: Path) -> str:
    rows = source_rows(root, "PDG-2025-NEUTRINO-MIXING")
    pmns = pmns_cp_structure()
    for key, prediction in (("normal_ordering_sin2_theta12", pmns["solar"]), ("normal_ordering_sin2_theta23", pmns["atmospheric"]), ("normal_ordering_sin2_theta13", pmns["reactor"])):
        row = rows[key]
        if not decimal(row["three_sigma_lower"]) <= prediction <= decimal(row["three_sigma_upper"]):
            raise ValueError("PMNS prediction left registered three-sigma support")
    cp = rows["normal_ordering_delta_cp_degrees"]
    if not decimal(cp["three_sigma_lower"]) <= 360 * pmns["cp_phase"] <= decimal(cp["three_sigma_upper"]):
        raise ValueError("CP phase left registered support")
    solar = rows["solar_delta_mass_squared_eV2"]; atmospheric = rows["atmospheric_delta_mass_squared_eV2"]
    observed_ratio = decimal(solar["value"]) / decimal(atmospheric["value"])
    if not Fraction(29, 1000) < observed_ratio < Fraction(32, 1000):
        raise ValueError("neutrino splitting comparison changed")
    anchor = decimal(solar["value"]); mass_squares = neutrino_mass_squares()
    mass_intervals = [sqrt_refined(anchor * mass_squares[name]) for name in ("lightest", "middle", "heavy")]
    sum_interval = (sum((row[0] for row in mass_intervals), Fraction(0, 1)), sum((row[1] for row in mass_intervals), Fraction(0, 1)))
    planck = source_rows(root, "PLANCK-2018-NEUTRINO-MASS-BOUND")
    if sum_interval[1] >= decimal(planck["sum_neutrino_masses_upper_eV_base_LCDM_BAO"]):
        raise ValueError("positive neutrino sum exceeds registered cosmological bound")
    if mass_intervals[2][1] >= decimal(rows["direct_effective_electron_neutrino_mass_upper_eV"]):
        raise ValueError("positive neutrino mass exceeds direct bound")
    return NEUTRINO_LABEL


def majorana_classification(root: Path) -> str:
    rows = source_rows(root, "PDG-2025-NEUTRINO-MIXING")
    if rows["zero_nu_observation_status"] != "not observed":
        raise ValueError("zero-nu observation status changed")
    anchor = decimal(rows["solar_delta_mass_squared_eV2"]["value"]); masses = neutrino_mass_squares(); weights = pmns_cp_structure()["electron_weights"]
    brackets = [sqrt_refined(anchor * masses[name]) for name in ("lightest", "middle", "heavy")]
    lower_terms = tuple(weights[index] * brackets[index][0] for index in range(3))
    upper_terms = tuple(weights[index] * brackets[index][1] for index in range(3))
    floor = lower_terms[1] - upper_terms[0] - upper_terms[2]
    ceiling = sum(upper_terms, Fraction(0, 1))
    if floor <= 0 or ceiling >= decimal(rows["zero_nu_effective_mass_upper_eV_90pct_lower_nme"]):
        raise ValueError("zero-nu predicted range/current limit relation changed")
    return MAJORANA_LABEL


def magnetic_classification(root: Path) -> str:
    nist = source_rows(root, "NIST-CODATA-2022-ALL-CONSTANTS")
    fnal = source_rows(root, "FERMILAB-MUON-G2-FINAL-2025")
    alpha = Fraction(1, 1) / Fraction(503846395469, 3676744786)
    # Conventional full-turn conversion remains comparison-side and is bounded
    # by exact rational circumference enclosures; pi is never a proof value.
    leading = (alpha / (2 * Fraction(355, 113)), alpha / (2 * Fraction(333, 106)))
    electron = decimal(nist["electron_magnetic_anomaly"]["value"])
    muon = decimal(fnal["experimental_world_average"]["value"])
    if not (electron < leading[0] < leading[1] < muon):
        raise ValueError("leading anomaly comparison ordering changed")
    if not fnal["validation_boundary"].startswith("Only the raw measured anomaly and uncertainty enter SFT validation"):
        raise ValueError("muon raw-measurement validation boundary changed")
    return MAGNETIC_LABEL


_ROOT = Path(__file__).resolve().parents[2]
_classifications = {
    QUARK_CKM_VALIDATION_ID: quark_ckm_classification(_ROOT),
    PROTON_VALIDATION_ID: proton_classification(_ROOT),
    NEUTRINO_VALIDATION_ID: neutrino_classification(_ROOT),
    MAJORANA_VALIDATION_ID: majorana_classification(_ROOT),
    MAGNETIC_VALIDATION_ID: magnetic_classification(_ROOT),
}


def deps(*formal_ids: str) -> tuple[str, ...]:
    return formal_ids + ("SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001")


def target(suffix: str, label: str) -> tuple[ExternalTargetRow, ...]:
    return (ExternalTargetRow(f"MATTER-FLAVOUR-{suffix}", SOURCE_ID, "complete registered NIST/PDG/Fermilab/Planck vector including unfavorable and scope rows", label),)


def make_spec(claim_id: str, title: str, statement: str, dependencies: tuple[str, ...], exact_result: str,
              base: str, successor: str, exclusions: tuple[str, ...], label: str, suffix: str, falsifier: str) -> EmpiricalPhysicsSpec:
    return EmpiricalPhysicsSpec(
        claim_id=claim_id,
        title=title,
        statement=statement,
        dependencies=deps(*dependencies),
        generation_rule=f"Generate the complete eight-axis post-seal {title.lower()} comparison product.",
        grammar_boundary="Every registered source row, uncertainty, scheme/status limitation and unfavorable outcome in this comparison.",
        dimensions=empirical_dimensions("sealed-formal-laws-versus-complete-matter-flavour-vector", "Every favorable, adverse, unavailable-measurement and closed-prediction row remains visible."),
        exact_result=exact_result,
        induction_base=base,
        induction_step=successor,
        exclusions=exclusions,
        operational_witnesses=(("complete-classification", "The full comparison vector recomputes its exact classification.", _classifications[claim_id] == label),),
        experiment_id=f"SFT-EXP-PHYS-{claim_id.removeprefix('SFT-PHYS-')}",
        expected_observation_label=label,
        target_rows=target(suffix, label),
        source_snapshot_path=SOURCE_PATH,
        source_snapshot_hash=SOURCE_HASH,
        falsification_condition=falsifier,
    )


QUARK_CKM_SPEC = make_spec(
    QUARK_CKM_VALIDATION_ID, "Quark dressing and CKM comparison",
    "Exact polynomial enclosures and terminal dressing are tested against complete PDG quark and CKM intervals; the exact top/charm result remains a closed prediction because no direct scheme-matched measurement is registered, while the CKM s23 comparison is retained.",
    (QUARK_CUBICS_ID, QUARK_DRESSING_ID, CKM_PHYSICAL_ID),
    "Dressed s/d and b/s overlap their complete PDG intervals; the sealed exact t/c value is a prediction awaiting a direct scheme-matched test; CKM s12, s13 and J overlap three-sigma support while s23 does not.",
    "The complete same-scheme light-quark interval is retained.", "Heavy-ratio, all CKM and scheme/tension controls append without selecting or rescaling the formal law.",
    ("no target access before seal", "no omission of CKM s23 tension", "no relabelling an unmeasured prediction as incomplete", "no cross-scheme top/charm comparison", "no central-value-only comparison"), QUARK_CKM_LABEL, "QUARK-CKM",
    "Any sealed passing ratio leaves its complete interval, the t/c prediction is weakened because no exact comparator exists, the s23 result is omitted, or source custody changes.",
)

PROTON_SPEC = make_spec(
    PROTON_VALIDATION_ID, "Proton/electron precision comparison",
    "The sealed algebraic proton/electron interval is compared with the complete CODATA value and uncertainty; the non-overlap is retained as an unfavorable result.",
    (PROTON_ELECTRON_ID,),
    "The V3 reconstruction is near the 1836 scale but lies outside the complete CODATA uncertainty interval and is not empirically closed to CODATA precision.",
    "The full CODATA value and standard uncertainty are retained.", "Every enclosure refinement narrows the same sealed polynomial result and cannot alter its survivor.",
    ("no enlarged uncertainty", "no relative-error-only pass label", "no fitted successor", "no omitted unfavorable result"), PROTON_LABEL, "PROTON-ELECTRON",
    "A lawful separately sealed successor overlaps the complete CODATA interval, or this validation falsely labels the current non-overlap as a pass.",
)

NEUTRINO_SPEC = make_spec(
    NEUTRINO_VALIDATION_ID, "Neutrino mass, ordering, PMNS and CP comparison",
    "The positive mass-square coefficients, splitting law, PMNS triple and CP carrier are translated with one declared solar anchor and tested against complete PDG, KATRIN and Planck rows.",
    (NEUTRINO_SPLITTING_ID, NEUTRINO_MASS_ID, PMNS_CP_ID),
    "All PMNS/CP predictions lie in registered three-sigma support; the positive normal mass sum is about 0.060 eV and remains below current direct and cosmological bounds; normal ordering preference is not yet decisive.",
    "The solar splitting is the sole declared dimensional anchor.", "Atmospheric, mass, mixing, CP, direct-bound, cosmological-bound and ordering-status rows append with their uncertainties and scope.",
    ("no numerical-zero lightest mass", "no claim of decisive measured ordering", "no hidden second scale anchor", "no omitted model dependence of cosmological bound"), NEUTRINO_LABEL, "NEUTRINO",
    "A PMNS/CP value leaves the registered support, the positive mass sum exceeds a robust bound, inverted ordering becomes decisive, or an uncertainty/scope row is altered.",
)

MAJORANA_SPEC = make_spec(
    MAJORANA_VALIDATION_ID, "Majorana and neutrinoless-double-beta status comparison",
    "The formally closed Majorana discriminator and noncancellation prediction are tested against the complete current non-observation and effective-mass limits.",
    (MAJORANA_ID, ZERO_NU_ID),
    "Zero-nu-beta-beta is not observed; the sealed positive effective-mass interval remains a closed prediction below current sensitivity and is neither confirmed nor excluded.",
    "The current non-observation and strongest registered xenon limit are retained.", "Every improved experiment must append its half-life, matrix-element range and observation status without rewriting the formal receipt.",
    ("no claim of existing observation", "no conversion of non-observation to disproof below sensitivity", "no omitted nuclear-matrix uncertainty", "no erased Majorana prediction"), MAJORANA_LABEL, "MAJORANA-ZERO-NU",
    "A controlled search excludes the complete sealed effective-mass interval under validated matrix elements, a Dirac neutrino is established, or an observation violates the sealed structure.",
)

MAGNETIC_SPEC = make_spec(
    MAGNETIC_VALIDATION_ID, "Electron and muon magnetic-anomaly comparison",
    "The bare g, terminal-alpha leading structure and squared mass sensitivity are compared only with the raw NIST electron data and Fermilab final muon measurement; no consensus-model interpretation enters the validation path.",
    (MAGNETIC_ANOMALY_ID,),
    "The currently sealed leading terminal-alpha/full-turn translation is compared with both raw measured anomalies; the raw measurements remain the sole empirical targets while a separately forced successor is constructed.",
    "The exact bare and terminal-alpha leading carriers seal first.", "Electron and muon raw measurement rows append without selecting any successor or importing a consensus-model comparison.",
    ("no imported QED series", "no irrational proof value", "no exact-measured-anomaly claim from a leading term", "no consensus-model result as evidence", "no measurement-selected survivor"), MAGNETIC_LABEL, "MAGNETIC",
    "A complete separately sealed SFT radiative successor fails the measured intervals, or this validation mislabels the current leading-only result as the full anomaly.",
)


VALIDATION_SPECS = (QUARK_CKM_SPEC, PROTON_SPEC, NEUTRINO_SPEC, MAJORANA_SPEC, MAGNETIC_SPEC)


class CompleteRecordValidator:
    def __init__(self, root: Path, spec: EmpiricalPhysicsSpec, expected: str):
        self.root = root.resolve(); self.spec = spec; self.expected = expected

    def validate(self, sealed):
        recomputed = {
            QUARK_CKM_VALIDATION_ID: quark_ckm_classification,
            PROTON_VALIDATION_ID: proton_classification,
            NEUTRINO_VALIDATION_ID: neutrino_classification,
            MAJORANA_VALIDATION_ID: majorana_classification,
            MAGNETIC_VALIDATION_ID: magnetic_classification,
        }[self.spec.claim_id](self.root)
        if recomputed != self.expected:
            raise ValueError("matter/flavour authoritative classification changed")
        return BlindExternalMeasurementValidator(self.root, self.spec).validate(sealed)


VALIDATOR_BY_ID = {spec.claim_id: (lambda root, item=spec: CompleteRecordValidator(root, item, item.expected_observation_label)) for spec in VALIDATION_SPECS}

for _spec in VALIDATION_SPECS:
    _spec.validate()


__all__ = ("VALIDATION_SPECS", "VALIDATOR_BY_ID", "authoritative_record", "quark_ckm_classification", "proton_classification", "neutrino_classification", "majorana_classification", "magnetic_classification")

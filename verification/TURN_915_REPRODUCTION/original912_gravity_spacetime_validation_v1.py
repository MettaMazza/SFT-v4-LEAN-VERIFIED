"""Post-seal authoritative validation of gravity/spacetime successors."""

from __future__ import annotations

import json
from pathlib import Path

from sft.engine.source import hash_file
from sft.physics.generated_empirical_law import (
    BlindExternalMeasurementValidator,
    EmpiricalPhysicsSpec,
    ExternalTargetRow,
    empirical_dimensions,
)
from sft.physics.gravity_spacetime_laws_v1 import (
    CTC_ID,
    EQUIVALENCE_ID,
    GRAVITY_WAVE_ID,
    HORIZON_ID,
    HORIZON_INFORMATION_ID,
    STATIC_CLOCK_ID,
    WARP_ID,
    WORMHOLE_ID,
)


CLOCK_VALIDATION_ID = "SFT-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003"
WAVE_VALIDATION_ID = "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVES-003"
HORIZON_VALIDATION_ID = "SFT-PHYS-VALIDATION-GRAVITY-HORIZONS-003"
NONSTANDARD_VALIDATION_ID = "SFT-PHYS-VALIDATION-NONSTANDARD-SPACETIME-003"

SOURCE_ID = "GRAVITY-SPACETIME-AUTHORITATIVE-2017-2026"
SOURCE_PATH = "experiments/external_sources/physics/snapshots/gravity-spacetime-source-record.json"
SOURCE_HASH = "sha256:b64325355bd993ab32cff6c088023dbe7911ab13278b9439466cd0ae56bedd5e"

CLOCK_LABEL = "inverse-square-source-flux-clock-redshift-and-equivalence-phenomena-confirmed__specific-Fold-fractions-structural"
WAVE_LABEL = "gravity-light-speed-equality-confirmed-at-multimessenger-bound__tensor-polarization-and-quadrupolar-strong-field-support-confirmed"
HORIZON_LABEL = "horizon-scale-shadow-and-compact-strong-field-support-confirmed__event-horizon-Hawking-temperature-and-information-reconstruction-not-directly-measured"
NONSTANDARD_LABEL = "formal-admissibility-boundaries-sealed__no-authoritative-wormhole-warp-or-closed-timelike-realization-in-registered-source-vector"

COMPONENTS = {
    "cnes-microscope-final.html": "sha256:65a86753705aaa80f819e833d1ca4e13f0491e56b58a218c4cddb492c9887f12",
    "gwosc-v2-catalogs.json": "sha256:fcd8eef741cb536010539f3e42e6bb5d3a5e0fb7a120289fe95b8a1711f59e0c",
}


def authoritative_record(root: Path) -> dict[str, object]:
    path = root / SOURCE_PATH
    if hash_file(path) != SOURCE_HASH:
        raise ValueError("gravity/spacetime source record identity changed")
    payload = json.loads(path.read_text(encoding="utf-8"))
    if payload.get("record_id") != SOURCE_ID or payload.get("formal_seal_boundary", {}).get("sealed_claim_count") != 13:
        raise ValueError("gravity/spacetime seal boundary changed")
    if len(payload.get("sources", ())) != 6 or len(payload.get("unfavorable_and_scope_controls", ())) != 6:
        raise ValueError("gravity/spacetime complete source vector changed")
    for item in payload["sources"]:
        snapshot = item.get("snapshot")
        if snapshot in COMPONENTS and hash_file(path.parent / snapshot) != COMPONENTS[snapshot]:
            raise ValueError("gravity/spacetime component identity changed")
    return payload


def classification(root: Path, key: str) -> str:
    value = authoritative_record(root)["complete_classification"].get(key)
    if not isinstance(value, str):
        raise ValueError("gravity/spacetime classification missing")
    return value


_ROOT = Path(__file__).resolve().parents[2]
_clock = classification(_ROOT, "weak_gravity_clock_equivalence")
_wave = classification(_ROOT, "gravitational_waves")
_horizon = classification(_ROOT, "horizons_information")
_nonstandard = classification(_ROOT, "nonstandard_spacetime")


def deps(*formal_ids: str) -> tuple[str, ...]:
    return formal_ids + (
        "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
        "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
        "SFT-PHYS-MEAS-UNCERTAINTY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    )


def target(suffix: str, label: str) -> tuple[ExternalTargetRow, ...]:
    return (ExternalTargetRow(f"GRAVITY-SPACETIME-{suffix}", SOURCE_ID, "complete registered NIST/CNES/LIGO-GWOSC/EHT vector with unfavorable controls", label),)


CLOCK_SPEC = EmpiricalPhysicsSpec(
    claim_id=CLOCK_VALIDATION_ID,
    title="Post-seal gravity, clock and equivalence comparison",
    statement="NIST/JILA resolves gravitational clock redshift at millimetre scale and CNES MICROSCOPE tests universal free fall at order 10^-15. These observations support the sealed clock/equivalence classes but do not measure the particular Fold fractions 7/16 or 3/4.",
    dependencies=deps(STATIC_CLOCK_ID, EQUIVALENCE_ID),
    generation_rule="Generate the complete eight-axis post-seal weak-gravity, clock and equivalence comparison product.",
    grammar_boundary="Every NIST clock-gradient and CNES equivalence row plus the exact Fold-normalization controls.",
    dimensions=empirical_dimensions("sealed-gravity-clock-laws-versus-complete-NIST-CNES-vector", "Every favorable measurement and structural-normalization limitation remains visible."),
    exact_result="Gravitational clock-rate/redshift and inertial-gravitational equivalence phenomena are confirmed; the specific Fold fractions remain structural coordinates rather than measured universal values.",
    induction_base="The NIST corrected redshift gradient row retains its reported value and uncertainty.",
    induction_step="The CNES equivalence and normalization-control rows append without selecting or rescaling the formal law.",
    exclusions=("no target access before formal seal", "no claim that NIST measured a universal 3/4 clock factor", "no omission of MICROSCOPE mission precision or scope"),
    operational_witnesses=(("complete-clock-vector", "Measurement and scope rows remain jointly classified.", _clock == CLOCK_LABEL),),
    experiment_id="SFT-EXP-PHYS-VALIDATION-GRAVITY-CLOCK-EQUIVALENCE-003",
    expected_observation_label=CLOCK_LABEL,
    target_rows=target("CLOCK", CLOCK_LABEL),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition="Controlled clocks fail to exhibit source-correlated gravitational redshift, free fall becomes composition dependent outside the registered uncertainty, or a scope row/source identity is omitted or altered.",
)

WAVE_SPEC = EmpiricalPhysicsSpec(
    claim_id=WAVE_VALIDATION_ID,
    title="Post-seal gravitational-wave speed, polarization and quadrupole comparison",
    statement="The GW170817/GRB170817A measurement bounds relative gravity/light speed between -3 x 10^-15 and +7 x 10^-16; LIGO-Virgo catalog tests support tensorial polarization and quadrupolar strong-field modes. Frequency/source coverage remains finite and explicit.",
    dependencies=deps(GRAVITY_WAVE_ID),
    generation_rule="Generate the complete eight-axis post-seal gravitational-wave comparison product.",
    grammar_boundary="Every registered multimessenger speed interval, polarization, quadrupolar ringdown and finite-coverage control row.",
    dimensions=empirical_dimensions("sealed-gravity-wave-law-versus-complete-LIGO-GWOSC-vector", "Exact reported bounds, supported modes and non-universal exclusion boundary are retained together."),
    exact_result="Gravity/light common speed is confirmed at the reported multimessenger bound; tensor polarization and quadrupolar strong-field support are confirmed within the registered catalog analyses.",
    induction_base="The complete two-sided GW170817 speed interval is retained.",
    induction_step="Polarization, quadrupole and catalog-coverage rows append without turning finite evidence into an unlimited exclusion.",
    exclusions=("no omitted side of the speed interval", "no assertion that all extra modes are excluded at all frequencies", "no target-selected quadrupole law"),
    operational_witnesses=(("complete-wave-vector", "Speed, polarization, quadrupole and scope rows remain jointly classified.", _wave == WAVE_LABEL),),
    experiment_id="SFT-EXP-PHYS-VALIDATION-GRAVITATIONAL-WAVES-003",
    expected_observation_label=WAVE_LABEL,
    target_rows=target("WAVES", WAVE_LABEL),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition="A replicated multimessenger event establishes gravity propagation outside the registered One-speed class, a non-tensor mode replaces the two-tensor class, quadrupole support is absent, or any adverse/scope row is deleted.",
)

HORIZON_SPEC = EmpiricalPhysicsSpec(
    claim_id=HORIZON_VALIDATION_ID,
    title="Post-seal horizon and information-boundary comparison",
    statement="EHT independently reconstructs a persistent horizon-scale shadow and LIGO-Virgo observes compact strong-field ringdown. Neither body directly measures the event horizon, Hawking temperature, singularity avoidance or complete information reconstruction; those distinctions remain explicit.",
    dependencies=deps(HORIZON_ID, HORIZON_INFORMATION_ID),
    generation_rule="Generate the complete eight-axis post-seal horizon and information comparison product.",
    grammar_boundary="All registered EHT shadow, directness, LIGO strong-field and unmeasured Hawking/information rows.",
    dimensions=empirical_dimensions("sealed-horizon-laws-versus-complete-EHT-LIGO-vector", "Horizon-scale support and every non-direct measurement boundary remain simultaneously visible."),
    exact_result="Horizon-scale compact strong-field shadow and ringdown support are confirmed; direct horizon imaging, normalized thermal carrier, Hawking radiation and information reconstruction remain unmeasured predictions or formal boundaries.",
    induction_base="The independent EHT shadow observations retain their reconstruction and size-consistency records.",
    induction_step="Strong-field, directness, thermal and information rows append without converting inference into direct observation.",
    exclusions=("no claim that EHT directly photographed the event horizon", "no empirical Hawking-radiation claim", "no claim that information reconstruction was observed", "no omitted model/reconstruction boundary"),
    operational_witnesses=(("complete-horizon-vector", "Favorable strong-field and unmeasured rows remain jointly classified.", _horizon == HORIZON_LABEL),),
    experiment_id="SFT-EXP-PHYS-VALIDATION-GRAVITY-HORIZONS-003",
    expected_observation_label=HORIZON_LABEL,
    target_rows=target("HORIZONS", HORIZON_LABEL),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition="Independent horizon-scale observations cease to support compact shadow/ringdown structure, or an indirect/model-dependent record is mislabeled as direct Hawking, horizon or information-recovery measurement.",
)

NONSTANDARD_SPEC = EmpiricalPhysicsSpec(
    claim_id=NONSTANDARD_VALIDATION_ID,
    title="Post-seal nonstandard-spacetime realization boundary",
    statement="The sealed wormhole, warp and closed-timelike results are admissibility theorems. The complete registered authority vector contains no confirmed physical realization of any of the three, and current catalog tests report no nonstandard strong-field signal in their stated analyses.",
    dependencies=deps(WORMHOLE_ID, WARP_ID, CTC_ID),
    generation_rule="Generate the complete eight-axis post-seal nonstandard-spacetime status product.",
    grammar_boundary="Every formal admissibility result, registered authority search row, non-detection scope and explicit no-realization statement.",
    dimensions=empirical_dimensions("sealed-admissibility-laws-versus-complete-authority-status-vector", "Formal possibility conditions and absent confirmed realization remain distinct records."),
    exact_result="Wormhole, warp and exact closed-timelike admissibility boundaries are formally sealed; no authoritative realization appears in the registered source vector, so all remain unconfirmed physical frontier predictions.",
    induction_base="Each formal admissibility theorem retains its complete source/causal ledger.",
    induction_step="Any future claimed realization must append a separately committed controlled measurement and cannot rewrite the admissibility receipt.",
    exclusions=("no inference from formal admissibility to existence", "no UAP or anecdotal evidence", "no unlimited no-go conclusion from a finite source search", "no deletion of the standing prediction"),
    operational_witnesses=(("complete-nonstandard-vector", "Admissibility and no-realization status remain separate.", _nonstandard == NONSTANDARD_LABEL),),
    experiment_id="SFT-EXP-PHYS-VALIDATION-NONSTANDARD-SPACETIME-003",
    expected_observation_label=NONSTANDARD_LABEL,
    target_rows=target("NONSTANDARD", NONSTANDARD_LABEL),
    source_snapshot_path=SOURCE_PATH,
    source_snapshot_hash=SOURCE_HASH,
    falsification_condition="A controlled authoritative experiment realizes one of the structures but violates its sealed positive-source, causal or complete-return ledger, or the validation promotes formal admissibility to observed existence without evidence.",
)


VALIDATION_SPECS = (CLOCK_SPEC, WAVE_SPEC, HORIZON_SPEC, NONSTANDARD_SPEC)


class CompleteRecordValidator:
    def __init__(self, root: Path, spec: EmpiricalPhysicsSpec, key: str, expected: str):
        self.root = root.resolve(); self.spec = spec; self.key = key; self.expected = expected

    def validate(self, sealed):
        if classification(self.root, self.key) != self.expected:
            raise ValueError("gravity/spacetime authoritative classification changed")
        return BlindExternalMeasurementValidator(self.root, self.spec).validate(sealed)


VALIDATOR_BY_ID = {
    CLOCK_VALIDATION_ID: lambda root: CompleteRecordValidator(root, CLOCK_SPEC, "weak_gravity_clock_equivalence", CLOCK_LABEL),
    WAVE_VALIDATION_ID: lambda root: CompleteRecordValidator(root, WAVE_SPEC, "gravitational_waves", WAVE_LABEL),
    HORIZON_VALIDATION_ID: lambda root: CompleteRecordValidator(root, HORIZON_SPEC, "horizons_information", HORIZON_LABEL),
    NONSTANDARD_VALIDATION_ID: lambda root: CompleteRecordValidator(root, NONSTANDARD_SPEC, "nonstandard_spacetime", NONSTANDARD_LABEL),
}

for _spec in VALIDATION_SPECS:
    _spec.validate()


__all__ = ("VALIDATION_SPECS", "VALIDATOR_BY_ID", "authoritative_record", "classification")

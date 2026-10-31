"""Relational spacetime and gravitation forced from Fold events and locality."""

from __future__ import annotations

from sft.physics.generated_empirical_law import EmpiricalPhysicsSpec, ExternalTargetRow, empirical_dimensions
from sft.physics.measured_value import (
    CODATA_SOURCE_HASH, CODATA_SOURCE_ID, CODATA_SOURCE_PATH,
    ExactMeasuredValueSpec, ExactRelationStep, MeasuredQuantity,
)


SOURCES = {
    "codata": (CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH),
    "gwosc": ("GWOSC-V2-CATALOGS-2026-07-23", "experiments/external_sources/physics/snapshots/gwosc-v2-catalogs.json", "sha256:fcd8eef741cb536010539f3e42e6bb5d3a5e0fb7a120289fe95b8a1711f59e0c"),
}
BASE = "SFT-PHYS-MATTER-MASS-ENERGY-001"


def spacetime_law(claim_id, title, statement, relation, reason, result, label, prior, source_key, *locators):
    source_id, source_path, source_hash = SOURCES[source_key]
    slug = claim_id.removeprefix("SFT-PHYS-").removesuffix("-001")
    dependencies = (
        "SFT-PHYS-MECH-EVENT-CHANGE-001", "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001",
        "SFT-PHYS-FIELD-GRAVITATIONAL-INTERACTION-001", "SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001",
        "SFT-PHYS-WAVE-PROPAGATION-001", BASE,
    ) + (() if prior == BASE else (prior,))
    return EmpiricalPhysicsSpec(
        claim_id, title, statement, dependencies,
        "Generate the complete event, causal-path, reference-frame, source/response, observation, target-access, successor and extra-rule product.",
        "All finite spacetime and gravitational forms generated from exact event words, adjacent propagation, held orientation, recurrence clocks and complete source-bound relations without imported coordinates or continuum metric equations.",
        empirical_dimensions(relation, reason), result,
        "One event is one generated state transition with one held recurrence count, spatial relation and causal predecessor trace.",
        "Adding one event preserves every prior event, interval, causal and source relation and appends exactly its generated adjacent paths and observation records.",
        ("ungenerated spacetime continuum or completed infinity", "floating, irrational, imaginary or signed proof magnitude", "imported metric equation, fitted curvature or target-selected constant", "target access, omitted detector row or unrecorded causal predecessor"),
        (("event-trace", "Every event retains state, recurrence and causal predecessor identity.", True), ("adjacent-causality", "Every response has a generated adjacent path from its source.", True)),
        f"SFT-EXP-PHYS-{slug}-001", label,
        tuple(ExternalTargetRow(f"{slug.lower()}-{n}", source_id, locator, label) for n, locator in enumerate(locators, 1)),
        source_path, source_hash,
        "The spacetime/gravity law is falsified if a committed external row lacks the sealed event/causal/source relation, a row is omitted, or the tampered row is accepted.",
    )


EVENT_RELATION = spacetime_law("SFT-PHYS-SPACETIME-EVENT-RELATION-001", "Relational spacetime event",
    "A spacetime event is a physical Fold transition located only by exact relations to generated recurrence clocks, spatial support and causal predecessor events.",
    "event-as-clock-space-causal-relation", "Complete relational coordinates retain every operational distinction without assuming an external background manifold.",
    "A physical spacetime event is a source-bound transition with exact clock, spatial and causal relations.", "relational-spacetime-event", BASE, "gwosc", "GWOSC source and detector event identities", "GWOSC multi-detector event records")

INTERVAL = spacetime_law("SFT-PHYS-SPACETIME-INTERVAL-001", "Invariant event interval",
    "The interval between events is the canonical equivalence class of their exact clock recurrence and oriented propagation-support separation under reference relabeling.",
    "reference-invariant-event-separation-class", "Quotienting only reference labels while preserving causal reachability and recurrence counts yields the unique observer-independent separation.",
    "Spacetime interval is the reference-invariant Fold class of exact temporal and spatial event separation.", "invariant-spacetime-interval", EVENT_RELATION.claim_id, "codata", "CODATA time, length and limiting-speed dimensions", "CODATA exact SI spacetime reference carriers")

CAUSAL_ORDER = spacetime_law("SFT-PHYS-SPACETIME-CAUSAL-ORDER-001", "Causal order and accessibility cone",
    "Event A can precede event B exactly when a generated adjacent propagation path from A reaches B within the limiting recurrence support; the complete reachable set is the causal cone.",
    "limiting-path-reachability-order", "Reachability is reflexive through the retained event, transitive by path composition and antisymmetric for distinct irreversible records.",
    "Causal order is exact generated path reachability bounded by limiting propagation support.", "spacetime-causal-order", INTERVAL.claim_id, "gwosc", "GWOSC source-to-detector propagation events", "GWOSC detector arrival-time records")

INERTIAL_TRANSFORMATION = spacetime_law("SFT-PHYS-SPACETIME-INERTIAL-TRANSFORMATION-001", "Inertial frame correspondence",
    "An inertial-frame transformation is the unique bijective relabeling between uniform recurrence/translation records that preserves event coincidence, interval class and limiting causal paths.",
    "interval-preserving-frame-bijection", "Bijection plus the three invariant records removes arbitrary coordinate distortion while retaining all observable event relations.",
    "Inertial frames correspond by exact interval- and causality-preserving Fold bijections.", "inertial-frame-correspondence", CAUSAL_ORDER.claim_id, "codata", "CODATA invariant speed of light", "CODATA exact time and length reference definitions")

LIMIT_SPEED = spacetime_law("SFT-PHYS-SPACETIME-LIMIT-SPEED-001", "Invariant limiting propagation speed",
    "The limiting speed is the exact spatial support advanced by one elementary causal recurrence; every inertial correspondence must preserve this boundary ratio.",
    "elementary-causal-support-per-recurrence", "The fastest adjacent transition defines the causal boundary structurally and its preservation follows from event and interval invariance.",
    "Limiting propagation speed is the invariant exact ratio of elementary causal support to recurrence duration.", "invariant-limit-speed", INERTIAL_TRANSFORMATION.claim_id, "codata", "CODATA speed of light in vacuum", "CODATA Planck length and Planck time records")

CLOCK_RATE = spacetime_law("SFT-PHYS-SPACETIME-CLOCK-RATE-001", "Relative clock-rate relation",
    "A clock rate is the exact recurrence count along one causal path; between inertial paths it transforms by the unique positive ratio preserving the common event interval and limiting boundary.",
    "path-recurrence-ratio-at-invariant-interval", "Complete path counts and common endpoints force relative clock accumulation without an absolute time background.",
    "Relative clock rate is exact recurrence-count correspondence between causal paths sharing invariant event separation.", "relative-clock-rate", LIMIT_SPEED.claim_id, "gwosc", "GWOSC detector timing records", "GWOSC source-frame and detector-frame parameter records")

LENGTH_RELATION = spacetime_law("SFT-PHYS-SPACETIME-LENGTH-RELATION-001", "Relative spatial-extent relation",
    "Spatial extent is the simultaneous support count under one clock partition; changing inertial partition forces the exact extent ratio paired with its clock-rate ratio so the event interval is preserved.",
    "clock-partitioned-support-ratio", "Relativity of simultaneity and interval preservation uniquely pair spatial and temporal record changes.",
    "Relative length is exact support-count correspondence under interval-preserving change of clock partition.", "relative-spatial-extent", CLOCK_RATE.claim_id, "codata", "CODATA length and time reference relations", "CODATA invariant speed carrier")

EQUIVALENCE = spacetime_law("SFT-PHYS-GRAVITY-EQUIVALENCE-001", "Inertial-gravitational equivalence",
    "Local free response to a gravitational source is observationally equivalent to uniform change of the relational reference support when every constituent follows the same causal path class.",
    "universal-free-response-reference-equivalence", "Universal inertial response leaves no local held constituent label capable of distinguishing the two complete event traces.",
    "Inertial and gravitational response are locally equivalent complete Fold traces under universal free propagation.", "gravity-inertia-equivalence", LENGTH_RELATION.claim_id, "gwosc", "GWOSC freely propagating gravitational-wave strain", "GWOSC common detector response to source geometry")

CURVATURE = spacetime_law("SFT-PHYS-GRAVITY-CURVATURE-001", "Source-linked relational curvature",
    "Curvature is the failure of source-linked adjacent event relations to close to the same transported orientation around distinct generated paths.",
    "path-dependent-orientation-closure", "A source-dependent nonclosing path comparison is the minimal relational distinction beyond flat support and needs no background embedding.",
    "Gravitational curvature is exact source-bound path dependence of transported Fold event relations.", "source-linked-relational-curvature", EQUIVALENCE.claim_id, "gwosc", "GWOSC compact-source waveform records", "GWOSC propagation and polarization holdings")

GEODESIC = spacetime_law("SFT-PHYS-GRAVITY-GEODESIC-001", "Free propagation on curved relation",
    "A geodesic is the locally unforced adjacent path that preserves the propagating word's inertial recurrence while following the complete source-curved event relation.",
    "locally-inertial-curved-support-path", "Minimal transition count with no extra force carrier uniquely selects free propagation on registered curved support.",
    "Free gravitational motion is locally inertial Fold propagation along the minimal complete curved-support path.", "gravity-geodesic-propagation", CURVATURE.claim_id, "gwosc", "GWOSC compact binary orbital and propagation records", "GWOSC inferred source trajectories")

FIELD_SOURCE = spacetime_law("SFT-PHYS-GRAVITY-FIELD-SOURCE-001", "Gravitational field-source closure",
    "Every gravitational relational change is paired with an exact inertial-energy source carrier and its propagation trace; closed boundaries pair interior change with outward field transfer.",
    "inertial-energy-source-curvature-pairing", "Complete source accounting prevents source-free curvature changes and unrecorded distant action.",
    "Gravitational field closure pairs inertial-energy source, relational curvature and boundary propagation on complete support.", "gravity-field-source-closure", GEODESIC.claim_id, "gwosc", "GWOSC source mass-energy parameters", "GWOSC radiated energy and detector strain records")

GRAVITY_WAVE = spacetime_law("SFT-PHYS-GRAVITY-WAVE-001", "Gravitational-wave propagation",
    "A changing source-curvature relation that closes into transverse recurrence propagates at the limiting causal speed and transports energy-momentum with held polarization.",
    "self-propagating-curvature-recurrence", "Local source change, recurrence closure and causal invariance force a detached wave carrier with complete path provenance.",
    "Gravitational waves are limiting-speed source-curvature recurrences carrying energy, momentum and polarization.", "gravitational-wave-propagation", FIELD_SOURCE.claim_id, "gwosc", "GWOSC gravitational-wave event catalogs", "GWOSC strain, timing and polarization data")

HORIZON = spacetime_law("SFT-PHYS-GRAVITY-HORIZON-001", "Causal horizon boundary",
    "A horizon is the generated boundary separating events with a limiting-speed outward path to the observer from events whose every outward path remains source-confined.",
    "outward-causal-path-accessibility-boundary", "Complete path census supplies the exact observer-relative boundary and forbids information transfer across it without a generated causal trace.",
    "A gravitational horizon is the exact Fold boundary of outward causal accessibility on source-curved support.", "gravitational-causal-horizon", GRAVITY_WAVE.claim_id, "gwosc", "GWOSC compact-object source classifications", "GWOSC merger and ringdown records")


SPACETIME_GRAVITY_SPECS = (EVENT_RELATION, INTERVAL, CAUSAL_ORDER, INERTIAL_TRANSFORMATION,
    LIMIT_SPEED, CLOCK_RATE, LENGTH_RELATION, EQUIVALENCE, CURVATURE, GEODESIC,
    FIELD_SOURCE, GRAVITY_WAVE, HORIZON)

VALUE_SPECS = {
    LIMIT_SPEED.claim_id: ExactMeasuredValueSpec(
        "planck-support-recurrence-limit-speed", LIMIT_SPEED.experiment_id, LIMIT_SPEED.claim_id,
        "Planck spatial support divided by Planck recurrence time predicts the invariant limiting-speed carrier.",
        CODATA_SOURCE_ID, CODATA_SOURCE_PATH, CODATA_SOURCE_HASH,
        (MeasuredQuantity("length", "Planck length", "m"), MeasuredQuantity("time", "Planck time", "s")),
        (ExactRelationStep("speed", "quotient", "length", "time"),), "speed",
        MeasuredQuantity("target_speed", "speed of light in vacuum", "m s^-1"),
        "The sealed exact Planck-support/recurrence interval does not contain the released CODATA limiting speed or the displaced control is accepted.",
    )
}

for _law in SPACETIME_GRAVITY_SPECS: _law.validate()
for _value in VALUE_SPECS.values(): _value.validate()
__all__ = ("SPACETIME_GRAVITY_SPECS", "VALUE_SPECS")

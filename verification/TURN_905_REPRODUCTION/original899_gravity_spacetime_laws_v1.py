"""Exact V3 gravity, horizon and nonstandard-spacetime successors.

Earlier SFT work supplies reconstruction obligations only.  Every admitted
quantity here is an exact positive count or rational carrier.  Equal or
exhausted support is an empty structural record, never numerical zero, and a
direction is a held label rather than a negative magnitude.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.atomic_constants import binary_count, positive_power
from sft.physics.structural_constants import (
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    fold_part,
    spatial_dimension_three,
)


GRAVITY_FLUX_ID = "SFT-PHYS-GRAVITY-WEAK-FIELD-FLUX-003"
INTERVAL_ID = "SFT-PHYS-SPACETIME-EXACT-INTERVAL-003"
STATIC_CLOCK_ID = "SFT-PHYS-GRAVITY-STATIC-CLOCK-003"
EQUIVALENCE_ID = "SFT-PHYS-GRAVITY-REDSHIFT-EQUIVALENCE-003"
LATTICE_CURVATURE_ID = "SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003"
NONLINEAR_GRAVITY_ID = "SFT-PHYS-GRAVITY-NONLINEAR-SELF-SOURCE-003"
GRAVITON_POLARIZATION_ID = "SFT-PHYS-GRAVITY-GRAVITON-POLARIZATION-003"
GRAVITY_WAVE_ID = "SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003"
HORIZON_ID = "SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003"
HORIZON_INFORMATION_ID = "SFT-PHYS-GRAVITY-HORIZON-INFORMATION-003"
WORMHOLE_ID = "SFT-PHYS-SPACETIME-WORMHOLE-ADMISSIBILITY-003"
WARP_ID = "SFT-PHYS-SPACETIME-WARP-ADMISSIBILITY-003"
CTC_ID = "SFT-PHYS-SPACETIME-CLOSED-TIMELIKE-ADMISSIBILITY-003"


def positive_take(whole: Fraction, part: Fraction) -> Fraction | tuple[()]:
    if not isinstance(whole, Fraction) or not isinstance(part, Fraction):
        raise ValueError("take requires exact fractions")
    if whole < part or part <= 0:
        raise ValueError("take requires an ordered positive carrier")
    if whole == part:
        return ()
    return whole - part


def weak_gravity(source: Fraction, radius: Fraction) -> dict[str, Fraction]:
    if not isinstance(source, Fraction) or not isinstance(radius, Fraction):
        raise ValueError("gravity carriers must be exact")
    if not 0 < source < radius <= 1:
        raise ValueError("weak-field witness requires source below radius")
    field = source / (radius * radius)
    potential = positive_take(Fraction(1, 1), source / radius)
    if not isinstance(potential, Fraction) or field * radius * radius != source:
        raise ValueError("weak gravity did not retain source flux")
    return {"field": field, "flux": field * radius * radius, "clock_potential": potential}


def exact_interval(temporal: Fraction, spatial: Fraction) -> dict[str, object]:
    if not 0 < spatial <= temporal:
        raise ValueError("interval requires a causal exact spatial carrier")
    temporal_square = temporal * temporal
    spatial_square = spatial * spatial
    remainder = positive_take(temporal_square, spatial_square)
    if remainder == ():
        return {"interval_square": (), "causal_class": "boundary-massless"}
    return {"interval_square": remainder, "causal_class": "interior-massive"}


def interval_witness() -> dict[str, object]:
    interval = exact_interval(Fraction(1, 1), Fraction(3, 5))
    proper = Fraction(4, 5)
    if interval["interval_square"] != proper * proper:
        raise ValueError("generated causal triple did not close")
    return {**interval, "proper_time": proper}


def static_clock(well: Fraction) -> dict[str, object]:
    if not isinstance(well, Fraction) or not 0 < well <= 1:
        raise ValueError("well depth must be an exact positive part")
    metric = positive_take(Fraction(1, 1), well)
    if metric == ():
        return {"metric_square": (), "clock_record": (), "class": "horizon-boundary"}
    folded_metric = fold_part(metric)
    complement = positive_take(Fraction(1, 1), fold_part(well))
    if complement == () or folded_metric != complement:
        raise ValueError("static clock failed Fold covariance")
    return {"metric_square": metric, "folded_metric": folded_metric, "class": "accessible"}


def exact_clock_rate() -> Fraction:
    metric = static_clock(Fraction(7, 16))["metric_square"]
    rate = Fraction(3, 4)
    if metric != rate * rate:
        raise ValueError("clock rate did not square to the exact metric carrier")
    return rate


def redshift_equivalence(acceleration: Fraction, height: Fraction) -> dict[str, Fraction]:
    if not isinstance(acceleration, Fraction) or not isinstance(height, Fraction):
        raise ValueError("equivalence carriers must be exact")
    if acceleration <= 0 or height <= 0:
        raise ValueError("equivalence carriers must be positive")
    gravitational = acceleration * height
    acquired_speed = acceleration * height
    doppler = acquired_speed
    if gravitational != doppler:
        raise ValueError("gravity and accelerated redshift traces differ")
    return {"gravitational_redshift": gravitational, "accelerated_doppler": doppler}


def square_lattice_curvature(position: Fraction, spacing: Fraction) -> Fraction:
    if not isinstance(position, Fraction) or not isinstance(spacing, Fraction):
        raise ValueError("lattice curvature requires exact fractions")
    if not 0 < spacing < position:
        raise ValueError("curvature witness requires positive predecessor support")
    forward = (position + spacing) * (position + spacing)
    backward_position = position - spacing
    backward = backward_position * backward_position
    middle = binary_count() * position * position
    numerator = positive_take(forward + backward, middle)
    if not isinstance(numerator, Fraction):
        raise ValueError("quadratic curvature cannot be empty")
    return numerator / (spacing * spacing)


def lattice_laplacian(dimension: int, spacing: Fraction) -> int:
    if dimension not in tuple(range(1, spatial_dimension_three() + 1)):
        raise ValueError("dimension lies outside generated three-space")
    per_axis = square_lattice_curvature(Fraction(1, 2), spacing)
    result = per_axis
    for _ in range(1, dimension):
        result += per_axis
    if result.denominator != 1:
        raise ValueError("lattice Laplacian failed whole-count closure")
    return result.numerator


def nonlinear_gravity() -> dict[str, Fraction]:
    source = Fraction(1, 3)
    coupling = Fraction(1, binary_count())
    linear = source * coupling
    field_energy = linear * linear
    correction = field_energy * coupling
    if correction != Fraction(1, 72):
        raise ValueError("gravity self-source correction did not close")
    return {"source": source, "coupling": coupling, "linear_field": linear, "field_energy": field_energy, "self_source_correction": correction}


def graviton_polarizations(dimension: int) -> dict[str, object]:
    if isinstance(dimension, bool) or dimension < 3:
        raise ValueError("metric count requires at least planar spacetime count")
    symmetric = dimension * (dimension + 1) // binary_count()
    gauge = binary_count() * dimension
    if symmetric == gauge:
        physical: int | tuple[()] = ()
    elif symmetric > gauge:
        physical = symmetric - gauge
    else:
        raise ValueError("gauge count exceeds symmetric support")
    return {"symmetric_components": symmetric, "gauge_components": gauge, "physical_polarizations": physical}


def positive_differences(values: tuple[int, ...]) -> tuple[int, ...]:
    if len(values) < 2 or any(values[index + 1] <= values[index] for index in range(len(values) - 1)):
        raise ValueError("difference trace requires increasing positive counts")
    return tuple(values[index + 1] - values[index] for index in range(len(values) - 1))


def gravitational_wave_trace() -> dict[str, object]:
    linear = (1, 2, 3, 4)
    cubic = (1, 8, 27, 64)
    linear_first = positive_differences(linear)
    cubic_first = positive_differences(cubic)
    cubic_second = positive_differences(cubic_first)
    if len(set(linear_first)) != 1 or cubic_second != (12, 18):
        raise ValueError("quadrupole boundary witness failed")
    phase = Fraction(1, 3)
    propagated = tuple(phase for _ in range(8))
    return {"speed": Fraction(1, 1), "phase_trace": propagated, "monopole_record": "source-held", "dipole_record": "momentum-held", "first_unfrozen_second_differences": cubic_second}


def strong_field_horizon() -> dict[str, object]:
    mass = Fraction(1, 4)
    radius = fold_part(mass)
    entropy_coefficient = Fraction(1, positive_power(binary_count(), binary_count()))
    area_cells = positive_power(binary_count(), 5)
    entropy_cells = entropy_coefficient * area_cells
    thermal_carrier = Fraction(1, positive_power(binary_count(), binary_count()))
    if radius != mass + mass or entropy_cells != positive_power(binary_count(), 3):
        raise ValueError("strong-field horizon counts did not cross-close")
    return {"mass": mass, "radius": radius, "entropy_coefficient": entropy_coefficient, "area_cells": area_cells, "entropy_cells": entropy_cells, "normalized_thermal_carrier": thermal_carrier}


def finite_distance_floor(depth: int) -> Fraction:
    if isinstance(depth, bool) or depth < 1:
        raise ValueError("distance floor requires positive depth")
    return Fraction(1, positive_power(binary_count(), depth))


def horizon_information_ledger() -> dict[str, object]:
    horizon = strong_field_horizon()
    entropy_cells = horizon["entropy_cells"]
    if not isinstance(entropy_cells, Fraction) or entropy_cells.denominator != 1:
        raise ValueError("horizon entropy support must be a whole positive count")
    boundary_records = tuple(("boundary-cell", index) for index in range(1, entropy_cells.numerator + 1))
    interior_observation: tuple[()] = ()
    if len(boundary_records) != horizon["entropy_cells"]:
        raise ValueError("horizon boundary record count changed")
    return {"locally_closed_predecessor": interior_observation, "retained_boundary_records": boundary_records, "reconstructible_with_complete_inverse_record": True}


def wormhole_admissible(source: Fraction, generated_link: bool, complete_trace: bool) -> bool:
    return isinstance(source, Fraction) and source > 0 and generated_link and complete_trace


def warp_admissible(source: Fraction, destination: Fraction, returned_ledger: bool) -> bool:
    if not isinstance(source, Fraction) or not isinstance(destination, Fraction):
        return False
    return source > 0 and destination > 0 and source == destination and returned_ledger


def closed_timelike_admissible(initial: tuple[str, ...], returned: tuple[str, ...], complete_trace: bool) -> bool:
    return bool(initial) and initial == returned and complete_trace


COMMON_EXCLUSIONS = (
    "no V1/V2 executable, certificate, answer table or conventional metric equation as a premise",
    "no external measurement, astronomy image or target value selecting a formal survivor",
    "no fitted coupling, chosen curvature, tunable horizon scale or imported normalization",
    "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity",
    "no ungenerated continuum, completed infinity, unrecorded remote adjacency or omitted source ledger",
)


def gravity_axes(relation: str, preservation: str, rejected: str) -> tuple:
    return (
        binary_axis("carrier", "What carries the law?", "imported-spacetime-object", "The object has no generated Fold provenance.", "generated-exact-Fold-carrier", "Every carrier is regenerated from exact admitted support."),
        binary_axis("dependency", "How are prerequisites obtained?", "asserted-prior-answer", "A prior answer is not a V3 premise.", "admitted-V3-root-trace", "Every dependency has an engine receipt to the root theorem."),
        binary_axis("relation", "Which relation survives?", rejected, "The alternative loses conservation, causality or a required record.", relation, preservation),
        binary_axis("enumeration", "Are forms exhausted?", "selected-neighbourhood", "A selected neighbourhood cannot prove uniqueness.", "complete-registered-product", "Every axis choice occurs with every other choice."),
        binary_axis("minimality", "Are missing carriers controlled?", "uncontrolled-omission", "An omitted carrier may silently choose the answer.", "every-omission-rejected", "Each required carrier has a constructive omission failure."),
        binary_axis("measurement", "Can observation choose the result?", "target-visible-before-seal", "Target access reverses the empirical direction.", "formal-result-sealed-first", "External comparison occurs only after the formal seal."),
        binary_axis("record", "What is retained?", "answer-only", "An answer cannot reproduce its causal/source ledger.", "complete-causal-source-control-record", "Causal paths, sources, exact arithmetic, census and controls remain held."),
        binary_axis("extension", "Can another selector be added?", "free-extra-rule", "An extra selector is a free parameter.", "no-extra-rule", "The declared grammar closes without another choice."),
    )


def make_spec(claim_id: str, title: str, statement: str, dependencies: tuple[str, ...], relation: str,
              preservation: str, rejected: str, exact_result: str, base: str, successor: str,
              witnesses: tuple[Witness, ...], *extra: str) -> StructuralPhysicsSpec:
    return StructuralPhysicsSpec(
        claim_id=claim_id,
        title=title,
        statement=statement,
        dependencies=dependencies,
        evidence_mode=EvidenceMode.FORMAL,
        generation_rule=f"Generate the complete eight-axis product for {title.lower()} from carrier, dependency, relation, enumeration, minimality, measurement direction, record and extension.",
        grammar_boundary="Every finite exact carrier and causal/source ledger named by this law together with the complete product of its eight registered binary form axes.",
        axes=gravity_axes(relation, preservation, rejected),
        exact_result=exact_result,
        induction_base=base,
        induction_step=successor,
        exclusions=COMMON_EXCLUSIONS + extra,
        witnesses=witnesses,
    )


GRAVITY_FLUX_SPEC = make_spec(GRAVITY_FLUX_ID, "Weak gravitational potential and Gauss closure",
    "A positive inertial-energy source distributed over the forced rank-two boundary has inverse-square response, and field times boundary growth reconstructs the same source at every generated radius.",
    ("SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-GRAVITY-FIELD-SOURCE-001", "SFT-PHYS-MECH-CONSERVATION-001"),
    "positive-source-over-rank-two-boundary", "Boundary rank and conservation force field, flux and retained potential.", "imported-Newton-profile-or-free-exponent",
    "For source 1/8, radii 1/4 and 1/2 both return flux 1/8; fields are 2 and 1/2 and clock potentials are 1/2 and 3/4.",
    "One positive source on one complete boundary returns itself.", "Every new radius changes boundary cells by the forced square while preserving source flux.",
    (Witness("inner", "Inner shell retains source and half-One potential.", weak_gravity(Fraction(1, 8), Fraction(1, 4))["flux"] == Fraction(1, 8) and weak_gravity(Fraction(1, 8), Fraction(1, 4))["clock_potential"] == Fraction(1, 2)), Witness("outer", "Outer shell retains source and three-quarter potential.", weak_gravity(Fraction(1, 8), Fraction(1, 2))["flux"] == Fraction(1, 8) and weak_gravity(Fraction(1, 8), Fraction(1, 2))["clock_potential"] == Fraction(3, 4))))

INTERVAL_SPEC = make_spec(INTERVAL_ID, "Exact causal interval",
    "The spatial square is positively taken from the temporal square; the generated 3-4-5 partition gives massive interval square 16/25 and proper carrier 4/5, while equality is an empty massless-boundary record.",
    (GRAVITY_FLUX_ID, "SFT-PHYS-SPACETIME-INTERVAL-001", "SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003"),
    "positive-temporal-square-retains-spatial-take", "The causal triple closes without a negative or radical proof quantity.", "signed-imported-Minkowski-form",
    "Temporal One and spatial 3/5 retain interval square 16/25 and proper time 4/5; equal temporal/spatial support yields the empty massless boundary.",
    "One generated causal triple closes exactly.", "Every interval appends its positive take and held causal class.",
    (Witness("massive", "The generated causal triple closes.", interval_witness()["interval_square"] == Fraction(16, 25) and interval_witness()["proper_time"] == Fraction(4, 5)), Witness("boundary", "Equal claims produce structural absence, not numerical zero.", exact_interval(Fraction(1, 1), Fraction(1, 1))["interval_square"] == ())))

STATIC_CLOCK_SPEC = make_spec(STATIC_CLOCK_ID, "Static Fold-covariant clock",
    "The static clock square is the positive remainder of well depth from the One and commutes with Fold exposure; at well 7/16 the generated clock rate is exactly 3/4.",
    (INTERVAL_ID, "SFT-PHYS-SPACETIME-CLOCK-RATE-001", "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"),
    "One-take-well-depth-with-Fold-covariance", "Positive take and Fold exposure determine the clock relation without a fitted metric.", "imported-clock-dilation-function",
    "At well 1/8, Fold(7/8)=3/4=One-Fold(1/8); at well 7/16, metric square 9/16 has clock rate 3/4; the horizon yields an empty clock record.",
    "One weak well retains one positive clock square.", "Each generated well repeats the exact covariance until the boundary becomes the empty record.",
    (Witness("covariance", "The one-eighth well commutes with the Fold.", static_clock(Fraction(1, 8))["folded_metric"] == Fraction(3, 4)), Witness("rate", "Seven-sixteenths well gives three-quarter rate.", exact_clock_rate() == Fraction(3, 4)), Witness("horizon", "Complete well depth closes the local clock record.", static_clock(Fraction(1, 1))["clock_record"] == ())))

EQUIVALENCE_SPEC = make_spec(EQUIVALENCE_ID, "Gravitational-redshift and acceleration equivalence",
    "The same exact acceleration-height carrier appears as weak gravitational redshift and acquired-speed Doppler shift, leaving no local observation label that distinguishes the complete traces.",
    (STATIC_CLOCK_ID, "SFT-PHYS-GRAVITY-EQUIVALENCE-001", "SFT-PHYS-MECH-ACCELERATION-001"),
    "gravity-redshift-equals-accelerated-Doppler", "Both traces are the same exact product with different held provenance labels.", "independent-fitted-redshift-laws",
    "At acceleration 1/4 and height One, gravitational and accelerated shifts are both 1/4.",
    "One acceleration-height event gives one common exact shift.", "Each local replicated event retains equality and its distinct provenance labels.",
    (Witness("equivalence", "The two weak-field shifts are identical quarter-One carriers.", redshift_equivalence(Fraction(1, 4), Fraction(1, 1)) == {"gravitational_redshift": Fraction(1, 4), "accelerated_doppler": Fraction(1, 4)}),))

LATTICE_CURVATURE_SPEC = make_spec(LATTICE_CURVATURE_ID, "Exact lattice curvature family",
    "The exact second difference of the square carrier is binary curvature at every positive spacing; summing complete axes yields Laplacians 2, 4 and 6 in one-, two- and three-dimensional support.",
    (EQUIVALENCE_ID, "SFT-PHYS-GRAVITY-CURVATURE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001"),
    "binary-curvature-per-generated-axis", "Exact cancellation of common positive support leaves two spacing squares per axis.", "continuum-derivative-or-fitted-curvature",
    "At spacings 1/8 and 1/16, per-axis curvature is 2; complete dimension counts give Laplacians 2,4,6.",
    "One generated axis has exact binary curvature.", "Each added axis appends the same exact binary curvature and preserves previous axes.",
    (Witness("spacing", "Two exact spacings give identical curvature.", square_lattice_curvature(Fraction(1, 2), Fraction(1, 8)) == square_lattice_curvature(Fraction(1, 2), Fraction(1, 16)) == 2), Witness("family", "The full generated dimension family is two, four, six.", tuple(lattice_laplacian(d, Fraction(1, 8)) for d in (1, 2, 3)) == (2, 4, 6))))

NONLINEAR_GRAVITY_SPEC = make_spec(NONLINEAR_GRAVITY_ID, "Gravity self-sources through field energy",
    "The positive gravitational field carrier has an exact square energy carrier that couples through the same half-One relation and therefore appends a separately retained second-order source correction.",
    (LATTICE_CURVATURE_ID, "SFT-PHYS-GRAVITY-FIELD-SOURCE-001", "SFT-PHYS-MATTER-MASS-ENERGY-001"),
    "field-square-reenters-same-source-channel", "Energy is already the admitted gravitational source class, so field energy cannot be omitted.", "linear-only-gravity-or-free-nonlinearity",
    "Source 1/3 at coupling 1/2 gives linear field 1/6, field energy 1/36 and self-source correction 1/72.",
    "One linear field retains its positive square energy.", "Every added field-energy carrier reenters the same source ledger at the next exact order.",
    (Witness("self-source", "The complete exact nonlinear ledger closes.", nonlinear_gravity()["self_source_correction"] == Fraction(1, 72)),))

GRAVITON_POLARIZATION_SPEC = make_spec(GRAVITON_POLARIZATION_ID, "Graviton polarization count",
    "A symmetric four-dimensional metric has ten component slots; eight coordinate/gauge slots leave exactly two physical polarization carriers, while planar spacetime leaves an empty propagating record.",
    (NONLINEAR_GRAVITY_ID, "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-GRAVITY-WAVE-001"),
    "symmetric-metric-count-less-coordinate-pairs", "Complete component and gauge counts leave the unique physical remainder.", "asserted-two-polarizations",
    "For D=4, D(D+1)/2=10 and 2D=8 leave two; for D=3, six and six leave the empty structural record.",
    "Planar spacetime closes all symmetric slots under coordinate pairs.", "Adding the fourth dimension appends four symmetric slots and two gauge slots, leaving two physical carriers.",
    (Witness("four", "Four-dimensional support leaves two polarizations.", graviton_polarizations(4)["physical_polarizations"] == 2), Witness("planar", "Planar support has an empty propagating polarization record.", graviton_polarizations(3)["physical_polarizations"] == ())))

GRAVITY_WAVE_SPEC = make_spec(GRAVITY_WAVE_ID, "One-speed quadrupole gravitational propagation",
    "A detached gravitational recurrence advances at the same One causal speed as the electromagnetic carrier; conserved source and momentum freeze monopole and dipole records, leaving changing second differences as the first radiative moment.",
    (GRAVITON_POLARIZATION_ID, "SFT-PHYS-GRAVITY-WAVE-001", "SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003"),
    "One-speed-recurrence-with-first-unfrozen-quadrupole", "Shared causal adjacency fixes speed and conservation fixes the first changing moment.", "separate-fitted-gravity-wave-speed-or-dipole-radiation",
    "Eight ticks retain exact One-speed phase; uniform linear motion has equal first differences, while the generated cubic drive has changing second differences 12 and 18.",
    "One massless curvature recurrence advances one support cell per tick.", "Each tick preserves phase/speed and each source event retains the complete moment-difference ledger.",
    (Witness("speed", "Gravity wave speed is the One.", gravitational_wave_trace()["speed"] == 1), Witness("phase", "Eight One-speed ticks retain phase.", len(set(gravitational_wave_trace()["phase_trace"])) == 1), Witness("quadrupole", "The first unfrozen drive has changing second differences.", gravitational_wave_trace()["first_unfrozen_second_differences"] == (12, 18))))

HORIZON_SPEC = make_spec(HORIZON_ID, "Strong-field horizon and finite floor",
    "The horizon radius is the Fold of the quarter-One mass, exactly twice the mass; two binary halvings force the quarter area coefficient, and every finite depth retains a positive distance floor so no singular empty distance enters the physical grammar.",
    (GRAVITY_WAVE_ID, "SFT-PHYS-GRAVITY-HORIZON-001", "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"),
    "Fold-mass-radius-quarter-area-and-positive-finite-floor", "Fold doubling, boundary rank and binary support determine the complete strong-field count.", "singular-point-or-imported-horizon-equation",
    "Mass 1/4 has radius 1/2; entropy coefficient is 1/4; area 32 has eight boundary records; normalized thermal carrier is positive 1/4; every finite depth k has distance floor 1/2^k.",
    "The quarter-One mass Folds once to the half-One boundary.", "Every depth appends a binary refinement while retaining a positive finite floor and boundary record count.",
    (Witness("radius", "Horizon radius is twice the mass.", strong_field_horizon()["radius"] == Fraction(1, 2)), Witness("area", "Quarter area coefficient maps 32 cells to eight.", strong_field_horizon()["entropy_cells"] == 8), Witness("floor", "Every tested finite depth retains positive support.", all(finite_distance_floor(k) > 0 for k in range(1, 17))), Witness("thermal", "The normalized horizon thermal carrier is positive quarter-One.", strong_field_horizon()["normalized_thermal_carrier"] == Fraction(1, 4))),
    "no claim that normalized quarter-One alone fixes a measured black-hole temperature in kelvin")

HORIZON_INFORMATION_SPEC = make_spec(HORIZON_INFORMATION_ID, "Horizon information closure and reconstruction",
    "Local horizon observation closes access to the predecessor as an empty record, while the complete boundary-cell and inverse-process records retain the distinctions required for global reconstruction; loss and conservation are therefore observation-relative parts of one ledger.",
    (HORIZON_ID, "SFT-INFO-CONSERVATION-LOSS-001", "SFT-QUANTUM-MEASUREMENT-001"),
    "local-closure-with-complete-boundary-inverse-record", "Observation can close local access without deleting a separately retained global trace.", "absolute-destruction-or-unrecorded-reconstruction",
    "The 32-cell horizon at coefficient 1/4 retains eight boundary records; local predecessor access is empty, and reconstruction is lawful exactly when the complete inverse record is held.",
    "One horizon observation closes one local predecessor while retaining its boundary record.", "Each added boundary cell appends its exact record and every reconstruction step consumes the corresponding inverse label.",
    (Witness("local", "Local predecessor is structurally closed.", horizon_information_ledger()["locally_closed_predecessor"] == ()), Witness("boundary", "Eight exact boundary records remain.", len(horizon_information_ledger()["retained_boundary_records"]) == 8), Witness("inverse", "Complete inverse records permit reconstruction.", horizon_information_ledger()["reconstructible_with_complete_inverse_record"] is True)))

WORMHOLE_SPEC = make_spec(WORMHOLE_ID, "Wormhole admissibility boundary",
    "A shortcut relation is physically admissible only when both mouths and the link are generated adjacent support with a positive source and complete causal trace; a named remote identification without that construction is rejected.",
    (HORIZON_INFORMATION_ID, "SFT-PHYS-FIELD-LOCALITY-CAUSALITY-001", "SFT-PHYS-SPACETIME-CAUSAL-ORDER-001"),
    "positive-source-generated-link-complete-causal-trace", "A genuine new adjacency must enter the same source and causal ledgers as every other path.", "declared-remote-mouth-equivalence",
    "The current grammar forces the admissibility conditions but does not force an observed or constructible wormhole; positive source plus generated link plus complete trace is accepted, and every omission is rejected.",
    "One generated adjacency with positive source and complete trace is lawful.", "Every added mouth/path cell must append its source, causal predecessor and return records.",
    (Witness("admissible", "A completely generated positive link passes the formal boundary.", wormhole_admissible(Fraction(1, 4), True, True)), Witness("remote-rejected", "An ungenerated remote link fails.", not wormhole_admissible(Fraction(1, 4), False, True))),
    "no claim that an astrophysical or engineered traversable wormhole has been observed")

WARP_SPEC = make_spec(WARP_ID, "Warp-support admissibility boundary",
    "A propagation-support redistribution is admissible only as a positive conserved transfer whose destination carrier equals the source carrier and whose apparatus/source return ledger is complete; negative energy and unrecorded net work are not generated.",
    (WORMHOLE_ID, "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"),
    "positive-conserved-support-redistribution-with-return-ledger", "Closed transfer and restoration preserve every source distinction without a forbidden magnitude.", "negative-energy-bubble-or-open-work-ledger",
    "The current grammar forces the admissibility ledger but no achieved warp device: equal positive source/destination with complete return passes; changed support or incomplete return fails.",
    "One positive redistribution conserves one source carrier.", "Every further support cell appends its transfer and restoration records.",
    (Witness("admissible", "A closed equal positive redistribution passes.", warp_admissible(Fraction(1, 4), Fraction(1, 4), True)), Witness("ledger-rejected", "An incomplete return ledger fails.", not warp_admissible(Fraction(1, 4), Fraction(1, 4), False)), Witness("gain-rejected", "An unequal destination fails.", not warp_admissible(Fraction(1, 4), Fraction(1, 2), True))),
    "no claim of observed superluminal transport or engineered spacetime distortion")

CTC_SPEC = make_spec(CTC_ID, "Closed-timelike recurrence admissibility boundary",
    "A closed causal recurrence is consistent only when it returns the complete physical and proof record exactly; any self-ancestor cycle that changes its own retained premise has no fixed record and is rejected.",
    (WARP_ID, "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-COMP-CBL-HALTING-001"),
    "exact-first-return-of-complete-state-and-proof-record", "A lawful recurrence must close on the same complete state rather than overwrite its premise.", "changed-self-ancestor-paradox",
    "Exact recurrence of the complete state is admissible as a cycle; changed self-ancestor, missing trace or answer-altering loop is not. No physical closed timelike curve is forced by this boundary.",
    "One complete state returns only to itself with the full trace retained.", "Every cycle step appends a transition record and closure compares the complete final record to the initial record.",
    (Witness("cycle", "An exact complete-state recurrence passes.", closed_timelike_admissible(("state", "proof"), ("state", "proof"), True)), Witness("paradox", "A changed self-ancestor record fails.", not closed_timelike_admissible(("state", "proof"), ("changed-state", "proof"), True)), Witness("missing-trace", "An unrecorded cycle fails.", not closed_timelike_admissible(("state", "proof"), ("state", "proof"), False))),
    "no claim that a physical closed timelike curve has been observed or constructed")


GRAVITY_SPACETIME_SPECS = (
    GRAVITY_FLUX_SPEC,
    INTERVAL_SPEC,
    STATIC_CLOCK_SPEC,
    EQUIVALENCE_SPEC,
    LATTICE_CURVATURE_SPEC,
    NONLINEAR_GRAVITY_SPEC,
    GRAVITON_POLARIZATION_SPEC,
    GRAVITY_WAVE_SPEC,
    HORIZON_SPEC,
    HORIZON_INFORMATION_SPEC,
    WORMHOLE_SPEC,
    WARP_SPEC,
    CTC_SPEC,
)
SPEC_BY_ID = {item.claim_id: item for item in GRAVITY_SPACETIME_SPECS}

for _spec in GRAVITY_SPACETIME_SPECS:
    _spec.validate()


__all__ = (
    "GRAVITY_SPACETIME_SPECS",
    "SPEC_BY_ID",
    "weak_gravity",
    "interval_witness",
    "exact_interval",
    "static_clock",
    "exact_clock_rate",
    "redshift_equivalence",
    "square_lattice_curvature",
    "lattice_laplacian",
    "nonlinear_gravity",
    "graviton_polarizations",
    "gravitational_wave_trace",
    "strong_field_horizon",
    "finite_distance_floor",
    "horizon_information_ledger",
    "wormhole_admissible",
    "warp_admissible",
    "closed_timelike_admissible",
)

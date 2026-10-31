"""Exact V3 reconstruction of the vacuum and extraction lineage.

Earlier SFT results are registered reconstruction obligations, never runtime
premises.  This module uses only admitted V3 Fold objects and exact positive
fractions.  Structural absence is represented by an empty record, not by a
numerical zero.  In particular, the local extraction result and the complete
returned-cycle ledger are separate claims: neither is permitted to erase the
other.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.atomic_constants import binary_count, positive_power
from sft.physics.lineage_particle_laws import half_one
from sft.physics.structural_constants import (
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    first_return_trace,
    fold_part,
    generator_period_three,
)


VACUUM_FLOOR_ID = "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"
VACUUM_RECURRENCE_ID = "SFT-PHYS-VACUUM-ODD-RECURRENCE-003"
VACUUM_POLARIZATION_ID = "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"
VACUUM_INERTIA_ID = "SFT-PHYS-VACUUM-INERTIA-UNITY-003"
VACUUM_EXTRACTION_ID = "SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"
VACUUM_CYCLE_ID = "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"


def vacuum_floor() -> Fraction:
    """Return the unique exact part which self-pairs to the One."""

    candidates = tuple(
        Fraction(index, binary_count())
        for index in range(1, binary_count() + 1)
        if Fraction(index, binary_count()) + Fraction(index, binary_count()) == 1
    )
    if candidates != (Fraction(1, 2),):
        raise ValueError("the complete binary support did not force one vacuum floor")
    return candidates[0]


def oscillator_levels(depth: int) -> tuple[Fraction, ...]:
    """Generate the complete half-spacing spectrum at positive depth."""

    if isinstance(depth, bool) or depth < 1:
        raise ValueError("oscillator depth must be a positive generated count")
    support = positive_power(binary_count(), depth)
    denominator = support * binary_count()
    return tuple(Fraction(binary_count() * rank - 1, denominator) for rank in range(1, support + 1))


def odd_denominator_orbit(denominator: int) -> tuple[Fraction, ...]:
    """Return the exact first-return orbit of the unit odd-denominator part."""

    if isinstance(denominator, bool) or denominator <= 1:
        raise ValueError("a live vacuum orbit requires a positive denominator beyond the One")
    if denominator // binary_count() * binary_count() == denominator:
        raise ValueError("a live vacuum orbit requires an odd denominator")
    orbit = first_return_trace(Fraction(1, denominator))
    if not orbit or any(value <= 0 or value > 1 for value in orbit):
        raise ValueError("the live vacuum orbit left the exact positive domain")
    return orbit


def vacuum_polarization_support() -> tuple[Fraction, Fraction]:
    """Return far screened and one-Fold exposed support without a fitted curve."""

    screened = vacuum_floor()
    exposed = fold_part(screened)
    if not screened < exposed or exposed != 1:
        raise ValueError("vacuum exposure did not increase exact charge support")
    return screened, exposed


def vacuum_inertia_exchange() -> Fraction:
    """Return the exact ratio of vacuum displacement to Fold coupling."""

    coupling = half_one()
    displacement = vacuum_floor()
    exchange = displacement / coupling
    if exchange != 1:
        raise ValueError("vacuum and inertia carriers did not close at the One")
    return exchange


def positive_gap(larger: Fraction, smaller: Fraction) -> Fraction:
    if not isinstance(larger, Fraction) or not isinstance(smaller, Fraction):
        raise ValueError("a Fold gap requires exact fractions")
    if not 0 < smaller < larger <= 1:
        raise ValueError("a Fold gap requires ordered positive parts")
    return larger - smaller


def asymmetric_vacuum_beat() -> dict[str, Fraction]:
    """Transfer the exact half-One/generator-three beat to a work carrier."""

    before = vacuum_floor()
    retained = Fraction(1, generator_period_three())
    extracted = positive_gap(before, retained)
    if retained + extracted != before:
        raise ValueError("the asymmetric beat did not conserve its source carrier")
    return {
        "vacuum_before": before,
        "vacuum_after": retained,
        "local_work": extracted,
    }


def complete_returned_cycle() -> dict[str, object]:
    """Close the extraction/restoration cycle without using numerical zero."""

    outward = asymmetric_vacuum_beat()
    restoration = outward["local_work"]
    restored_vacuum = outward["vacuum_after"] + restoration
    residual_work: tuple[()] = ()
    if restored_vacuum != outward["vacuum_before"]:
        raise ValueError("the vacuum reservoir was not restored exactly")
    return {
        "outward": outward,
        "restoration_cost": restoration,
        "restored_vacuum": restored_vacuum,
        "residual_work": residual_work,
    }


COMMON_EXCLUSIONS = (
    "no V1/V2 executable, certificate, candidate table or answer artifact as a premise",
    "no external measurement, conventional vacuum model or apparatus result selecting a survivor",
    "no fitted coefficient, tunable phase, chosen reservoir value or answer-selected harmonic",
    "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity",
    "no deletion of the positive outward extraction result or of the complete restoration ledger",
)


def vacuum_axes(relation: str, preservation: str, rejected_relation: str) -> tuple:
    return (
        binary_axis("carrier", "What carries the result?", "borrowed-vacuum-number", "A borrowed vacuum number has no Fold trace.", "generated-exact-Fold-carrier", "Every carrier is regenerated from admitted exact Fold support."),
        binary_axis("dependency", "How are dependencies obtained?", "asserted-prior-answer", "An asserted prior answer is an unregistered premise.", "admitted-V3-dependency-trace", "Every dependency reaches the premise-free root theorem through admitted V3 claims."),
        binary_axis("relation", "Which relation is retained?", rejected_relation, "The alternative loses a required carrier or imports an extra law.", relation, preservation),
        binary_axis("enumeration", "Are alternatives complete?", "selected-candidate-neighbourhood", "A selected neighbourhood cannot establish uniqueness.", "complete-registered-product", "Every choice occurs with every choice on all other axes."),
        binary_axis("minimality", "Are predecessor forms controlled?", "survivor-without-lower-controls", "A bare survivor does not prove the required carriers are minimal.", "all-omitted-carrier-forms-rejected", "Each omitted carrier has a named constructive failure."),
        binary_axis("measurement", "May observation choose the law?", "target-visible-before-seal", "Target access before sealing reverses the scientific direction.", "exact-result-sealed-before-comparison", "The fraction, census and trace seal before external comparison."),
        binary_axis("record", "What evidence is retained?", "answer-only-record", "An answer alone cannot reproduce the source and transfer ledger.", "complete-source-transfer-control-record", "Source, transfer, reservoir, controls and complete census remain held."),
        binary_axis("extension", "May another selector be added?", "free-extra-rule", "An added selector is a free parameter.", "no-extra-rule", "The admitted carriers and exact relation exhaust the declared grammar."),
    )


VACUUM_FLOOR_SPEC = StructuralPhysicsSpec(
    claim_id=VACUUM_FLOOR_ID,
    title="Half-One vacuum floor and oscillator spectrum",
    statement=(
        "Complete binary-support enumeration leaves exactly the half-One as the positive part whose self-pair "
        "reassembles the One. It is self-antipodal and Folds to the One. At every positive depth k, complete "
        "binary support then forces 2^k uniformly separated oscillator parts (2j-1)/2^(k+1), beginning one "
        "half-spacing above structural absence."
    ),
    dependencies=("SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of vacuum carrier, dependencies, self-pair relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All exact positive parts of complete binary support, their self-pair return, and every finite positive-depth half-spacing spectrum generated by complete binary words.",
    axes=vacuum_axes("unique-half-One-self-pair-and-half-spacing-spectrum", "Complete binary support forces the floor; complete depth-k support forces every odd numerator exactly once.", "empty-ground-or-selected-offset"),
    exact_result="The exact vacuum floor is 1/2. At depth k the complete oscillator spectrum is ((2j-1)/2^(k+1)) for j=1..2^k; depth two is (1/8,3/8,5/8,7/8).",
    induction_base="At depth One, only the half-One self-pairs to the One and the spectrum is one-quarter, three-quarters.",
    induction_step="Doubling support inserts one half-spacing state on each side of every prior whole-spacing position, preserving all odd numerators and uniform separation.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("floor", "The unique binary-support self-pair is the half-One.", vacuum_floor() == Fraction(1, 2)),
        Witness("return", "The floor self-pairs and Folds to the One.", vacuum_floor() + vacuum_floor() == 1 and fold_part(vacuum_floor()) == 1),
        Witness("depth-two", "The complete depth-two oscillator spectrum has four forced half-spacing parts.", oscillator_levels(2) == (Fraction(1, 8), Fraction(3, 8), Fraction(5, 8), Fraction(7, 8))),
        Witness("successor", "Every tested successor doubles cardinality and halves spacing exactly.", all(len(oscillator_levels(k + 1)) == binary_count() * len(oscillator_levels(k)) for k in range(1, 6))),
    ),
)


VACUUM_RECURRENCE_SPEC = StructuralPhysicsSpec(
    claim_id=VACUUM_RECURRENCE_ID,
    title="Perpetually live odd-denominator vacuum recurrence",
    statement=(
        "For every generated odd denominator beyond the One, pairing a positive residue with the binary Fold "
        "cannot acquire the denominator's factor and therefore cannot reach structural absence. The finite "
        "positive residue support forces a first return, so each such vacuum mode remains on an exact live cycle."
    ),
    dependencies=(VACUUM_FLOOR_ID, "SFT-FOUNDATION-FOLD-001", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of recurrence carrier, dependencies, odd-denominator relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="Every positive finite odd denominator, its complete positive residue support and the exact first-return Fold orbit of its unit part.",
    axes=vacuum_axes("odd-denominator-first-return-without-empty-state", "Odd support shares no binary factor, and finite exact residues force a return before any repeated non-source state can persist.", "dead-ground-or-finite-prefix-only"),
    exact_result="Every positive odd-denominator unit part beyond the One remains strictly positive and returns exactly; examples d=3,5,7,9 have periods 2,4,3,6.",
    induction_base="Denominator three gives the exact two-cycle 1/3 -> 2/3 -> 1/3.",
    induction_step="Each supplied odd successor retains binary coprimality; its finite positive residue set forces recurrence, while first-return tracing closes the exact period.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("three", "The first odd mode is a strict positive two-cycle.", odd_denominator_orbit(3) == (Fraction(2, 3), Fraction(1, 3))),
        Witness("five", "The denominator-five mode closes in four transitions.", len(odd_denominator_orbit(5)) == 4),
        Witness("seven", "The generator-three mode closes in three transitions.", len(odd_denominator_orbit(7)) == 3),
        Witness("odd-prefix", "Every generated odd denominator through thirty-one returns without leaving the domain.", all(odd_denominator_orbit(d)[-1] == Fraction(1, d) for d in range(3, 32, 2))),
    ),
)


VACUUM_POLARIZATION_SPEC = StructuralPhysicsSpec(
    claim_id=VACUUM_POLARIZATION_ID,
    title="Vacuum polarization and running direction",
    statement=(
        "The live vacuum retains the half-One screened support at the far carrier. One exact Fold exposure "
        "returns that support to the bare One, forcing electromagnetic support to increase as screening layers "
        "are removed. This fixes the running direction and endpoints without importing a renormalization model."
    ),
    dependencies=(VACUUM_FLOOR_ID, VACUUM_RECURRENCE_ID, "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of polarization carrier, dependencies, screened-to-exposed relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="The complete exact Fold fibre from the half-One screened carrier to the exposed One, with every intermediate finite screening layer retained if subsequently generated.",
    axes=vacuum_axes("half-One-screened-to-One-exposed-running", "The only Fold advance of the exact screened carrier increases support to the complete One.", "fitted-running-curve-or-reversed-direction"),
    exact_result="Vacuum polarization forces the structural running direction screened 1/2 -> exposed One; closer probing removes screening and increases effective electromagnetic support.",
    induction_base="The far carrier retains the exact half-One screened support.",
    induction_step="Removing one complete Fold screening layer exposes the One; additional physical scale correspondence must remain a separately sealed empirical relation.",
    exclusions=COMMON_EXCLUSIONS + ("no claim that the two structural endpoints alone fix a measured beta coefficient",),
    witnesses=(
        Witness("screened", "The screened carrier is the exact vacuum floor.", vacuum_polarization_support()[0] == Fraction(1, 2)),
        Witness("exposed", "One Fold exposure returns complete bare support.", vacuum_polarization_support()[1] == 1),
        Witness("direction", "Exposed support is strictly greater than screened support.", vacuum_polarization_support()[0] < vacuum_polarization_support()[1]),
    ),
)


VACUUM_INERTIA_SPEC = StructuralPhysicsSpec(
    claim_id=VACUUM_INERTIA_ID,
    title="Exact vacuum-to-inertia unity relation",
    statement=(
        "The independently forced vacuum displacement and native Fold coupling are both the half-One. Their "
        "exact exchange ratio is therefore the One and both complete in one Fold. Any lawful change of one "
        "carrier must be held identically by the other; this is a structural proportionality and a standing "
        "experimental discriminator, not an observation of engineered inertia reduction."
    ),
    dependencies=(VACUUM_FLOOR_ID, "SFT-PHYS-MECH-INERTIA-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of vacuum/inertia carrier, dependencies, exact exchange relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All exact ratios between the independently admitted vacuum displacement and native Fold coupling, including changed-carrier controls and the one-Fold completion trace.",
    axes=vacuum_axes("half-One-over-half-One-exchange-at-One", "Identical exact carriers have the unique ratio One and complete under the same Fold transition.", "free-inertia-coupling-or-uncoupled-carriers"),
    exact_result="The exact vacuum-to-inertia exchange ratio is the One: (1/2)/(1/2)=1, with both carriers completing in one Fold.",
    induction_base="Vacuum displacement and native coupling are independently forced to the half-One.",
    induction_step="Every exact proportional change must retain the same ratio One; an unequal change leaves an unrecorded carrier and is rejected.",
    exclusions=COMMON_EXCLUSIONS + ("no UAP report, propulsion observation or engineering performance used as validation",),
    witnesses=(
        Witness("exchange", "The exact vacuum/inertia exchange closes at the One.", vacuum_inertia_exchange() == 1),
        Witness("joint-return", "Both carriers complete in the same single Fold.", fold_part(vacuum_floor()) == fold_part(half_one()) == 1),
    ),
)


VACUUM_EXTRACTION_SPEC = StructuralPhysicsSpec(
    claim_id=VACUUM_EXTRACTION_ID,
    title="Positive asymmetric vacuum-beat extraction",
    statement=(
        "The half-One vacuum carrier and generator-three unit carrier have the unique exact positive separation "
        "one-sixth. Transferring that beat to a held work carrier leaves one-third in the local vacuum carrier, "
        "and one-third plus one-sixth reconstructs the original half-One exactly. Thus a positive outward "
        "vacuum-to-work transfer is structurally admitted without creating support."
    ),
    dependencies=(VACUUM_FLOOR_ID, VACUUM_RECURRENCE_ID, VACUUM_INERTIA_ID, "SFT-PHYS-WAVE-RESONANCE-001", "SFT-PHYS-MECH-CONSERVATION-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of vacuum-beat carrier, dependencies, exact transfer relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All exact beat transfers between the independently forced half-One vacuum carrier and unit generator-three carrier, with source, retained reservoir and work support held separately.",
    axes=vacuum_axes("half-One-versus-one-third-positive-beat-transfer", "The independently forced carriers have exact gap one-sixth, and the retained reservoir plus work reassembles the source.", "asserted-free-energy-or-erased-outward-transfer"),
    exact_result="The forced asymmetric vacuum beat transfers positive work 1/6: vacuum 1/2 -> retained vacuum 1/3 plus held work 1/6, conserving the original carrier exactly.",
    induction_base="The half-One vacuum and generator-three unit are independently admitted exact carriers.",
    induction_step="Their ordered positive gap is held as work while the smaller carrier remains as reservoir; recomposition returns the source and rejects any extra work term.",
    exclusions=COMMON_EXCLUSIONS + ("no claim of repeated net work without restoring the changed vacuum carrier",),
    witnesses=(
        Witness("positive-work", "The asymmetric beat produces a strict positive work carrier.", asymmetric_vacuum_beat()["local_work"] == Fraction(1, 6)),
        Witness("retained-vacuum", "The outward transfer retains the generator-three unit in the reservoir.", asymmetric_vacuum_beat()["vacuum_after"] == Fraction(1, 3)),
        Witness("outward-conservation", "Reservoir and work reconstruct the initial vacuum carrier.", asymmetric_vacuum_beat()["vacuum_after"] + asymmetric_vacuum_beat()["local_work"] == asymmetric_vacuum_beat()["vacuum_before"]),
    ),
)


VACUUM_CYCLE_SPEC = StructuralPhysicsSpec(
    claim_id=VACUUM_CYCLE_ID,
    title="Complete returned-cycle vacuum energy ledger",
    statement=(
        "The admitted outward beat transfers one-sixth to work and leaves one-third in the vacuum carrier. "
        "Returning the apparatus and vacuum carrier to their exact initial state requires transferring the same "
        "one-sixth back. The vacuum is restored to one-half and the work carrier becomes the empty structural "
        "record. A complete returned cycle therefore retains the outward extraction event while forbidding an "
        "unrecorded net-support gain."
    ),
    dependencies=(VACUUM_EXTRACTION_ID, "SFT-PHYS-THERMO-FIRST-LAW-001", "SFT-PHYS-THERMO-ENTROPY-001", "SFT-INFO-CONSERVATION-LOSS-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of returned-cycle carrier, dependencies, full ledger relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="The complete two-leg process returning vacuum, apparatus state and retained information to their initial records, with every positive transfer held and structural absence represented only by the empty form.",
    axes=vacuum_axes("outward-one-sixth-and-equal-restoration-cost", "Exact initial-state return forces the extracted carrier to restore the depleted reservoir; every support term remains accounted.", "partial-cycle-net-gain-or-erased-extraction"),
    exact_result="A complete returned cycle is: outward vacuum 1/2 -> 1/3 + work 1/6; restoration 1/3 + 1/6 -> vacuum 1/2; residual work is the empty structural form, not numerical zero.",
    induction_base="The outward leg is the separately admitted positive one-sixth extraction event.",
    induction_step="Exact return of the vacuum carrier uniquely requires the missing one-sixth; returning every additional retained record similarly requires its exact held support.",
    exclusions=COMMON_EXCLUSIONS + ("no suppression of reservoir depletion, apparatus reset, information record or restoration cost",),
    witnesses=(
        Witness("restoration-cost", "The restoration cost equals the outward work carrier exactly.", complete_returned_cycle()["restoration_cost"] == Fraction(1, 6)),
        Witness("vacuum-return", "The vacuum carrier returns to its exact initial half-One state.", complete_returned_cycle()["restored_vacuum"] == Fraction(1, 2)),
        Witness("empty-residual", "No numerical zero is emitted; exhausted work is the empty structural record.", complete_returned_cycle()["residual_work"] == ()),
    ),
)


VACUUM_LINEAGE_SPECS = (
    VACUUM_FLOOR_SPEC,
    VACUUM_RECURRENCE_SPEC,
    VACUUM_POLARIZATION_SPEC,
    VACUUM_INERTIA_SPEC,
    VACUUM_EXTRACTION_SPEC,
    VACUUM_CYCLE_SPEC,
)
SPEC_BY_ID = {spec.claim_id: spec for spec in VACUUM_LINEAGE_SPECS}

for _spec in VACUUM_LINEAGE_SPECS:
    _spec.validate()


__all__ = (
    "VACUUM_LINEAGE_SPECS",
    "SPEC_BY_ID",
    "vacuum_floor",
    "oscillator_levels",
    "odd_denominator_orbit",
    "vacuum_polarization_support",
    "vacuum_inertia_exchange",
    "asymmetric_vacuum_beat",
    "complete_returned_cycle",
)

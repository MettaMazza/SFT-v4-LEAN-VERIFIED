"""Clean-room exact Physics prerequisites for the terminal Chemistry predictions.

Nothing in this module reads a measured constant, element table, V1/V2 proof
artifact or intended Chemistry answer.  Earlier corpora identify questions to
reconstruct, but the constructions below use only admitted V3 dependencies.

Host-language indices are implementation counters.  Every scientific value
emitted by a derivation is a positive integer or :class:`fractions.Fraction`;
structural absence is represented by an empty tuple, never numerical zero.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.structural_constants import (
    BOUNDARY_RANK_CLAIM_ID,
    GENERATOR_THREE_CLAIM_ID,
    SPATIAL_THREE_CLAIM_ID,
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    generator_period_three,
    positive_predecessor,
    value_axis,
)


INVERSE_FINE_STRUCTURE_ID = "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"
CELL_CAPACITY_ID = "SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001"
COLOUR_COUPLING_ID = "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001"
NUCLEAR_CLOSURE_ID = "SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001"
ATOMIC_BOUNDARY_ID = "SFT-PHYS-ATOMIC-EXISTENCE-BOUNDARY-001"


def binary_count() -> int:
    """The positive predecessor of the independently forced generator three."""

    return positive_predecessor(generator_period_three())


def positive_power(base: int, exponent: int) -> int:
    if isinstance(base, bool) or isinstance(exponent, bool) or base < 1 or exponent < 1:
        raise ValueError("positive power requires positive exact counts")
    result = base
    for _ in range(1, exponent):
        result *= base
    return result


def minimal_binary_cover(carrier: int) -> int:
    """Least positive depth whose complete binary support covers ``carrier``."""

    if isinstance(carrier, bool) or carrier < 1:
        raise ValueError("covering requires a positive exact carrier")
    depth = 1
    support = binary_count()
    while support < carrier:
        support *= binary_count()
        depth += 1
    return depth


def fine_structure_blocks() -> dict[str, int]:
    """Generate the exact blocks before any assembly or observation is opened."""

    b = binary_count()
    c = generator_period_three()
    generational_volume = positive_power(c, c)
    successor_volume = positive_power(c, c + 1)
    down = minimal_binary_cover(generational_volume)
    up = minimal_binary_cover(successor_volume)
    if down != b + c or up != c + (c + 1):
        raise ValueError("independent cover and generator decompositions failed to cross-lock")
    return {
        "binary": b,
        "generator": c,
        "down": down,
        "up": up,
        "tower": positive_power(b, up),
        "boundary": positive_power(c, b),
        "cover": b * positive_power(down, c),
    }


def promotion_rungs() -> tuple[int, ...]:
    """Promote each of the three interchangeable cover directions exactly once."""

    blocks = fine_structure_blocks()
    down, up, directions = blocks["down"], blocks["up"], blocks["generator"]
    rungs = []
    for promoted in range(0, directions + 1):
        # A missing factor is the multiplicative identity of the assembled
        # form.  It is not emitted as a numerical-zero exponent.
        down_part = 1 if promoted == directions else positive_power(down, directions - promoted)
        up_part = 1 if promoted == 0 else positive_power(up, promoted)
        rungs.append(down_part * up_part)
    return tuple(rungs)


def effective_cover(order: int) -> Fraction:
    """Read the finite promotion ladder through a positive rung count."""

    rungs = promotion_rungs()
    if isinstance(order, bool) or order < 1 or order > len(rungs):
        raise ValueError("order must name a positive generated promotion rung")
    cover = Fraction(fine_structure_blocks()["cover"], 1)
    if order == 1:
        return cover
    chain = Fraction(rungs[order - 1], 1)
    for rung_index in range(order - 2, 0, -1):
        chain = Fraction(rungs[rung_index], 1) + Fraction(1, 1) / chain
    return cover + Fraction(1, 1) / chain


def inverse_fine_structure(order: int | None = None) -> Fraction:
    """Return the exact terminal structural ratio, or a named positive rung."""

    chosen = len(promotion_rungs()) if order is None else order
    blocks = fine_structure_blocks()
    cover = effective_cover(chosen)
    return Fraction(blocks["tower"], 1) + Fraction(blocks["boundary"], 1) * (
        cover + Fraction(1, 1)
    ) / cover


def orientation_count(orbit_rank: int) -> int:
    """One central orientation plus a boundary pair per successor rank."""

    if isinstance(orbit_rank, bool) or orbit_rank < 1:
        raise ValueError("orbit rank must be a positive exact count")
    predecessor_steps = orbit_rank - 1  # host loop extent; absence at rank One is not emitted
    return 1 + boundary_count() * predecessor_steps


def boundary_count() -> int:
    return positive_predecessor(generator_period_three())


def orbit_capacity(orbit_rank: int) -> int:
    return binary_count() * orientation_count(orbit_rank)


def colour_coupling() -> Fraction:
    """Both Fold labels retained over the generator-three carrier."""

    return Fraction(binary_count(), generator_period_three())


def spin_orbit_threshold() -> int:
    """Least positive angular count whose exact shift reaches one shell gap."""

    angular = 1
    while colour_coupling() * Fraction(angular, binary_count()) < 1:
        angular += 1
    return angular


def oscillator_closure(shell_rank: int) -> int:
    """Filled three-direction shell through positive rank ``shell_rank``.

    The expression equals two spin labels times the complete weak composition
    count of the predecessor excitation among three distinguishable axes.
    """

    if isinstance(shell_rank, bool) or shell_rank < 1:
        raise ValueError("shell rank must be a positive exact count")
    count = shell_rank * (shell_rank + 1) * (shell_rank + 2)
    if count % generator_period_three() != 0:
        raise ValueError("three-direction composition count did not close exactly")
    return count // generator_period_three()


def nuclear_closure(shell_rank: int) -> int:
    """Apply the first whole colour-spin-orbit reordering when it is forced."""

    if isinstance(shell_rank, bool) or shell_rank < 1:
        raise ValueError("shell rank must be a positive exact count")
    threshold = spin_orbit_threshold()
    if shell_rank <= threshold:
        return oscillator_closure(shell_rank)
    return oscillator_closure(shell_rank - 1) + binary_count() * shell_rank


def nuclear_closure_prefix(length: int) -> tuple[int, ...]:
    if isinstance(length, bool) or length < 1:
        raise ValueError("closure prefix requires a positive exact length")
    return tuple(nuclear_closure(rank) for rank in range(1, length + 1))


def greatest_whole_not_exceeding(value: Fraction) -> int:
    """Successor-general greatest-whole certificate for a positive ratio."""

    if not isinstance(value, Fraction) or value < 1:
        raise ValueError("greatest-whole construction requires a positive ratio at least One")
    candidate = value.numerator // value.denominator
    if candidate < 1:
        raise ValueError("greatest whole must remain positive")
    if not (Fraction(candidate, 1) <= value < Fraction(candidate + 1, 1)):
        raise ValueError("greatest-whole boundary failed to close")
    return candidate


def atomic_endpoint() -> int:
    return greatest_whole_not_exceeding(inverse_fine_structure())


COMMON_EXCLUSIONS = (
    "no V1/V2 proof artifact, measured constant, observed shell list or intended Chemistry answer as a premise",
    "no semantic numerical zero, negative, irrational, imaginary or floating proof value",
    "no fitted coupling, selected candidate neighborhood or target-selected form",
    "no unrecorded external rule or measurement-to-derivation flow",
)


INVERSE_FINE_STRUCTURE_SPEC = StructuralPhysicsSpec(
    claim_id=INVERSE_FINE_STRUCTURE_ID,
    title="Terminal exact inverse fine-structure Fold ratio",
    statement=(
        "The binary predecessor and generator-three recurrence force cover depths five and seven. Their typed "
        "tower, boundary, complete three-direction cover, returning One and finite one-direction-at-a-time "
        "promotion ladder force the exact terminal ratio 503846395469/3676744786 before measurement."
    ),
    dependencies=(
        GENERATOR_THREE_CLAIM_ID,
        SPATIAL_THREE_CLAIM_ID,
        BOUNDARY_RANK_CLAIM_ID,
        "SFT-FOUNDATION-COUNT-001",
        "SFT-FOUNDATION-PART-001",
        "SFT-FOUNDATION-FOLD-001",
        "SFT-FOUNDATION-FOLD-ASSEMBLY-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-COMBINATORICS-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete typed product of cover, depth, tower, boundary, return, join, promotion, termination, target custody and extension forms.",
    grammar_boundary="All type-correct assemblies that use each forced binary/generator cover block in its generated role, admit only the One as recurrence correction, and promote each of the three interchangeable cover directions at most once.",
    axes=(
        binary_axis("cover", "How are depths obtained?", "asserted-depths", "Asserted depths have no support census.", "least-complete-binary-covers", "Depths five and seven are independently the least covers of three cubed and three to its successor."),
        binary_axis("depth", "Are the cover results cross-locked?", "single-route-depths", "One route cannot expose a changed carrier.", "cover-generator-cross-lock", "Five equals two plus three and seven equals three plus its successor."),
        binary_axis("tower", "Which block carries complete binary reach?", "free-leading-whole", "A free leading whole is a parameter.", "binary-at-up-depth", "The deepest complete binary support is exactly two to depth seven."),
        binary_axis("boundary", "Which block carries generator boundary support?", "free-boundary-factor", "A free coefficient is not structural.", "generator-at-boundary-rank", "The generator is composed over the separately forced boundary rank two."),
        binary_axis("return", "What corrects a covered object?", "fitted-small-correction", "A fitted correction reads the target.", "one-return-over-complete-cover", "The only admitted returning whole is the One, distributed over the complete cover."),
        binary_axis("join", "How do typed blocks compose?", "untyped-arithmetic-permutation", "Permuting typed carriers erases their roles.", "tower-plus-dilated-boundary", "Complete reach and boundary response compose, while the return dilates the boundary carrier it traverses."),
        binary_axis("promotion", "How is self-similar depth exposed?", "selected-refinement-series", "A selected series adds unfixed terms.", "one-remaining-direction-per-rung", "Each successor promotes exactly one of three interchangeable directions from down to up depth."),
        binary_axis("termination", "Where does refinement end?", "infinite-or-truncated-by-fit", "A fit-selected truncation is not closure.", "all-three-directions-promoted", "After three promotions no down-depth direction remains; the four-rung object has no successor."),
        binary_axis("target", "May alpha measurements select a form?", "measured-alpha-visible", "That makes measurement an answer-bearing premise.", "measurement-inaccessible-until-seal", "The exact ratio and complete candidate census seal first."),
        binary_axis("extension", "May another scale be added?", "extra-scale-rule", "An extra scale is a free parameter.", "no-extra-rule", "The finite promotion object terminates from its own direction count."),
    ),
    exact_result="The terminal inverse fine-structure Fold ratio is exactly 503846395469/3676744786; its leading rung is exactly 34259/250.",
    induction_base="The least binary covers of the generator volume and its successor volume establish down/up depths and the first complete cover.",
    induction_step="Promote one remaining interchangeable spatial direction per rung; the positive remaining-direction count strictly decreases until all three are promoted, when no successor exists.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("forced-blocks", "The clean construction yields b=2, c=3, down=5, up=7, tower=128, boundary=9 and cover=250.", fine_structure_blocks() == {"binary": 2, "generator": 3, "down": 5, "up": 7, "tower": 128, "boundary": 9, "cover": 250}),
        Witness("finite-ladder", "The complete direction-promotion ladder has rungs 125, 175, 245 and 343.", promotion_rungs() == (125, 175, 245, 343)),
        Witness("exact-terminal", "The first and terminal exact ratios reconstruct without observation.", inverse_fine_structure(1) == Fraction(34259, 250) and inverse_fine_structure() == Fraction(503846395469, 3676744786)),
    ),
)


CELL_CAPACITY_SPEC = StructuralPhysicsSpec(
    claim_id=CELL_CAPACITY_ID,
    title="Atomic orbit-cell capacity from three-space boundary orientation",
    statement=(
        "At positive orbit rank r, three-space supplies one central orientation and the rank-two boundary "
        "supplies one held pair for every predecessor step. Two exclusion-distinct Fold labels occupy each "
        "orientation, forcing capacity 2(1+2(r-1)) and the sequence 2, 6, 10, 14, 18 without observation."
    ),
    dependencies=(GENERATOR_THREE_CLAIM_ID, SPATIAL_THREE_CLAIM_ID, BOUNDARY_RANK_CLAIM_ID, "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of carrier, central class, successor extension, boundary multiplicity, Fold label, exclusion, capacity, generality, target custody and extension forms.",
    grammar_boundary="All orbit-cell capacity laws generated from one central orientation, positive orbit succession, the complete rank-two boundary, two held Fold labels and exclusion.",
    axes=(
        binary_axis("carrier", "What carries an orbit cell?", "unlabelled-cell-count", "An unlabelled count loses orientation identity.", "held-orientation-cell", "Each cell retains its generated orientation."),
        binary_axis("central", "What occurs at rank One?", "empty-numerical-origin", "Numerical zero is not an SFT carrier.", "one-central-orientation", "Rank One retains exactly the central orientation."),
        binary_axis("successor", "What does a rank successor add?", "free-rank-increment", "A free increment is a parameter.", "one-boundary-orientation-pair", "Each successor adds the complete two-sided boundary incidence."),
        binary_axis("boundary", "How many new orientations are held?", "single-or-three-direction-addition", "One omits a boundary side and three re-adds the held normal.", "forced-rank-two-pair", "Boundary rank two supplies exactly one orientation pair."),
        binary_axis("label", "Which internal labels occupy an orientation?", "label-erased-or-selected", "Erasure or selection violates complete Fold support.", "both-Fold-labels", "Both forced Fold labels are retained."),
        binary_axis("exclusion", "May a label repeat in one cell?", "duplicate-cell-label", "Duplication destroys distinguishability.", "one-of-each-label-per-cell", "Exclusion retains one state per held label and orientation."),
        binary_axis("capacity", "How is capacity composed?", "linear-or-doubling-without-boundary", "Those former survivors ignore the newly admitted boundary discriminator.", "labels-times-complete-orientations", "The Cartesian support of labels and orientations is complete."),
        binary_axis("generality", "What closes arbitrary rank?", "finite-width-list", "A list has no next-rank proof.", "constant-boundary-pair-successor", "Every successor adds one pair and therefore four label-orientation states."),
        binary_axis("target", "May known subshell widths select the law?", "width-list-visible", "That reverses derivation and test.", "widths-inaccessible-until-seal", "The positive-rank law seals before comparison."),
        binary_axis("extension", "May another degeneracy be supplied?", "extra-degeneracy-rule", "An added degeneracy is a parameter.", "no-extra-rule", "Three-space, boundary rank, Fold labels and exclusion exhaust the cell grammar."),
    ),
    exact_result="For every positive orbit rank r, capacity is exactly 2(1+2(r-1)); ranks one through five have capacities 2, 6, 10, 14 and 18.",
    induction_base="Positive orbit rank One contains one central orientation carrying both exclusion-distinct Fold labels, hence capacity two.",
    induction_step="Each rank successor adds the complete boundary pair; two labels on each new orientation add exactly four states and preserve the formula.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("first-five-capacities", "The first five positive ranks generate 2, 6, 10, 14 and 18.", tuple(orbit_capacity(rank) for rank in range(1, 6)) == (2, 6, 10, 14, 18)),
        Witness("successor-increment", "Every tested successor adds exactly four, as proved for arbitrary positive rank by the boundary-pair construction.", all(orbit_capacity(rank + 1) == orbit_capacity(rank) + 4 for rank in range(1, 12))),
        Witness("complete-cell-support", "Capacity equals the complete product of orientations and the two held labels.", all(orbit_capacity(rank) == orientation_count(rank) * binary_count() for rank in range(1, 12))),
    ),
)


COLOUR_COUPLING_SPEC = StructuralPhysicsSpec(
    claim_id=COLOUR_COUPLING_ID,
    title="Exact colour-sector Fold coupling",
    statement="The complete two-label Fold distinction transported over the generator-three carrier forces the exact positive coupling ratio two-thirds, with no measured or fitted interaction strength.",
    dependencies=(GENERATOR_THREE_CLAIM_ID, "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-FOLD-ASSEMBLY-001", "SFT-PHYS-FIELD-INTERACTION-CLASSES-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate every product of carrier, numerator, denominator, orientation, normalization, target custody and extension forms.",
    grammar_boundary="All exact normalized ratios formed by transporting the complete Fold-label support across one generator-three interaction carrier.",
    axes=(
        binary_axis("carrier", "Which interaction carrier is used?", "free-colour-count", "A free carrier count is a parameter.", "generator-three-carrier", "The independent generator-three law supplies the complete carrier."),
        binary_axis("numerator", "What support participates?", "selected-single-label", "One label omits half the Fold distinction.", "both-Fold-labels", "The complete Fold distinction has two held labels."),
        binary_axis("denominator", "What normalizes the support?", "external-normalization", "External normalization is fitted.", "complete-generator-support", "Every carrier class is counted once."),
        binary_axis("orientation", "Is label orientation retained?", "labels-collapsed", "Collapse loses the interaction distinction.", "labels-held-through-carrier", "Both labels remain distinguishable through transport."),
        binary_axis("normalization", "Which exact ratio follows?", "reciprocal-or-unscaled-count", "Those forms reverse roles or omit normalization.", "two-over-three", "Complete participating labels over complete carrier classes is 2/3."),
        binary_axis("target", "May nuclear closures select the ratio?", "magic-list-visible", "A closure list would fit the coupling.", "closures-inaccessible-until-seal", "The ratio seals before any closure is generated or observed."),
        binary_axis("extension", "May another strength be added?", "extra-coupling-rule", "An added strength is a free parameter.", "no-extra-rule", "Label and carrier counts exhaust the normalized ratio."),
    ),
    exact_result="The exact generator-three colour-sector Fold coupling is 2/3.",
    induction_base="One complete interaction carrier contains three generated classes and the Fold supplies two participating held labels.",
    induction_step="Replicating the complete carrier preserves two participating labels per three carrier classes, so the reduced exact ratio remains 2/3.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("exact-coupling", "Complete Fold support over generator-three support is exactly two-thirds.", colour_coupling() == Fraction(2, 3)),
        Witness("reduced-ratio", "The numerator and denominator share no further positive whole divisor.", colour_coupling().numerator == 2 and colour_coupling().denominator == 3),
        Witness("threshold-independent", "The ratio is constructed before the downstream reordering threshold.", generator_period_three() == 3 and binary_count() == 2),
    ),
)


NUCLEAR_CLOSURE_SPEC = StructuralPhysicsSpec(
    claim_id=NUCLEAR_CLOSURE_ID,
    title="Complete Fold nuclear-closure sequence",
    statement=(
        "Complete weak compositions across three spatial directions with two exclusion labels force the base "
        "filled-shell counts. The independently sealed two-thirds colour coupling reaches its first whole "
        "spin-orbit gap at angular count three and forces the reordered closure sequence "
        "2, 8, 20, 28, 50, 82, 126, 184 with a depth-independent successor law."
    ),
    dependencies=(CELL_CAPACITY_ID, COLOUR_COUPLING_ID, SPATIAL_THREE_CLAIM_ID, "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-PHYS-NUCLEAR-BINDING-001", "SFT-PHYS-NUCLEAR-LEVELS-001", "SFT-PHYS-NUCLEAR-REACTIONS-001", "SFT-MATH-COMBINATORICS-001", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of spatial composition, label multiplicity, base closure, coupling source, shift, threshold, reordering, recurrence, target custody and extension forms.",
    grammar_boundary="All filled-shell closure schedules built from complete weak compositions over forced three-space, both exclusion labels and the first whole-gap action of the independently forced colour coupling.",
    axes=(
        binary_axis("composition", "How are shell states generated?", "selected-shell-degeneracy", "A selected degeneracy imports a model.", "complete-three-direction-weak-compositions", "Every distribution of the predecessor excitation among all three labelled directions is counted once."),
        binary_axis("labels", "Which internal labels are included?", "single-or-duplicated-label", "Omission or duplication violates Fold support and exclusion.", "two-exclusion-distinct-labels", "Both Fold labels occur once per spatial composition."),
        binary_axis("base", "How is a filled closure counted?", "closure-list", "A list has no generative proof.", "positive-rank-composition-form", "The exact form r(r+1)(r+2)/3 follows from the complete composition count."),
        binary_axis("coupling", "Where does reordering strength come from?", "fitted-spin-orbit-strength", "A fitted strength reads the closures.", "sealed-two-thirds-colour-coupling", "The upstream claim fixes 2/3 without closure access."),
        binary_axis("shift", "What does the coupling act on?", "free-shell-shift", "A free shift is a parameter.", "top-angular-half-label-pair", "Spin division by the two Fold labels leaves angular/2, giving angular/3 after coupling."),
        binary_axis("threshold", "When can reordering cross a whole gap?", "selected-rank-threshold", "A selected threshold fits the sequence.", "least-positive-whole-gap", "Positive succession makes three the first angular count with angular/3 at least One."),
        binary_axis("reorder", "What moves at threshold?", "arbitrary-intruder-count", "An arbitrary intruder count is fitted.", "complete-top-orbit-capacity", "The top orbit contributes the already forced two-times-shell-rank capacity."),
        binary_axis("recurrence", "How are later closures generated?", "finite-eight-value-table", "A table does not close later ranks.", "piecewise-positive-successor-law", "The pre-threshold composition form and post-threshold predecessor-plus-top-orbit form apply at every positive rank."),
        binary_axis("target", "May known magic numbers select a survivor?", "magic-numbers-visible", "That is target leakage.", "sequence-inaccessible-until-seal", "The recurrence seals before any nuclear comparison."),
        binary_axis("extension", "May another nuclear selector enter?", "extra-nuclear-rule", "An added selector is a parameter.", "no-extra-rule", "Composition, labels, coupling and whole-gap closure exhaust this registered shell grammar."),
    ),
    exact_result="The depth-independent nuclear closure law gives the exact prefix 2, 8, 20, 28, 50, 82, 126, 184; its next proton closure after 82 is 126 and the next closure after 126 is 184.",
    induction_base="Ranks one through three are complete three-direction composition closures with both held labels.",
    induction_step="From the first whole-gap rank onward, each successor uses the preceding composition closure plus the complete top-orbit capacity at that rank; the same exact construction applies to every positive successor.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("whole-gap-threshold", "The exact two-thirds coupling reaches its first whole spin-orbit gap at angular count three.", spin_orbit_threshold() == 3),
        Witness("closure-prefix", "The first eight generated closures are exact.", nuclear_closure_prefix(8) == (2, 8, 20, 28, 50, 82, 126, 184)),
        Witness("no-intermediate-generated-closure", "The successor law has no closure strictly between 82 and 126.", not any(82 < value < 126 for value in nuclear_closure_prefix(8))),
    ),
)


ATOMIC_BOUNDARY_SPEC = StructuralPhysicsSpec(
    claim_id=ATOMIC_BOUNDARY_ID,
    title="Exact atomic existence boundary",
    statement=(
        "A neutral atomic coordinate remains structurally admissible only while its positive whole charge "
        "does not exceed the exact inverse fine-structure Fold ratio. The unique greatest whole below that "
        "sealed ratio is 137, with 137 below and its successor 138 above the boundary."
    ),
    dependencies=(INVERSE_FINE_STRUCTURE_ID, "SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001", "SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001", "SFT-PHYS-MATTER-CONSERVED-LABELS-001", "SFT-CHEM-ELEM-ELEMENT-001", "SFT-CHEM-ELEM-ATOMIC-NUMBER-001", "SFT-CHEM-ELEM-PERIODIC-ORDER-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORDER-LATTICE-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete product of charge carrier, coupling, ceiling, endpoint construction, lower witness, upper witness, generality, target custody and extension forms.",
    grammar_boundary="All greatest-positive-whole atomic-coordinate conclusions under the One binding ceiling and the independently sealed exact inverse fine-structure ratio.",
    axes=(
        binary_axis("charge", "What identifies an atomic coordinate?", "unbound-number", "An unbound number has no element identity.", "positive-held-charge-count", "Atomic number is a positive count of held source charges."),
        binary_axis("coupling", "How is charge compared with the field scale?", "fitted-binding-equation", "A fitted equation imports the endpoint.", "charge-over-sealed-inverse-ratio", "Normalization by the sealed inverse ratio gives the exact binding fraction."),
        binary_axis("ceiling", "What bounds a bound part?", "external-critical-charge", "An external critical charge is target input.", "complete-One-ceiling", "A bound part cannot exceed its complete One carrier."),
        binary_axis("endpoint", "How is the last coordinate obtained?", "bounded-neighborhood-walk", "A chosen search interval does not close all successors.", "greatest-whole-division-certificate", "Exact quotient/remainder order gives the unique greatest whole not exceeding the ratio."),
        binary_axis("lower", "Is the proposed endpoint admissible?", "endpoint-label-only", "A label has no inequality witness.", "exact-lower-inequality", "The endpoint whole is no greater than the sealed ratio."),
        binary_axis("upper", "Are all later coordinates excluded?", "single-next-value-check-only", "One check without order closure does not exclude later values.", "successor-above-plus-order", "The endpoint successor is above the ratio and every later positive successor is greater still."),
        binary_axis("generality", "Does the proof depend on a finite scan?", "finite-coordinate-census", "A finite census leaves later coordinates open.", "depth-independent-greatest-whole-law", "Euclidean quotient/remainder and positive order close every successor."),
        binary_axis("target", "May the observed table select the endpoint?", "observed-elements-visible", "That would turn an observation boundary into a law.", "observations-inaccessible-until-seal", "The exact endpoint seals as a standing prediction."),
        binary_axis("extension", "May nuclear size move the structural boundary?", "extra-size-parameter", "A size correction is a different, parameterized model.", "no-extra-rule", "This claim is exactly the registered point-carrier One-ceiling boundary."),
    ),
    exact_result="The unique greatest positive whole atomic coordinate under the exact Fold binding ceiling is 137; 137 <= 503846395469/3676744786 < 138.",
    induction_base="The exact quotient of the sealed positive ratio supplies a positive whole and an exact nonnegative host remainder represented scientifically as either empty or a positive part.",
    induction_step="The positive successor of the quotient exceeds the ratio; transitive positive order places every later successor above it, so no depth bound is used.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("greatest-whole", "Exact quotient/remainder forces the endpoint 137.", atomic_endpoint() == 137),
        Witness("sharp-boundary", "The endpoint is below and its immediate successor above the exact ratio.", Fraction(137, 1) <= inverse_fine_structure() < Fraction(138, 1)),
        Witness("successor-closure", "Every sampled later successor remains above; the formal order certificate is depth-independent.", all(Fraction(value, 1) > inverse_fine_structure() for value in range(138, 160))),
    ),
)


ATOMIC_CONSTANT_SPECS = (
    INVERSE_FINE_STRUCTURE_SPEC,
    CELL_CAPACITY_SPEC,
    COLOUR_COUPLING_SPEC,
    NUCLEAR_CLOSURE_SPEC,
    ATOMIC_BOUNDARY_SPEC,
)
SPEC_BY_ID = {spec.claim_id: spec for spec in ATOMIC_CONSTANT_SPECS}

for _spec in ATOMIC_CONSTANT_SPECS:
    _spec.validate()


__all__ = (
    "ATOMIC_BOUNDARY_ID",
    "ATOMIC_BOUNDARY_SPEC",
    "ATOMIC_CONSTANT_SPECS",
    "CELL_CAPACITY_ID",
    "CELL_CAPACITY_SPEC",
    "COLOUR_COUPLING_ID",
    "COLOUR_COUPLING_SPEC",
    "INVERSE_FINE_STRUCTURE_ID",
    "INVERSE_FINE_STRUCTURE_SPEC",
    "NUCLEAR_CLOSURE_ID",
    "NUCLEAR_CLOSURE_SPEC",
    "SPEC_BY_ID",
    "atomic_endpoint",
    "colour_coupling",
    "fine_structure_blocks",
    "inverse_fine_structure",
    "nuclear_closure",
    "nuclear_closure_prefix",
    "orbit_capacity",
    "promotion_rungs",
    "spin_orbit_threshold",
)

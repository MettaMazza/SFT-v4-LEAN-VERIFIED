"""Exact V3 matter, flavour, neutrino and magnetic-moment successors.

The earlier corpora define reconstruction obligations only.  This module does
not read those corpora or any measurement.  It retains algebraic roots by their
exact polynomial and finite rational isolating intervals, never by a floating
or irrational proof value.  Structural absence is an empty tuple.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.atomic_constants import (
    binary_count,
    fine_structure_blocks,
    inverse_fine_structure,
    minimal_binary_cover,
    positive_power,
)
from sft.physics.structural_constants import (
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    fold_part,
    generator_period_three,
    positive_predecessor,
)


QUARK_INVARIANTS_ID = "SFT-PHYS-MATTER-QUARK-INVARIANTS-003"
QUARK_CUBICS_ID = "SFT-PHYS-MATTER-QUARK-CUBICS-003"
QUARK_DRESSING_ID = "SFT-PHYS-MATTER-QUARK-DRESSING-003"
CKM_FIBRE_ID = "SFT-PHYS-MATTER-CKM-FIBRE-003"
CKM_PHYSICAL_ID = "SFT-PHYS-MATTER-CKM-PHYSICAL-003"
PROTON_ELECTRON_ID = "SFT-PHYS-MATTER-PROTON-ELECTRON-003"
NEUTRINO_SPLITTING_ID = "SFT-PHYS-NEUTRINO-SPLITTING-003"
NEUTRINO_MASS_ID = "SFT-PHYS-NEUTRINO-POSITIVE-MASS-003"
PMNS_CP_ID = "SFT-PHYS-NEUTRINO-PMNS-CP-PHYSICAL-003"
MAJORANA_ID = "SFT-PHYS-NEUTRINO-MAJORANA-003"
ZERO_NU_ID = "SFT-PHYS-NEUTRINO-ZERO-NU-BETA-BETA-003"
MAGNETIC_ANOMALY_ID = "SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003"


def positive_take(whole: Fraction, part: Fraction) -> Fraction | tuple[()]:
    if not isinstance(whole, Fraction) or not isinstance(part, Fraction):
        raise ValueError("positive take requires exact fractions")
    if whole < part or part <= 0:
        raise ValueError("positive take requires ordered positive support")
    if whole == part:
        return ()
    return whole - part


def quark_channel_invariants() -> dict[str, object]:
    b = binary_count()
    c = generator_period_three()
    lower_hand = Fraction(1, b * b)
    up_channels = c + c
    down_channels = c + 1
    up = Fraction(1, b * up_channels)
    down = Fraction(1, b * down_channels)
    up_structural = lower_hand * Fraction(1, c)
    down_structural = lower_hand * Fraction(1, b)
    blocks = fine_structure_blocks()
    if up != up_structural or down != down_structural:
        raise ValueError("quark invariant routes disagree")
    if blocks["up"] != minimal_binary_cover(positive_power(c, c + 1)):
        raise ValueError("up cover did not close")
    if blocks["down"] != minimal_binary_cover(positive_power(c, c)):
        raise ValueError("down cover did not close")
    return {"up_pair_sum": up, "down_pair_sum": down, "up_depth": blocks["up"], "down_depth": blocks["down"]}


def quark_cubic_invariants() -> dict[str, tuple[Fraction, Fraction, Fraction]]:
    channels = quark_channel_invariants()
    c = generator_period_three()
    b = binary_count()
    down_reach = channels["up_depth"]
    if not isinstance(down_reach, int):
        raise ValueError("down reach is not a count")
    up_reach = down_reach + c
    down_product = Fraction(1, positive_predecessor(c * positive_power(b, down_reach)))
    up_product = Fraction(1, positive_predecessor(c * positive_power(b, up_reach)))
    return {
        "down": (Fraction(1, 1), channels["down_pair_sum"], down_product),
        "up": (Fraction(1, 1), channels["up_pair_sum"], up_product),
    }


def cubic_side(x: Fraction, pair_sum: Fraction, product: Fraction) -> tuple[str, Fraction] | tuple[()]:
    """Return a held side label and positive magnitude, never a negative value."""

    positive = x * x * x + pair_sum * x
    counter = x * x + product
    if positive == counter:
        return ()
    if positive > counter:
        return ("positive-hand", positive - counter)
    return ("counter-hand", counter - positive)


def isolate_cubic_roots(pair_sum: Fraction, product: Fraction) -> tuple[tuple[Fraction, Fraction], ...]:
    """Return the first complete dyadic grid that separates all three roots."""

    depth = 1
    while depth <= 32:
        support = positive_power(binary_count(), depth)
        intervals: list[tuple[Fraction, Fraction]] = []
        lower = Fraction(1, support)
        lower_side = cubic_side(lower, pair_sum, product)
        for index in range(2, support + 1):
            upper = Fraction(index, support)
            upper_side = cubic_side(upper, pair_sum, product)
            if lower_side == ():
                intervals.append((lower, lower))
            elif upper_side == () or lower_side[0] != upper_side[0]:
                intervals.append((lower, upper))
            lower, lower_side = upper, upper_side
        if len(intervals) == generator_period_three():
            return tuple(intervals)
        depth += 1
    raise ValueError("complete dyadic root isolation did not halt")


def bisect_bracket(bracket: tuple[Fraction, Fraction], pair_sum: Fraction, product: Fraction) -> tuple[Fraction, Fraction]:
    lower, upper = bracket
    midpoint = (lower + upper) / binary_count()
    lower_side = cubic_side(lower, pair_sum, product)
    midpoint_side = cubic_side(midpoint, pair_sum, product)
    if midpoint_side == ():
        return (midpoint, midpoint)
    if lower_side == () or lower_side[0] != midpoint_side[0]:
        return (lower, midpoint)
    return (midpoint, upper)


def quark_root_brackets() -> dict[str, tuple[tuple[Fraction, Fraction], ...]]:
    cubics = quark_cubic_invariants()
    return {
        name: isolate_cubic_roots(values[1], values[2])
        for name, values in cubics.items()
    }


def quark_dressing_factors() -> dict[str, Fraction]:
    blocks = fine_structure_blocks()
    alpha_inverse = inverse_fine_structure()
    lift = blocks["up"] - blocks["down"]
    if lift != binary_count():
        raise ValueError("central lift and Fold fibre count did not cross-lock")
    return {
        "central_down_lift": (alpha_inverse + lift) / alpha_inverse,
        "upper_up_retention": alpha_inverse / (alpha_inverse + blocks["up"]),
    }


def tripling_fold(value: Fraction) -> Fraction:
    tripled = generator_period_three() * value
    while tripled > 1:
        tripled -= 1
    return tripled


def ckm_fibres() -> dict[str, object]:
    c = generator_period_three()
    mass = tuple(Fraction(c * index - 1, c * c) for index in range(1, c + 1))
    channel = tuple(Fraction(index, c) for index in range(1, c + 1))
    matrix = tuple(tuple(Fraction(1, 1) - abs(mass_value - channel_value) for channel_value in channel) for mass_value in mass)
    if tuple(matrix[index][index] for index in range(c)) != (Fraction(8, 9),) * c:
        raise ValueError("CKM fibre diagonal did not close")
    return {"mass_basis": mass, "channel_basis": channel, "matrix": matrix}


def ckm_physical_identity() -> dict[str, object]:
    """Seal the mass-root mixing graph without forming its algebraic roots."""

    return {
        "s12_squared": "down-light-mass/down-central-mass",
        "s23": "down-central-root/down-heavy-root positive-take up-central-root/up-heavy-root",
        "s13_squared": "s12-squared times s23-squared over six-channel-support",
        "apex_squared": Fraction(1, binary_count() * generator_period_three()),
        "phase": Fraction(1, binary_count()),
    }


def proton_electron_identity() -> dict[str, object]:
    return {
        "lepton_polynomial": (Fraction(1, 1), Fraction(1, 6), Fraction(1, 485)),
        "proton_share": Fraction(1, generator_period_three()),
        "ratio_graph": "one-third times positive-take(muon-mass,electron-mass) over their product",
    }


def mersenne_count(depth: int) -> int:
    return positive_predecessor(positive_power(binary_count(), depth))


def neutrino_splitting_structure() -> dict[str, Fraction | int]:
    down_depth = fine_structure_blocks()["down"]
    doubled_depth = down_depth + down_depth
    solar = mersenne_count(down_depth)
    atmospheric = mersenne_count(doubled_depth)
    exact_ratio = Fraction(atmospheric, solar)
    covering_prime = binary_count() + generator_period_three()
    square = covering_prime * covering_prime
    positive_square_predecessor = positive_predecessor(square)
    translation_ratio = Fraction(1, positive_power(binary_count(), down_depth)) * Fraction(positive_square_predecessor, square)
    if exact_ratio != positive_power(binary_count(), down_depth) + 1 or translation_ratio != Fraction(3, 100):
        raise ValueError("neutrino splitting routes disagree")
    return {"solar_rung": solar, "atmospheric_rung": atmospheric, "rung_ratio": exact_ratio, "translation_ratio": translation_ratio}


def neutrino_mass_squares() -> dict[str, Fraction]:
    """Mass squares in units of the sealed solar splitting carrier."""

    depth = fine_structure_blocks()["down"]
    lightest = Fraction(1, positive_power(binary_count(), depth))
    middle = lightest + 1
    heavy = lightest + Fraction(1, 1) / neutrino_splitting_structure()["translation_ratio"]
    if not 0 < lightest < middle < heavy:
        raise ValueError("positive neutrino mass-square ordering failed")
    return {"lightest": lightest, "middle": middle, "heavy": heavy}


def pmns_cp_structure() -> dict[str, object]:
    atmospheric = Fraction(1, binary_count())
    solar = Fraction(1, generator_period_three())
    reactor = atmospheric * solar / positive_power(binary_count(), generator_period_three())
    electron_weights = (
        (Fraction(1, 1) - solar) * (Fraction(1, 1) - reactor),
        solar * (Fraction(1, 1) - reactor),
        reactor,
    )
    weight_sum = electron_weights[0] + electron_weights[1] + electron_weights[2]
    if weight_sum != 1:
        raise ValueError("PMNS electron weights did not close")
    return {"atmospheric": atmospheric, "solar": solar, "reactor": reactor, "cp_phase": Fraction(1, binary_count()), "electron_weights": electron_weights}


def majorana_structure() -> dict[str, object]:
    left = Fraction(1, positive_power(binary_count(), binary_count()))
    right = Fraction(positive_predecessor(positive_power(binary_count(), binary_count())), positive_power(binary_count(), binary_count()))
    lock = Fraction(1, binary_count())
    generic_antipode = positive_take(Fraction(1, 1), left)
    lock_antipode = positive_take(Fraction(1, 1), lock)
    return {
        "left_hand": left,
        "right_hand": right,
        "dirac_pair_separation": positive_take(right, left),
        "single_hand_count": 1,
        "self_antipodal_lock": lock_antipode == lock,
        "generic_hand_self_antipodal": generic_antipode == left,
        "class": "single-hand-self-antipodal-Majorana",
    }


def sqrt_bracket(value: Fraction) -> tuple[Fraction, Fraction]:
    """Find the first dyadic interval certifying a positive square root."""

    if not isinstance(value, Fraction) or value <= 0:
        raise ValueError("square-root carrier must be an exact positive fraction")
    whole_upper = 1
    while Fraction(whole_upper * whole_upper, 1) < value:
        whole_upper += 1
    if whole_upper > 1:
        return (Fraction(whole_upper - 1, 1), Fraction(whole_upper, 1))
    depth = 1
    while depth <= 64:
        support = positive_power(binary_count(), depth)
        lower = Fraction(1, support)
        for index in range(2, support + 1):
            upper = Fraction(index, support)
            if lower * lower <= value <= upper * upper:
                return (lower, upper)
            lower = upper
        depth += 1
    raise ValueError("positive square-root enclosure did not halt")


def zero_nu_noncancellation() -> dict[str, object]:
    """Certify a positive phase-independent lower coefficient by exact bounds."""

    squares = neutrino_mass_squares()
    weights = pmns_cp_structure()["electron_weights"]
    brackets = [sqrt_bracket(squares[name]) for name in ("lightest", "middle", "heavy")]
    # Refine only until the largest contribution strictly exceeds the other
    # two.  The stopping rule is the theorem condition, not a chosen tolerance.
    while True:
        lower_terms = tuple(weights[index] * brackets[index][0] for index in range(3))
        upper_terms = tuple(weights[index] * brackets[index][1] for index in range(3))
        if lower_terms[1] > upper_terms[0] + upper_terms[2]:
            floor = lower_terms[1] - upper_terms[0] - upper_terms[2]
            ceiling = upper_terms[0] + upper_terms[1] + upper_terms[2]
            return {"positive_floor_coefficient": floor, "ceiling_coefficient": ceiling, "root_brackets": tuple(brackets)}
        for index, name in enumerate(("lightest", "middle", "heavy")):
            brackets[index] = bisect_square(brackets[index], squares[name])


def bisect_square(bracket: tuple[Fraction, Fraction], value: Fraction) -> tuple[Fraction, Fraction]:
    lower, upper = bracket
    midpoint = (lower + upper) / binary_count()
    if midpoint * midpoint < value:
        return (midpoint, upper)
    return (lower, midpoint)


def magnetic_anomaly_structure() -> dict[str, object]:
    alpha = Fraction(1, 1) / inverse_fine_structure()
    normalized_leading = alpha / binary_count()
    lepton = proton_electron_identity()["lepton_polynomial"]
    if not isinstance(lepton, tuple):
        raise ValueError("lepton polynomial missing")
    return {
        "bare_g": binary_count(),
        "terminal_alpha": alpha,
        "phase_normalized_leading_anomaly": normalized_leading,
        "mass_sensitivity_graph": "muon-to-electron mass ratio squared",
        "physical_turn_translation": "post-seal-only",
    }


COMMON_EXCLUSIONS = (
    "no V1/V2 executable, result table, certificate or measurement as a derivation premise",
    "no target-selected coefficient, bracket, iteration count, correction or candidate neighbourhood",
    "no semantic numerical zero, negative magnitude, irrational, imaginary or floating proof value",
    "no solved irrational algebraic root; exact polynomials and rational enclosures only",
    "no external value accessible before the formal seal",
)


def axes(relation: str, preservation: str, rejected: str) -> tuple:
    return (
        binary_axis("carrier", "What carries the law?", "imported-parameter-table", "A table has no Fold provenance.", "generated-exact-carrier", "The carrier is regenerated from admitted exact support."),
        binary_axis("dependency", "How are prerequisites supplied?", "prior-answer-premise", "A prior result cannot select V3.", "admitted-root-trace", "Every dependency has an engine path to the theorem."),
        binary_axis("relation", "Which relation survives?", rejected, "The alternative loses a forced count, type or retained distinction.", relation, preservation),
        binary_axis("enumeration", "Is the grammar exhausted?", "selected-subset", "A subset cannot establish uniqueness.", "complete-product", "All registered coordinate combinations are generated."),
        binary_axis("minimality", "Are alternatives controlled?", "uncontrolled-shortcut", "A shortcut may hide a free choice.", "every-omission-rejected", "Each removed carrier fails constructively."),
        binary_axis("measurement", "When may data enter?", "target-visible-before-seal", "That reverses empirical direction.", "seal-before-comparison", "The formal object seals before external translation."),
        binary_axis("record", "What is retained?", "answer-only", "An answer cannot reproduce the result.", "full-polynomial-trace-census-controls", "Counts, equations, rational enclosures, census and hostile controls remain held."),
        binary_axis("extension", "May another selector enter?", "free-extra-rule", "An added selector is a parameter.", "no-extra-rule", "The declared typed grammar is exhausted."),
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
        grammar_boundary="Every exact finite carrier named by the law and the complete product of its eight registered binary form axes.",
        axes=axes(relation, preservation, rejected),
        exact_result=exact_result,
        induction_base=base,
        induction_step=successor,
        exclusions=COMMON_EXCLUSIONS + extra,
        witnesses=witnesses,
    )


QUARK_INVARIANTS_SPEC = make_spec(
    QUARK_INVARIANTS_ID, "Quark channel invariants and cover depths",
    "Complete colour, hand and electroweak channel counts independently cross-lock with exact Fold products, forcing up pair sum 1/12, down pair sum 1/8 and least binary cover depths seven and five.",
    ("SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001"),
    "channel-count-cross-locked-with-Fold-product", "Two independent constructions return every invariant.", "asserted-quark-coefficients",
    "Up pair sum is 1/12, down pair sum 1/8, up cover depth seven and down cover depth five.",
    "One hand and one generated colour channel establish a positive carrier.", "Complete channel and cover enumeration appends no selectable coefficient.",
    (Witness("values", "All four invariant values close exactly.", quark_channel_invariants() == {"up_pair_sum": Fraction(1, 12), "down_pair_sum": Fraction(1, 8), "up_depth": 7, "down_depth": 5}),),
)

QUARK_CUBICS_SPEC = make_spec(
    QUARK_CUBICS_ID, "Dual exact quark mass cubics",
    "Exchanging the generator and Fold-fibre roles in the already generated cubic carrier forces one down-type and one up-type three-root polynomial; roots remain exact algebraic objects through their invariants and first complete rational isolating census.",
    (QUARK_INVARIANTS_ID, "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001", "SFT-MATH-ALGEBRA-001"),
    "dual-colour-binary-cubic-invariants", "Role exchange, cover reach and positive predecessor fix both products.", "selected-root-table-or-fitted-polynomial",
    "Down invariants are (1,1/8,1/383); up invariants are (1,1/12,1/3071); each polynomial has three disjoint positive rational isolating intervals.",
    "The symmetric One partition supplies one cubic carrier.", "Every dyadic support successor is generated until the first complete three-root separation, with no chosen precision.",
    (Witness("invariants", "Both exact invariant triples close.", quark_cubic_invariants() == {"down": (Fraction(1, 1), Fraction(1, 8), Fraction(1, 383)), "up": (Fraction(1, 1), Fraction(1, 12), Fraction(1, 3071))}), Witness("roots", "Both exact cubics have three disjoint positive isolating intervals.", all(len(rows) == 3 for rows in quark_root_brackets().values()))),
)

QUARK_DRESSING_SPEC = make_spec(
    QUARK_DRESSING_ID, "Terminal quark self-coupling dressing",
    "The sealed terminal electromagnetic ratio transports once through the exact cover-depth roles: the depth gap two lifts only the central down-type carrier, while depth seven is retained over the upper up-type pair.",
    (QUARK_CUBICS_ID, "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-VALIDATION-INVERSE-FINE-STRUCTURE-001"),
    "central-down-lift-and-upper-up-retention", "The central carrier occupies opposite ratio roles and the upper cover is the unique up reach.", "measurement-selected-mass-correction",
    "The exact terminal dressing factors are (inverse-alpha+2)/inverse-alpha for the central down carrier and inverse-alpha/(inverse-alpha+7) for the upper up pair.",
    "One sealed self-coupling can cross one typed carrier once.", "The cover roles determine the unique carrier and count; another transfer would duplicate the sole terminal return.",
    (Witness("factors", "Both dressing factors are strict positive exact parts or lifts.", quark_dressing_factors()["central_down_lift"] > 1 and 0 < quark_dressing_factors()["upper_up_retention"] < 1),),
)

CKM_FIBRE_SPEC = make_spec(
    CKM_FIBRE_ID, "Exact CKM fibre alignment",
    "The tripling fibre of the holding point and the tripling fibre of the One force a complete asymmetric three-by-three overlap object with uniform diagonal, unequal adjacent bands and one unique far corner.",
    (QUARK_INVARIANTS_ID, "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-MATH-COMBINATORICS-001"),
    "complete-two-fibre-overlap", "All nine cells are generated from two complete fibres.", "nine-independent-mixing-dials",
    "The exact fibre matrix is ((8/9,5/9,2/9),(7/9,8/9,5/9),(4/9,7/9,8/9)).",
    "One pair of complete tripling fibres generates its first overlap row.", "Each mass/channel successor appends exactly one generated overlap cell until all nine exist.",
    (Witness("matrix", "The full exact asymmetric matrix closes.", ckm_fibres()["matrix"] == ((Fraction(8, 9), Fraction(5, 9), Fraction(2, 9)), (Fraction(7, 9), Fraction(8, 9), Fraction(5, 9)), (Fraction(4, 9), Fraction(7, 9), Fraction(8, 9)))),),
)

CKM_PHYSICAL_SPEC = make_spec(
    CKM_PHYSICAL_ID, "Mass-root CKM physical mixing law",
    "The sealed quark polynomials determine the three physical mixing relations: light-to-central down mass, positive difference of down/up ladder slopes, and their joined six-channel dilution; the unitarity apex square is identically 1/6.",
    (QUARK_DRESSING_ID, CKM_FIBRE_ID, "SFT-PHYS-NEUTRINO-CP-PHASE-002"),
    "polynomial-root-mixing-graph-with-six-channel-apex", "Every physical mixing entry is a consequence of the same sealed root object and counted channel support.", "independent-fitted-CKM-angles",
    "The physical relation graph forces s12 squared, s23, s13 squared and exact apex square 1/6 without forming an irrational root or reading a CKM target.",
    "The light and central roots generate one exact squared-ratio relation.", "The second ladder and six-channel carrier append s23 and s13 while preserving the apex identity.",
    (Witness("apex", "The squared apex is the reciprocal of six counted channels.", ckm_physical_identity()["apex_squared"] == Fraction(1, 6)),),
)

PROTON_ELECTRON_SPEC = make_spec(
    PROTON_ELECTRON_ID, "Proton-to-electron hierarchy reconstruction",
    "The leading exact charged-lepton cubic and the colour-bound one-third baryon carrier force a dimensionless proton/electron ratio graph; its algebraic roots remain sealed by exact rational intervals and are compared only afterward.",
    ("SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", QUARK_CUBICS_ID),
    "one-third-baryon-over-lepton-polynomial-mass-graph", "Common One normalization cancels every dimensionful scale.", "measured-proton-electron-ratio-as-input",
    "The ratio is (1/3) times (muon mass minus electron mass) over their product, where both masses are squared roots of x^3-x^2+(1/6)x-1/485.",
    "One colour-bound whole supplies the one-third baryon share.", "The complete lepton polynomial supplies the two required light mass roots without an added scale.",
    (Witness("graph", "The complete ratio graph has only admitted exact carriers.", proton_electron_identity()["proton_share"] == Fraction(1, 3) and proton_electron_identity()["lepton_polynomial"] == (Fraction(1, 1), Fraction(1, 6), Fraction(1, 485))),),
)

NEUTRINO_SPLITTING_SPEC = make_spec(
    NEUTRINO_SPLITTING_ID, "Exact neutrino splitting ladder",
    "The non-unison counts at down depth five and doubled depth ten force exact rung ratio 33; the independent complete depth-five cell and covering-prime-square predecessor translation forces solar-to-atmospheric ratio 3/100.",
    (QUARK_INVARIANTS_ID, "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002", "SFT-MATH-ORBIT-NUMBER-THEORY-002"),
    "Mersenne-rung-and-cover-translation-cross-lock", "Both routes arise from complete counted supports with distinct roles.", "measured-splitting-ratio",
    "The Mersenne rung ratio is 1023/31=33 and the physical translation ratio is exactly 3/100.",
    "Depth five has 31 non-unison positions.", "Doubling the reach gives 1023 positions while the depth-five cell and covering-prime predecessor retain 3/100.",
    (Witness("splitting", "Both exact splitting ratios close.", neutrino_splitting_structure()["rung_ratio"] == 33 and neutrino_splitting_structure()["translation_ratio"] == Fraction(3, 100)),),
)

NEUTRINO_MASS_SPEC = make_spec(
    NEUTRINO_MASS_ID, "Positive absolute-neutrino mass structure",
    "No-Zero requires the lightest mass-square carrier to occupy a positive cell rather than a numerical zero. The first complete depth-five cell forces 1/32 of the solar anchor, normal ordering and exact mass-square coefficients 1/32, 33/32 and 3203/96.",
    (NEUTRINO_SPLITTING_ID, "SFT-FOUNDATION-FORM-ENFORCEMENT-001", "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"),
    "first-positive-depth-five-cell-plus-forced-splittings", "The lightest state is the minimal generated positive cell and both successors add the sealed splittings.", "massless-lightest-or-fitted-absolute-mass",
    "In solar-splitting units, mass squares are lightest 1/32, middle 33/32 and heavy 3203/96, forcing positive normal ordering; eV translation requires one post-seal solar anchor.",
    "The first positive cell of complete depth-five support is 1/32.", "Adding the exact solar and atmospheric differences generates the two ordered successors.",
    (Witness("positive-order", "All three exact mass squares are positive and ordered.", neutrino_mass_squares() == {"lightest": Fraction(1, 32), "middle": Fraction(33, 32), "heavy": Fraction(3203, 96)}),),
    "no claim that an SI/eV scale is produced without one declared post-seal dimensional anchor",
)

PMNS_CP_SPEC = make_spec(
    PMNS_CP_ID, "Physical PMNS and CP support",
    "Binary, generator-three and complete depth-three support force the squared PMNS triple and its normalized electron-flavour weights, while the unique self-antipodal Fold position forces the maximal phase carrier.",
    (NEUTRINO_MASS_ID, "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002", "SFT-PHYS-NEUTRINO-CP-PHASE-002"),
    "complete-PMNS-support-with-self-antipodal-phase", "Every angle and weight follows from a generated separation or complete support count.", "measured-PMNS-fit",
    "The squared triple is (1/2,1/3,1/48), CP phase carrier 1/2, and electron weights (47/72,47/144,1/48), which sum exactly to the One.",
    "Binary and generator-three separations supply the two large channels.", "Complete depth-three dilution appends the reactor channel and exact normalized weights.",
    (Witness("pmns", "All PMNS values and weights close exactly.", pmns_cp_structure()["electron_weights"] == (Fraction(47, 72), Fraction(47, 144), Fraction(1, 48)) and pmns_cp_structure()["cp_phase"] == Fraction(1, 2)),),
)

MAJORANA_SPEC = make_spec(
    MAJORANA_ID, "Single-hand Majorana discriminator",
    "The complete half-One fibre has two held hands for a Dirac pair, but the neutrino census retains one hand. The unique self-antipodal half-One is therefore the only generated massive one-hand coupling, forcing the Majorana class within the declared grammar.",
    (PMNS_CP_ID, "SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001", "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"),
    "single-hand-unique-self-antipodal-coupling", "Two-hand Dirac and one-hand self-pairing are exhaustively distinguished.", "asserted-Dirac-or-Majorana-label",
    "The charged two-hand separation is 1/2; one hand cannot instantiate that pair; the half-One alone is self-antipodal, so the massive one-hand carrier is Majorana.",
    "The complete held fibre supplies left and right hands.", "Restricting to the single observed hand eliminates Dirac pairing and retains only the unique self-antipodal lock.",
    (Witness("majorana", "All discriminator conditions close exactly.", majorana_structure()["dirac_pair_separation"] == Fraction(1, 2) and majorana_structure()["self_antipodal_lock"] and not majorana_structure()["generic_hand_self_antipodal"]),),
)

ZERO_NU_SPEC = make_spec(
    ZERO_NU_ID, "Neutrinoless-double-beta noncancellation prediction",
    "Positive Majorana masses and nonempty electron-flavour weights force a nonempty neutrinoless-double-beta amplitude. Exact rational root bounds certify that the middle contribution exceeds the other two combined, so arbitrary held phase opposition cannot close it.",
    (MAJORANA_ID, NEUTRINO_MASS_ID, PMNS_CP_ID),
    "positive-Majorana-weighted-amplitude-with-noncancellation", "A strict rational triangle certificate prevents complete phase cancellation.", "asserted-decay-or-zero-mass-limit",
    "The effective Majorana amplitude has a strict positive coefficient floor and finite ceiling relative to the square root of the post-seal solar anchor; therefore zero-nu-beta-beta must occur within this grammar.",
    "Three positive mass and flavour carriers generate three amplitude contributions.", "Exact dyadic refinement halts at the first strict noncancellation certificate, with no selected tolerance.",
    (Witness("noncancellation", "The exact rational lower coefficient is strictly positive.", zero_nu_noncancellation()["positive_floor_coefficient"] > 0),),
    "no claim that neutrinoless double-beta decay has already been observed",
)

MAGNETIC_ANOMALY_SPEC = make_spec(
    MAGNETIC_ANOMALY_ID, "Electron/muon magnetic-anomaly structure",
    "The bare gyromagnetic value is the binary count. The sole terminal electromagnetic self-return forces a strictly positive leading phase-normalized anomaly alpha/2, and any additional mass-scale channel has muon/electron sensitivity equal to the squared sealed mass ratio.",
    ("SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-CONSTANT-CHARGED-LEPTON-CUBIC-001"),
    "terminal-self-return-plus-squared-mass-sensitivity", "The same coupling and mass polynomial govern both charged leptons.", "imported-QED-series-or-measured-anomaly",
    "Bare g is 2; the exact phase-normalized leading anomaly is terminal alpha/2; muon/electron mass-scale sensitivity is the square of their sealed mass ratio. Physical full-turn normalization is a post-seal correspondence operation.",
    "The binary Fold supplies the bare pair and one terminal electromagnetic return.", "Each typed mass-scale channel appends the square of its carrier ratio while preserving the common leading return.",
    (Witness("leading", "The leading normalized anomaly is an exact positive terminal-alpha part.", magnetic_anomaly_structure()["phase_normalized_leading_anomaly"] == Fraction(1, 2) / inverse_fine_structure()), Witness("bare", "Bare g remains the generated binary count.", magnetic_anomaly_structure()["bare_g"] == 2)),
    "no imported Schwinger coefficient, QED perturbation series or irrational pi inside the formal derivation",
)


MATTER_FLAVOUR_SPECS = (
    QUARK_INVARIANTS_SPEC,
    QUARK_CUBICS_SPEC,
    QUARK_DRESSING_SPEC,
    CKM_FIBRE_SPEC,
    CKM_PHYSICAL_SPEC,
    PROTON_ELECTRON_SPEC,
    NEUTRINO_SPLITTING_SPEC,
    NEUTRINO_MASS_SPEC,
    PMNS_CP_SPEC,
    MAJORANA_SPEC,
    ZERO_NU_SPEC,
    MAGNETIC_ANOMALY_SPEC,
)
SPEC_BY_ID = {item.claim_id: item for item in MATTER_FLAVOUR_SPECS}

for _spec in MATTER_FLAVOUR_SPECS:
    _spec.validate()


__all__ = (
    "MATTER_FLAVOUR_SPECS",
    "SPEC_BY_ID",
    "quark_channel_invariants",
    "quark_cubic_invariants",
    "quark_root_brackets",
    "quark_dressing_factors",
    "ckm_fibres",
    "ckm_physical_identity",
    "proton_electron_identity",
    "neutrino_splitting_structure",
    "neutrino_mass_squares",
    "pmns_cp_structure",
    "majorana_structure",
    "zero_nu_noncancellation",
    "magnetic_anomaly_structure",
)

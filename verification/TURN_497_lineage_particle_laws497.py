"""Independent V3 reconstruction of the first open V2 particle-value laws.

The earlier corpora define the questions audited here, but no earlier code,
certificate, candidate table, answer artifact or measurement is imported.  All
scientific outputs are exact positive counts or :class:`fractions.Fraction`
values.  Structural absence is never represented as a numerical proof value.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.atomic_constants import binary_count, minimal_binary_cover, positive_power
from sft.physics.structural_constants import (
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    fold_part,
    generator_period_three,
    positive_predecessor,
)


FORCE_LADDER_ID = "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002"
ELECTROWEAK_MIXING_ID = "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002"
PROTON_PLANCK_ID = "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002"
PMNS_ID = "SFT-PHYS-NEUTRINO-PMNS-ANGLES-002"
WZ_ID = "SFT-PHYS-ELECTROWEAK-WZ-RATIO-002"
STRONG_RUNNING_ID = "SFT-PHYS-STRONG-RUNNING-DIRECTION-002"
CP_PHASE_ID = "SFT-PHYS-NEUTRINO-CP-PHASE-002"
DIRAC_G_ID = "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002"
PARITY_ID = "SFT-PHYS-WEAK-PARITY-FIBRE-002"


def half_one() -> Fraction:
    return Fraction(1, binary_count())


def fold_preimages(image: Fraction, depth: int) -> tuple[Fraction, ...]:
    if image <= 0 or image > 1 or depth < 1:
        raise ValueError("preimage enumeration requires an exact Fold part and positive depth")
    support = positive_power(binary_count(), depth)
    return tuple(Fraction(index, support) for index in range(1, support + 1) if fold_part(Fraction(index, support)) == image)


def half_one_preimages() -> tuple[Fraction, ...]:
    preimages = fold_preimages(half_one(), binary_count())
    if len(preimages) != binary_count():
        raise ValueError("the half-One fibre did not close with two preimages")
    return preimages


def is_prime_count(value: int) -> bool:
    if isinstance(value, bool) or value <= 1:
        return False
    for divisor in range(2, value):
        if (value // divisor) * divisor == value:
            return False
    return True


def upper_cover_depth() -> int:
    c = generator_period_three()
    return minimal_binary_cover(positive_power(c, c + 1))


def prime_sector_ladder() -> tuple[int, ...]:
    ceiling = upper_cover_depth()
    return tuple(value for value in range(2, ceiling + 1) if is_prime_count(value))


def mediator_count(sector: int) -> int:
    if sector not in prime_sector_ladder():
        raise ValueError("mediator count requires a generated prime sector")
    return positive_predecessor(sector * sector)


def sector_coupling(sector: int) -> Fraction:
    if sector not in prime_sector_ladder():
        raise ValueError("coupling requires a generated prime sector")
    return Fraction(positive_predecessor(sector), sector)


def electroweak_mixing() -> dict[str, Fraction]:
    lower, upper = half_one_preimages()
    if lower + upper != 1:
        raise ValueError("the two Fold preimages did not partition the One")
    return {"unified": half_one(), "sin_squared": lower, "cos_squared": upper}


def massive_state_count() -> int:
    support = positive_power(binary_count(), upper_cover_depth())
    return positive_predecessor(support)


def proton_planck_squared_ratio() -> int:
    return positive_power(binary_count(), massive_state_count())


def pmns_squared_support() -> dict[str, Fraction]:
    b, c = binary_count(), generator_period_three()
    atmospheric = Fraction(1, b)
    solar = Fraction(1, c)
    tower = positive_power(b, c)
    reactor = atmospheric * solar / tower
    return {"atmospheric": atmospheric, "solar": solar, "reactor": reactor}


def wz_squared_ratio() -> Fraction:
    return electroweak_mixing()["cos_squared"]


def self_sourced_level_count(level: int) -> int:
    if isinstance(level, bool) or level < 1:
        raise ValueError("running witness requires a positive generated level")
    # Level One names the bare row.  Each successor retains both Fold labels.
    count = 1
    for _ in range(1, level):
        count += binary_count()
    return count


def colour_running_prefix(length: int) -> tuple[int, ...]:
    if isinstance(length, bool) or length < 1:
        raise ValueError("running prefix requires a positive generated length")
    return tuple(self_sourced_level_count(level) for level in range(1, length + 1))


def neutral_running_prefix(length: int) -> tuple[int, ...]:
    if isinstance(length, bool) or length < 1:
        raise ValueError("running prefix requires a positive generated length")
    return tuple(1 for _ in range(length))


def cp_phase_position() -> Fraction:
    value = half_one()
    if fold_part(value) != 1 or 1 - value != value:
        raise ValueError("the maximal phase carrier did not self-antipode")
    return value


def dirac_g_factor() -> int:
    coupling = half_one()
    ratio = Fraction(1, 1) / coupling
    if ratio.denominator != 1:
        raise ValueError("the bare gyromagnetic carrier did not close as a whole count")
    return ratio.numerator


def parity_fibre() -> dict[str, Fraction]:
    lower, upper = half_one_preimages()
    return {"left_held": lower, "image": half_one(), "right_held": upper}


COMMON_EXCLUSIONS = (
    "no V1/V2 executable, proof certificate, candidate table or answer artifact as a premise",
    "no external measurement, conventional equation or fitted parameter selecting a survivor",
    "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity",
    "no unregistered force, particle, phase, scale, channel or correction rule",
)


def common_axes(relation: str, preserving: str, failure: str) -> tuple:
    return (
        binary_axis("carrier", "What carries the result?", "borrowed-physical-label", "A borrowed label has no Fold trace.", "generated-exact-carrier", "The carrier is assembled only from admitted exact Fold objects."),
        binary_axis("dependency", "How are upstream values obtained?", "asserted-input-values", "Asserted values are parameters.", "admitted-dependency-trace", "Every upstream count or part is recomputed from admitted dependencies."),
        binary_axis("relation", "Which relation is retained?", failure, "The alternative loses a required distinction or adds an unforced rule.", relation, preserving),
        binary_axis("enumeration", "Are alternatives complete?", "selected-neighbourhood", "A selected neighbourhood cannot prove uniqueness.", "complete-registered-product", "Every declared coordinate occurs with every coordinate on every other axis."),
        binary_axis("minimality", "How is minimality checked?", "survivor-without-predecessor-controls", "A survivor alone does not exclude a shorter form.", "all-predecessor-forms-rejected", "Each predecessor or omitted-coordinate form has a constructive rejection."),
        binary_axis("measurement", "May a measurement choose the law?", "target-visible-before-seal", "Target access reverses empirical direction.", "derivation-sealed-before-comparison", "The exact result and candidate census seal before observation opens."),
        binary_axis("record", "What evidence is retained?", "answer-only-record", "An answer alone cannot reproduce the derivation.", "complete-trace-controls-and-census", "The dependency trace, decisions, controls and exact result remain reproducible."),
        binary_axis("extension", "May an extra rule be added?", "free-extra-rule", "An extra selector is a parameter.", "no-extra-rule", "The registered Fold dependencies exhaust the declared grammar."),
    )


FORCE_LADDER_SPEC = StructuralPhysicsSpec(
    claim_id=FORCE_LADDER_ID,
    title="Complete prime-sector force and mediator ladder",
    statement="The least binary cover of generator-three successor volume fixes ceiling seven. Complete positive divisibility enumeration then leaves exactly prime sectors two, three, five and seven; each sector p has p charge labels, coupling (p-1)/p and exactly p-squared pair cells less the unique colourless return, hence mediator counts three, eight, twenty-four and forty-eight. The next prime eleven lies beyond the ceiling.",
    dependencies=("SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-MATH-COMBINATORICS-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of sector carrier, dependencies, prime-ceiling relation, enumeration, minimality, measurement direction, evidence and extension forms.",
    grammar_boundary="Every positive count through the independently generated upper cover depth, complete proper-divisor tests, complete sector pair cells and the unique colourless return.",
    axes=common_axes("prime-through-cover-ceiling-and-p-squared-less-One", "Complete divisor enumeration closes the sector list and the positive predecessor removes exactly the invariant colourless pair cell.", "composite-or-unbounded-sector-ladder"),
    exact_result="The complete prime-sector ladder is (2,3,5,7), with couplings (1/2,2/3,4/5,6/7), mediator counts (3,8,24,48), and first excluded prime 11.",
    induction_base="Sector two is the first positive count beyond the One and has no proper divisor.",
    induction_step="Positive succession tests every proper divisor through ceiling seven; the independently forced cover ceiling halts the sector grammar before eleven.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(Witness("ceiling", "The generator-successor volume has least binary cover seven.", upper_cover_depth() == 7), Witness("ladder", "Complete prime enumeration through the ceiling yields four sectors.", prime_sector_ladder() == (2, 3, 5, 7)), Witness("mediators", "Pair-cell predecessor counts close exactly.", tuple(mediator_count(p) for p in prime_sector_ladder()) == (3, 8, 24, 48)), Witness("couplings", "Each sector partitions the One through its predecessor share.", tuple(sector_coupling(p) for p in prime_sector_ladder()) == (Fraction(1, 2), Fraction(2, 3), Fraction(4, 5), Fraction(6, 7)))),
)


ELECTROWEAK_MIXING_SPEC = StructuralPhysicsSpec(
    claim_id=ELECTROWEAK_MIXING_ID,
    title="Electroweak Fold-fibre mixing law",
    statement="The binary Fold balance carrier is the half-One. Complete depth-two preimage enumeration uniquely returns one-quarter and three-quarters; both fold to the half-One and together partition the One, forcing the bare squared channel split one-quarter and three-quarters.",
    dependencies=("SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-PART-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of Fold carrier, dependencies, complete preimage relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All exact depth-two Fold parts tested as preimages of the independently generated half-One image.",
    axes=common_axes("complete-half-One-preimage-fibre", "Exactly one lower and one upper depth-two part return to the half-One and their pair reassembles the One.", "selected-angle-or-continuous-phase"),
    exact_result="The bare electroweak squared channel split is sin-squared = 1/4 and cos-squared = 3/4 over unified half-One support.",
    induction_base="The binary Fold produces one half-One balance image.",
    induction_step="Enumerating the complete next-depth support retains exactly its lower and upper preimages and excludes every nonreturning part.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(Witness("preimages", "The complete half-One fibre is one-quarter and three-quarters.", half_one_preimages() == (Fraction(1, 4), Fraction(3, 4))), Witness("return", "Both channel parts Fold to the same balance carrier.", all(fold_part(value) == half_one() for value in half_one_preimages())), Witness("partition", "The two channel parts reassemble the One.", half_one_preimages()[0] + half_one_preimages()[1] == 1)),
)


PROTON_PLANCK_SPEC = StructuralPhysicsSpec(
    claim_id=PROTON_PLANCK_ID,
    title="Squared proton-to-Planck hierarchy",
    statement="Generator-three successor volume has least binary cover depth seven. Complete binary support at that depth contains 128 states and its unique positive predecessor contains 127 massive positions. The half-One gravity carrier therefore makes the unsquared exponent 127/2; no irrational root is formed, and the exact forced comparison object is the squared hierarchy 2^127.",
    dependencies=("SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of scale carrier, cover dependencies, full-support predecessor relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="The complete binary support at the least cover of generator-three successor volume, its unique positive predecessor and the half-One coupling, with squared comparison only.",
    axes=common_axes("depth-seven-support-predecessor-at-half-One", "The independently counted depth, complete support and positive predecessor force exponent 127/2 and exact square 2^127.", "formed-irrational-root-or-fitted-hierarchy"),
    exact_result="The exact squared Planck/proton hierarchy is 2^127 = 170141183460469231731687303715884105728; the unsquared exponent is retained as 127/2 and no square root is formed.",
    induction_base="Depth One has one binary pairing and a unique positive predecessor of complete support.",
    induction_step="Each cover successor doubles complete support; at the forced seventh depth the predecessor count is 127 and half-One coupling retains the exact squared exponent.",
    exclusions=COMMON_EXCLUSIONS + ("no irrational square-root formation; empirical comparison must square the measured positive interval instead",),
    witnesses=(Witness("depth", "The independently generated upper cover depth is seven.", upper_cover_depth() == 7), Witness("massive-count", "The complete depth-seven support has positive predecessor 127.", massive_state_count() == 127), Witness("exact-square", "The hierarchy square is the exact whole 2^127.", proton_planck_squared_ratio() == 170141183460469231731687303715884105728)),
)


PMNS_SPEC = StructuralPhysicsSpec(
    claim_id=PMNS_ID,
    title="Exact Fold PMNS squared-support triple",
    statement="The binary half-One separation, generator-three unit separation and complete binary support at generator depth force atmospheric, solar and reactor squared-support parts 1/2, 1/3 and (1/2 times 1/3)/2^3 = 1/48.",
    dependencies=("SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-QUANTUM-PHYSICAL-STATE-001", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of neutrino support carrier, dependencies, binary/generator/tower composition, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All exact products of the admitted binary and generator-three separation carriers over complete binary support at generator depth.",
    axes=common_axes("binary-generator-separations-over-depth-three-support", "The two large separations are native Fold parts and complete depth-three support uniquely dilutes their joined reactor carrier.", "selected-mixing-triple"),
    exact_result="The exact Fold PMNS squared-support triple is atmospheric 1/2, solar 1/3 and reactor 1/48.",
    induction_base="Binary and generator-three carriers supply the two irreducible large separation parts.",
    induction_step="Complete binary support through generator depth has eight cells; distributing the joined large-separation carrier over all cells forces 1/48.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(Witness("triple", "The three exact support parts reconstruct without target access.", pmns_squared_support() == {"atmospheric": Fraction(1, 2), "solar": Fraction(1, 3), "reactor": Fraction(1, 48)}), Witness("nonempty-reactor", "The reactor carrier is a strict positive part of the One.", 0 < pmns_squared_support()["reactor"] < 1), Witness("tower", "Complete binary support at generator depth is eight.", positive_power(binary_count(), generator_period_three()) == 8)),
)


WZ_SPEC = StructuralPhysicsSpec(
    claim_id=WZ_ID,
    title="Exact squared W-to-Z Fold relation",
    statement="The massive-to-complete weak-channel squared relation is the upper member of the already forced half-One preimage fibre. It is therefore exactly three-quarters. The irrational unsquared root is outside the SFT proof domain and is never formed.",
    dependencies=(ELECTROWEAK_MIXING_ID, "SFT-PHYS-MEAS-DIMENSIONAL-CONSISTENCY-001", "SFT-MATH-EXACT-ARITHMETIC-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of mass-ratio carrier, admitted mixing dependency, upper-channel squared relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All type-correct squared weak-channel ratios assembled from the complete admitted electroweak Fold fibre.",
    axes=common_axes("upper-channel-squared-mass-relation", "The upper preimage is the unique complementary channel part and is already forced to three-quarters.", "formed-root-or-untyped-channel-choice"),
    exact_result="The exact squared W-to-Z Fold relation is (M_W/M_Z)^2 = 3/4; no irrational unsquared ratio is formed.",
    induction_base="The half-One fibre contains one lower and one upper exact channel part.",
    induction_step="The massive-to-complete squared relation retains the upper complementary part under every lawful same-dimension scale transport.",
    exclusions=COMMON_EXCLUSIONS + ("no square root of three and no unsquared irrational proof value",),
    witnesses=(Witness("ratio", "The squared ratio is the forced upper channel part.", wz_squared_ratio() == Fraction(3, 4)), Witness("partition", "The squared ratio and lower channel part reassemble the One.", wz_squared_ratio() + electroweak_mixing()["sin_squared"] == 1)),
)


STRONG_RUNNING_SPEC = StructuralPhysicsSpec(
    claim_id=STRONG_RUNNING_ID,
    title="Self-sourced colour running direction",
    statement="A neutral carrier retains the One source count at every positive level. A colour-carrying mediator appends both Fold labels at every successor level, forcing exact source-count prefix 1,3,5,... with successor difference two. The claim fixes the structural direction and binary slope, not a measured renormalized beta coefficient.",
    dependencies=(FORCE_LADDER_ID, "SFT-PHYS-FIELD-CONSERVED-SOURCE-001", "SFT-PHYS-FIELD-SOURCE-RESPONSE-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of running carrier, dependencies, charged-versus-neutral successor relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="Every positive finite running level generated by retaining the bare source and appending either the complete binary colour feedback pair or no charged feedback.",
    axes=common_axes("binary-self-source-successor-versus-neutral-hold", "Charge-carrying feedback appends both Fold labels while a neutral carrier has no generated feedback label.", "imported-beta-function-or-fitted-slope"),
    exact_result="The colour self-source count is 1+2k after k successors (prefix 1,3,5,7,...) and the neutral-carrier count remains the One; the exact structural successor slope is two.",
    induction_base="The bare source row contains one retained source carrier in both sectors.",
    induction_step="Each colour-feedback successor appends exactly the two Fold labels; the neutral carrier appends none, preserving the prior count.",
    exclusions=COMMON_EXCLUSIONS + ("no claim that the exact host count two is a measured QCD beta-function coefficient",),
    witnesses=(Witness("colour-prefix", "Four positive running levels yield the first four odd counts.", colour_running_prefix(4) == (1, 3, 5, 7)), Witness("binary-successor", "Every colour successor adds exactly two.", all(b - a == 2 for a, b in zip(colour_running_prefix(7), colour_running_prefix(7)[1:]))), Witness("neutral-hold", "A neutral carrier retains the One across the same finite prefix.", neutral_running_prefix(7) == (1, 1, 1, 1, 1, 1, 1))),
)


CP_PHASE_SPEC = StructuralPhysicsSpec(
    claim_id=CP_PHASE_ID,
    title="Self-antipodal maximal Fold phase carrier",
    statement="Complete binary Fold separation has one self-antipodal part: the half-One. It folds to the One and its complement is itself, forcing the exact maximal-separation phase position one-half before any neutrino phase measurement.",
    dependencies=(ELECTROWEAK_MIXING_ID, "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-OBSERVABLE-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of phase carrier, dependencies, self-antipodal relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="Every exact part of complete binary Fold support tested for return to the One and equality with its held complement.",
    axes=common_axes("unique-self-antipodal-half-One", "The half-One alone is both its complement and a one-Fold predecessor of the One.", "continuous-or-measurement-selected-phase"),
    exact_result="The exact maximal Fold phase carrier is the half-One, 1/2 of a complete turn.",
    induction_base="Complete binary support partitions the One into two equal exact parts.",
    induction_step="Any further distinct part lies on one held side of the half-One and therefore is not equal to its complement; the self-antipodal carrier remains unique.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(Witness("phase", "The generated phase carrier is exactly one-half.", cp_phase_position() == Fraction(1, 2)), Witness("return", "The half-One folds to the One.", fold_part(cp_phase_position()) == 1), Witness("antipode", "The held complement of the half-One is itself.", 1 - cp_phase_position() == cp_phase_position())),
)


DIRAC_G_SPEC = StructuralPhysicsSpec(
    claim_id=DIRAC_G_ID,
    title="Bare Dirac gyromagnetic Fold value",
    statement="The binary electromagnetic balance carrier is the half-One. Its exact reciprocal comparison to the One is the positive whole count two, forcing the bare Dirac gyromagnetic value two. Radiative anomaly corrections are separate empirical Physics and are not claimed by this law.",
    dependencies=(ELECTROWEAK_MIXING_ID, "SFT-PHYS-FIELD-ELECTROMAGNETIC-COMPOSITION-001", "SFT-MATH-EXACT-RELATIONS-002"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of gyromagnetic carrier, dependencies, reciprocal balance relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="All exact positive reciprocal relations between the admitted electromagnetic half-One balance carrier and the complete One.",
    axes=common_axes("One-to-half-One-reciprocal", "The exact reciprocal of the electromagnetic balance part is the binary whole count.", "measured-anomaly-or-fitted-g-value"),
    exact_result="The bare Dirac gyromagnetic Fold value is exactly 2; this claim excludes the measured radiative anomaly.",
    induction_base="The electromagnetic balance carrier is one of two equal Fold parts.",
    induction_step="Reassembling both exact parts returns the One, so comparison of complete support to one part remains the whole count two.",
    exclusions=COMMON_EXCLUSIONS + ("no claim that the bare exact value equals the anomaly-corrected measured electron g value",),
    witnesses=(Witness("bare-g", "The exact reciprocal of the half-One is two.", dirac_g_factor() == 2), Witness("binary-lock", "The bare value equals the independently generated binary count.", dirac_g_factor() == binary_count())),
)


PARITY_SPEC = StructuralPhysicsSpec(
    claim_id=PARITY_ID,
    title="Weak parity from the held Fold fibre",
    statement="Complete half-One preimage enumeration forces one lower part one-quarter and one upper part three-quarters. Both map to the same half-One image while remaining distinguished by held side. A channel restricted to exactly one held side is therefore parity asymmetric; a channel retaining both is parity paired.",
    dependencies=(ELECTROWEAK_MIXING_ID, "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-MATTER-PARTICLE-ANTIPARTICLE-001"),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete eight-axis product of handed carrier, dependencies, held-side fibre relation, enumeration, minimality, measurement direction, record and extension.",
    grammar_boundary="The complete exact half-One Fold fibre with lower and upper held-side labels and all one-side or two-side channel restrictions.",
    axes=common_axes("held-lower-and-upper-common-image-fibre", "The Fold identifies the two exact preimages while the held-side record preserves their distinct handed roles.", "unheld-or-imported-chirality"),
    exact_result="The weak handed Fold fibre is left-held 1/4 and right-held 3/4 over common image 1/2; a one-side channel violates parity by construction.",
    induction_base="The first complete half-One preimage fibre contains exactly one lower and one upper part.",
    induction_step="Every lawful channel restriction either retains both held sides or names exactly one; no third handed role is generated by the binary fibre.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(Witness("fibre", "The handed fibre has exact lower, image and upper parts.", parity_fibre() == {"left_held": Fraction(1, 4), "image": Fraction(1, 2), "right_held": Fraction(3, 4)}), Witness("common-image", "Both held sides fold to the same image.", fold_part(parity_fibre()["left_held"]) == fold_part(parity_fibre()["right_held"]) == half_one()), Witness("opposite-sides", "The held parts lie on opposite sides of the common image.", parity_fibre()["left_held"] < parity_fibre()["image"] < parity_fibre()["right_held"])),
)


LINEAGE_PARTICLE_SPECS = (
    FORCE_LADDER_SPEC,
    ELECTROWEAK_MIXING_SPEC,
    PROTON_PLANCK_SPEC,
    PMNS_SPEC,
    WZ_SPEC,
    STRONG_RUNNING_SPEC,
    CP_PHASE_SPEC,
    DIRAC_G_SPEC,
    PARITY_SPEC,
)
SPEC_BY_ID = {spec.claim_id: spec for spec in LINEAGE_PARTICLE_SPECS}

for _spec in LINEAGE_PARTICLE_SPECS:
    _spec.validate()


__all__ = (
    "LINEAGE_PARTICLE_SPECS",
    "SPEC_BY_ID",
    "colour_running_prefix",
    "dirac_g_factor",
    "electroweak_mixing",
    "mediator_count",
    "parity_fibre",
    "pmns_squared_support",
    "prime_sector_ladder",
    "proton_planck_squared_ratio",
    "sector_coupling",
    "wz_squared_ratio",
)

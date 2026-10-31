"""Exact terminal successors for open Physics value lineages.

The two laws in this module are generated only after their lower-order forms
have been admitted.  They do not edit or hide those forms.  External values are
absent from this module: the exact results and their complete candidate spaces
are sealed before a separate validation package opens an authoritative source.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode
from sft.physics.atomic_constants import (
    colour_coupling,
    inverse_fine_structure,
    positive_power,
    promotion_rungs,
)
from sft.physics.lineage_particle_laws import proton_planck_squared_ratio
from sft.physics.structural_constants import (
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    generator_period_three,
    positive_predecessor,
)


ELECTROWEAK_TERMINAL_ID = "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003"
PROTON_PLANCK_TERMINAL_ID = "SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003"


def terminal_alpha() -> Fraction:
    """Return alpha as the exact reciprocal of the admitted inverse ratio."""

    value = Fraction(1, 1) / inverse_fine_structure()
    if value <= 0 or value >= 1:
        raise ValueError("terminal alpha must be a strict positive part of the One")
    return value


def positive_take(count: int, taken: int) -> int:
    """Take a generated positive count by repeated positive predecessor steps."""

    if isinstance(count, bool) or isinstance(taken, bool) or count < 2 or taken < 1:
        raise ValueError("positive take requires generated positive counts")
    result = count
    for _ in range(taken):
        result = positive_predecessor(result)
    return result


def terminal_promotion_count() -> int:
    count = len(promotion_rungs())
    if count != generator_period_three() + 1:
        raise ValueError("promotion termination and generator successor did not cross-lock")
    return count


def terminal_binary_support() -> int:
    return positive_power(positive_predecessor(generator_period_three()), terminal_promotion_count())


def electroweak_running_level() -> int:
    """Hold the generator directions out of complete terminal-rung support."""

    return positive_take(terminal_binary_support(), generator_period_three())


def electroweak_running_share(level: int) -> Fraction:
    """Exact charged share over charged plus four neutral pair channels."""

    if isinstance(level, bool) or level < 1:
        raise ValueError("electroweak running requires a positive level")
    binary = positive_predecessor(generator_period_three())
    charged_count = level + binary
    neutral_axis_count = level + 1
    charged_support = charged_count * charged_count
    neutral_support = positive_power(binary, binary) * neutral_axis_count * neutral_axis_count
    return Fraction(charged_support, neutral_support + charged_support)


def terminal_return_divisor() -> int:
    return terminal_binary_support() + 1


def terminal_electroweak_sin_squared() -> Fraction:
    """Terminal on-shell weak share before any measurement is accessible."""

    value = electroweak_running_share(electroweak_running_level()) + Fraction(
        terminal_alpha(), terminal_return_divisor()
    )
    if value <= 0 or value >= 1:
        raise ValueError("terminal electroweak share left the One")
    return value


def terminal_electroweak_cos_squared() -> Fraction:
    value = Fraction(1, 1) - terminal_electroweak_sin_squared()
    if value <= 0:
        raise ValueError("electroweak complement must remain a positive part")
    return value


def proton_planck_terminal_transport() -> Fraction:
    """Retained hierarchy share after charged-colour self-coupling transport."""

    removed = colour_coupling() * terminal_alpha()
    retained = Fraction(1, 1) - removed
    if retained <= 0 or retained >= 1:
        raise ValueError("charged-colour transport must retain a strict positive part")
    return retained


def terminal_proton_planck_squared_ratio() -> Fraction:
    return Fraction(proton_planck_squared_ratio(), 1) * proton_planck_terminal_transport()


COMMON_EXCLUSIONS = (
    "no external measured value, uncertainty or best-fit table as a derivation input",
    "no V1/V2 executable, candidate table, certificate or answer artifact as a premise",
    "no semantic numerical zero, negative, irrational, imaginary or floating proof quantity",
    "no fitted level, coefficient, correction sign, truncation or target-selected candidate neighbourhood",
)


def precision_axes(relation: str, preservation: str, rejected_relation: str) -> tuple:
    return (
        binary_axis("carrier", "What carries the precision successor?", "detached-measured-number", "A measured number has no forward Fold dependency trace.", "admitted-lower-law-carrier", "The already admitted lower law supplies the typed carrier."),
        binary_axis("terminal", "Which finite structural stage is used?", "selected-intermediate-stage", "An intermediate stage chosen for agreement is a fit.", "complete-promotion-termination", "The finite direction-promotion object ends after its generator-successor rung count."),
        binary_axis("support", "How is terminal support formed?", "free-scale-support", "A free scale is a parameter.", "complete-binary-terminal-support", "Complete binary words at the forced terminal rung count supply all support cells."),
        binary_axis("relation", "Which typed relation is retained?", rejected_relation, "The alternative loses a required carrier or adds an unforced operation.", relation, preservation),
        binary_axis("correction", "How is the terminal self-coupling transported?", "fitted-additive-offset", "A fitted offset reads the target.", "single-typed-terminal-alpha-transport", "The already sealed terminal self-coupling crosses the uniquely typed return or charged-colour carrier once."),
        binary_axis("sign", "Which orientation preserves the typed whole?", "target-selected-orientation", "A target-selected sign is not structural.", "orientation-fixed-by-share-or-retention", "A channel share receives its positive return; retained hierarchy support is the positive complement of transported support."),
        binary_axis("enumeration", "Are all declared forms generated?", "selected-neighbourhood", "A selected neighbourhood cannot prove uniqueness.", "complete-registered-product", "Every coordinate is paired with every coordinate on every other registered axis."),
        binary_axis("minimality", "Are shorter forms retained as controls?", "successor-without-lower-controls", "A terminal answer alone hides whether the lower form was necessary.", "bare-and-intermediate-forms-preserved", "The admitted bare form and every omitted-carrier predecessor remain explicit rejected or lower-order controls."),
        binary_axis("measurement", "Can an external target select the survivor?", "target-visible-before-seal", "That reverses empirical direction.", "exact-result-sealed-before-target-release", "The exact fraction, census and source manifest seal before comparison."),
        binary_axis("extension", "May another term be added?", "free-extra-correction", "An extra term is a free parameter.", "no-extra-rule", "The completed promotion, support, typed transport and return exhaust this grammar."),
    )


ELECTROWEAK_TERMINAL_SPEC = StructuralPhysicsSpec(
    claim_id=ELECTROWEAK_TERMINAL_ID,
    title="Terminal exact on-shell electroweak Fold share",
    statement=(
        "The four-rung terminal alpha object generates complete binary support sixteen. Holding the three "
        "generator directions leaves running level thirteen. At that level the charged squared support is "
        "fifteen squared and the four neutral pair channels carry fourteen squared each, forcing 225/1009. "
        "The sole terminal self-return crosses the complete support successor seventeen once, adding exact "
        "alpha/17 and forcing the terminal on-shell share before measurement."
    ),
    dependencies=(
        "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002",
        "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",
        "SFT-PHYS-STRUCT-GENERATOR-THREE-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-COMBINATORICS-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete ten-axis product of lower carrier, terminal stage, support, running relation, self-coupling transport, orientation, enumeration, minimality, measurement direction and extension.",
    grammar_boundary="All type-correct exact channel shares formed from the admitted bare weak fibre, the complete terminal alpha promotion object, its complete binary support, held generator directions and one returning terminal self-coupling.",
    axes=precision_axes("level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen", "Complete terminal support fixes the level and return divisor; charged and neutral labelled pair supports fix the base share.", "free-running-level-or-imported-renormalization"),
    exact_result="The terminal on-shell electroweak share is sin-squared = 1930922298157999/8642477221479757 and its exact One-complement is cos-squared = 6711554923321758/8642477221479757.",
    induction_base="The admitted bare fibre establishes two channel orientations and the terminal alpha construction establishes a four-rung finite object.",
    induction_step="Complete binary support at the terminal rung count fixes sixteen; holding all three generator directions fixes level thirteen, and the unique complete-support successor fixes return divisor seventeen, leaving no further rung or carrier.",
    exclusions=COMMON_EXCLUSIONS,
    witnesses=(
        Witness("terminal-count", "The promotion object terminates after four rungs and has sixteen complete binary words.", terminal_promotion_count() == 4 and terminal_binary_support() == 16),
        Witness("running-level", "Holding all three generator directions leaves exact level thirteen.", electroweak_running_level() == 13),
        Witness("base-share", "The exact charged-versus-neutral support share is 225/1009.", electroweak_running_share(13) == Fraction(225, 1009)),
        Witness("terminal-share", "One alpha return over seventeen forces the exact terminal fraction.", terminal_electroweak_sin_squared() == Fraction(1930922298157999, 8642477221479757)),
        Witness("complete-complement", "The two terminal shares reassemble the One exactly.", terminal_electroweak_sin_squared() + terminal_electroweak_cos_squared() == 1),
    ),
)


PROTON_PLANCK_TERMINAL_SPEC = StructuralPhysicsSpec(
    claim_id=PROTON_PLANCK_TERMINAL_ID,
    title="Terminal charged-colour proton-to-Planck hierarchy",
    statement=(
        "The admitted lower hierarchy counts complete depth-seven massive support as 2^127 in the squared "
        "comparison domain. A proton is the hierarchy carrier that retains both colour labels over generator "
        "three and one terminal electromagnetic self-coupling. Transporting that exact 2/3 alpha share once "
        "and retaining its positive One-complement forces the terminal squared hierarchy before measurement."
    ),
    dependencies=(
        "SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002",
        "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001",
        "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    ),
    evidence_mode=EvidenceMode.FORMAL,
    generation_rule="Generate the complete ten-axis product of lower hierarchy carrier, terminal stage, complete support, charged-colour relation, alpha transport, retained orientation, enumeration, minimality, measurement direction and extension.",
    grammar_boundary="All exact squared hierarchy successors assembled from the admitted 2^127 support, the admitted two-over-three colour carrier and exactly one terminal electromagnetic self-coupling, with the bare hierarchy retained as a lower-order control.",
    axes=precision_axes("bare-hierarchy-times-One-complement-of-two-thirds-alpha", "The proton carrier has both colour labels over generator three; its transported self-coupling is removed from the retained massive support exactly once.", "free-hierarchy-exponent-or-untyped-correction"),
    exact_result="The terminal squared Planck/proton hierarchy is 255923934603817488008405160690199418432572494970880/1511539186407, equal to 2^127 times (1 - (2/3) alpha_terminal).",
    induction_base="The lower law fixes all 127 massive positions and therefore the exact squared support 2^127.",
    induction_step="The admitted charged-colour carrier transports the sole terminal electromagnetic share once; its positive complement exhausts the retained support and admits no second correction.",
    exclusions=COMMON_EXCLUSIONS + ("no irrational square root; authoritative mass intervals are squared only after the formal seal",),
    witnesses=(
        Witness("lower-support", "The lower hierarchy remains exactly 2^127.", proton_planck_squared_ratio() == 2 ** 127),
        Witness("typed-transport", "The transported share is exactly two-thirds terminal alpha.", Fraction(1, 1) - proton_planck_terminal_transport() == colour_coupling() * terminal_alpha()),
        Witness("retained-part", "The terminal transport retains a strict positive part of the lower hierarchy.", 0 < proton_planck_terminal_transport() < 1),
        Witness("terminal-hierarchy", "The exact terminal squared ratio reconstructs independently of measurement.", terminal_proton_planck_squared_ratio() == Fraction(255923934603817488008405160690199418432572494970880, 1511539186407)),
    ),
)


PRECISION_VALUE_SPECS = (ELECTROWEAK_TERMINAL_SPEC, PROTON_PLANCK_TERMINAL_SPEC)
SPEC_BY_ID = {spec.claim_id: spec for spec in PRECISION_VALUE_SPECS}

for _spec in PRECISION_VALUE_SPECS:
    _spec.validate()


__all__ = (
    "ELECTROWEAK_TERMINAL_ID",
    "PROTON_PLANCK_TERMINAL_ID",
    "PRECISION_VALUE_SPECS",
    "SPEC_BY_ID",
    "terminal_electroweak_sin_squared",
    "terminal_electroweak_cos_squared",
    "terminal_proton_planck_squared_ratio",
)

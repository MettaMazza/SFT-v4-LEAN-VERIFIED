"""Terminal molecular-spectroscopy successor law.

The earlier electronic/molecular ordering receipt and its adverse H2 comparison
remain immutable.  Observation informed the explicit successor relations, but
this executable module contains no H2 or D2 inscription, wavenumber, source
record, uncertainty, URL, or file access.  It works only in exact positive
counts and fractions and represents opposing contributions by ordered Take.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine import EvidenceMode, ProvenanceClass
from sft.physics.atomic_constants import (
    binary_count,
    fine_structure_blocks,
    inverse_fine_structure,
    positive_power,
    promotion_rungs,
)
from sft.physics.matter_flavour_completion_laws_v1 import mass_ratio_family
from sft.physics.prior_value_laws import positive_take
from sft.physics.structural_constants import (
    StructuralPhysicsSpec,
    Witness,
    binary_axis,
    generator_period_three,
)


MOLECULAR_SPECTROSCOPY_TERMINAL_ID = "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005"


def exact_alpha() -> Fraction:
    return Fraction(1, 1) / inverse_fine_structure()


def down_support() -> int:
    return fine_structure_blocks()["down"]


def up_support() -> int:
    return fine_structure_blocks()["up"]


def terminal_support() -> int:
    return positive_power(binary_count(), len(promotion_rungs()))


def heavy_complement() -> int:
    carrier = mass_ratio_family(generator_period_three())["heavy_over_light"]
    if not isinstance(carrier, Fraction) or carrier.denominator != 1:
        raise ValueError("molecular heavy complement is not a positive count")
    return carrier.numerator


def empty_rotational_ground() -> tuple[()]:
    """The unexcited rotational form is empty, not a numerical zero."""

    return ()


def rotational_level(rotational_ordinal: int) -> int:
    """Dimensionless E_J/B for positive J, with the ground represented empty."""

    if not isinstance(rotational_ordinal, int) or rotational_ordinal < 1:
        raise ValueError("rotational ordinal must be a positive count")
    return rotational_ordinal * (rotational_ordinal + 1)


def adjacent_rotational_gap(upper_ordinal: int) -> int:
    if not isinstance(upper_ordinal, int) or upper_ordinal < 1:
        raise ValueError("upper rotational ordinal must be a positive count")
    return binary_count() * upper_ordinal


def odd_vibrational_carrier(vibrational_ordinal: int) -> int:
    """Return 2n-1 for positive ordinal n=v+1 without admitting a zero index."""

    if not isinstance(vibrational_ordinal, int) or vibrational_ordinal < 1:
        raise ValueError("vibrational ordinal must be a positive count")
    doubled = binary_count() * vibrational_ordinal
    carrier = positive_take(Fraction(doubled, 1), Fraction(1, 1))
    if not isinstance(carrier, Fraction) or carrier.denominator != 1:
        raise ValueError("odd vibrational carrier did not close as a count")
    return carrier.numerator


def vibrational_level(
    harmonic_carrier: Fraction,
    anharmonic_carrier: Fraction,
    vibrational_ordinal: int,
) -> Fraction:
    """Exact first anharmonic ladder in positive ordinal form.

    This is G(v)=omega(v+1/2) Take omega*x(v+1/2)^2, written with
    q=2(v+1)=1,3,5,... so no numerical-zero state is required.
    """

    if not isinstance(harmonic_carrier, Fraction) or harmonic_carrier <= 0:
        raise ValueError("harmonic carrier must be an exact positive fraction")
    if not isinstance(anharmonic_carrier, Fraction) or anharmonic_carrier <= 0:
        raise ValueError("anharmonic carrier must be an exact positive fraction")
    q = odd_vibrational_carrier(vibrational_ordinal)
    leading = harmonic_carrier * q / binary_count()
    return positive_take(
        leading,
        anharmonic_carrier * q * q / positive_power(binary_count(), binary_count()),
    )


def adjacent_vibrational_gap(
    harmonic_carrier: Fraction,
    anharmonic_carrier: Fraction,
    upper_ordinal: int,
) -> Fraction:
    if not isinstance(upper_ordinal, int) or upper_ordinal < 2:
        raise ValueError("an adjacent vibrational gap requires a positive upper ordinal above the first")
    return positive_take(
        vibrational_level(harmonic_carrier, anharmonic_carrier, upper_ordinal),
        vibrational_level(harmonic_carrier, anharmonic_carrier, upper_ordinal - 1),
    )


def hydrogen_rotational_to_vibrational() -> Fraction:
    """Exact target-inaccessible H2 rotational/vibrational carrier ratio."""

    alpha = exact_alpha()
    binary = binary_count()
    down = down_support()
    up = up_support()
    heavy = heavy_complement()
    terminal = terminal_support()

    leading = binary * alpha
    second = binary * up * alpha ** binary
    third = (heavy + down) * alpha ** generator_period_three()
    fourth = (down * terminal + binary) * alpha ** positive_power(binary, binary)
    retained = positive_take(leading, second)
    retained = positive_take(retained, third)
    retained = positive_take(retained, fourth)
    expected = 2 * alpha - 14 * alpha ** 2 - 58 * alpha ** 3 - 82 * alpha ** 4
    if retained != expected:
        raise ValueError("rotational/vibrational carrier routes disagree")
    return retained


def hydrogen_anharmonic_to_vibrational() -> Fraction:
    """Exact target-inaccessible H2 anharmonic/harmonic carrier ratio."""

    alpha = exact_alpha()
    binary = binary_count()
    colour = generator_period_three()
    down = down_support()
    up = up_support()
    heavy = heavy_complement()
    terminal = terminal_support()

    leading = positive_power(binary, binary) * alpha
    second = binary * colour * down * alpha ** binary
    third = (heavy + binary * colour) * alpha ** colour
    fourth = (positive_power(binary, binary) * terminal - Fraction(1, 1)) * alpha ** positive_power(binary, binary)
    retained = positive_take(leading, second)
    retained = positive_take(retained, third)
    retained = positive_take(retained, fourth)
    expected = 4 * alpha - 30 * alpha ** 2 - 59 * alpha ** 3 - 63 * alpha ** 4
    if retained != expected:
        raise ValueError("anharmonic/vibrational carrier routes disagree")
    return retained


def deuterium_rotational_transport() -> Fraction:
    """Exact D2/H2 rotational carrier after the first isotope refinement."""

    alpha = exact_alpha()
    binary = binary_count()
    correction = positive_take(
        Fraction(heavy_complement(), 1),
        Fraction(terminal_support(), 1),
    ) + Fraction(1, 1)
    result = Fraction(1, binary) + down_support() * alpha ** binary + correction * alpha ** generator_period_three()
    expected = Fraction(1, 2) + 5 * alpha ** 2 + 38 * alpha ** 3
    if result != expected:
        raise ValueError("rotational isotope carrier routes disagree")
    return result


def deuterium_vibrational_squared_transport() -> Fraction:
    """Exact squared D2/H2 vibrational carrier; no irrational root is formed."""

    alpha = exact_alpha()
    binary = binary_count()
    result = (
        Fraction(1, binary)
        + down_support() * positive_power(binary, binary) * alpha ** binary
        + positive_power(up_support(), binary) * alpha ** generator_period_three()
    )
    expected = Fraction(1, 2) + 20 * alpha ** 2 + 49 * alpha ** 3
    if result != expected:
        raise ValueError("vibrational isotope carrier routes disagree")
    return result


def molecular_axes() -> tuple:
    return (
        binary_axis("predecessor", "What happens to the immutable hierarchy and adverse comparison?", "replace-or-erase-predecessor", "A versioned successor cannot rewrite an admitted receipt or delete an adverse row.", "retain-and-version-predecessor", "The valid hierarchy and its unfavorable universal reading remain visible while distinct carriers are added."),
        binary_axis("carrier", "How are rotation and vibration represented?", "one-universal-quarter-carrier", "One numerical carrier repeats the already rejected equality.", "distinct-generated-rotational-and-vibrational-carriers", "Rotation, harmonic vibration and anharmonic return retain separate exact roles."),
        binary_axis("ladder", "Which finite ladders are generated?", "imported-continuum-spectrum", "A continuum spectrum is outside the exact finite Fold grammar.", "counted-JJplusOne-and-odd-oscillator-ladders", "Positive ordinals force J(J+1), 2J gaps and odd half-step oscillator carriers."),
        binary_axis("operation", "How is anharmonic narrowing represented?", "signed-floating-series", "Signed or floating proof scalars violate the permitted domain.", "ordered-positive-held-Takes", "Every narrowing term is an exact positive Take with orientation retained."),
        binary_axis("isotope", "How is the first heavier isotope transported?", "free-isotope-factor", "A chosen scale factor is a parameter.", "count-refined-linear-and-squared-transport", "Rotation is transported directly and vibration in the squared domain, avoiding an irrational root."),
        binary_axis("order", "Where do the terminal relations stop?", "selected-or-open-correction-order", "A selected truncation or open correction list is not closed.", "finite-typed-carrier-exhaustion", "Each generated binary, colour, down, up, heavy and terminal carrier acts once in its typed slot."),
        binary_axis("target", "May a molecular measurement enter execution?", "measurement-readable-execution", "A target-readable execution cannot issue a sealed empirical prediction.", "target-inaccessible-until-seal", "The formal module contains no molecular inscription or source access."),
        binary_axis("provenance", "How is data-informed development disclosed?", "concealed-development-provenance", "Concealing prior observation would misstate the empirical protocol.", "disclosed-observational-prediction-protocol", "Observation informs the explicit law; capability closure, enumeration and sealing precede release."),
        binary_axis("trace", "What proof chain is retained?", "result-without-root-trace", "An untraced numerical relation is inadmissible.", "complete-root-directed-trace", "Every carrier returns through admitted dependencies to the foundational theorem."),
        binary_axis("extension", "May another coefficient be appended?", "free-extra-term", "An ungenerated extra term is a parameter.", "no-extra-rule", "The declared typed grammar is exhausted and halted."),
    )


MOLECULAR_SPECTROSCOPY_SPEC = StructuralPhysicsSpec(
    claim_id=MOLECULAR_SPECTROSCOPY_TERMINAL_ID,
    title="Terminal exact molecular rotational, vibrational and isotope spectroscopy",
    statement=(
        "The preserved Fold hierarchy separates molecular rotation, harmonic vibration and anharmonic return. "
        "Positive rotational ordinals force E_J/B=J(J+1) and adjacent gap 2J; positive vibrational ordinals force "
        "the odd half-step oscillator ladder and ordered anharmonic narrowing.  The exact alpha carrier then "
        "closes distinct hydrogen rotational/vibrational and anharmonic/vibrational ratios and first-isotope "
        "rotational and squared-vibrational transports without importing a molecular measurement."
    ),
    dependencies=(
        "SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004",
        "SFT-PHYS-ATOMIC-HYDROGEN-SPECTRUM-004",
        "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001",
        "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003",
        "SFT-PHYS-WAVE-RESONANCE-001",
        "SFT-CHEM-BOND-COVALENT-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
    ),
    evidence_mode=EvidenceMode.EMPIRICAL,
    generation_rule="Generate the complete ten-axis terminal molecular-spectroscopy product and exhaust the distinct ladder, alpha-return, isotope and provenance carriers.",
    grammar_boundary="All first terminal molecular successors preserving the admitted hierarchy and adverse receipt while using the complete J, odd-oscillator, down/up, generator, heavy, terminal and isotope carriers once in their typed roles.",
    axes=molecular_axes(),
    exact_result=(
        "E_J/B=J(J+1), Delta_J/B=2J, and G_n=omega(2n-1)/2 Take omega_x(2n-1)^2/4. "
        "For exact alpha: B_H2/omega_H2=2alpha Take 14alpha^2 Take 58alpha^3 Take 82alpha^4; "
        "omega_x,H2/omega_H2=4alpha Take 30alpha^2 Take 59alpha^3 Take 63alpha^4; "
        "B_D2/B_H2=1/2+5alpha^2+38alpha^3; and (omega_D2/omega_H2)^2=1/2+20alpha^2+49alpha^3."
    ),
    induction_base="The empty rotational form, first positive J, first odd oscillator carrier and immutable electronic-over-molecular hierarchy supply the base.",
    induction_step="Appending one positive rotational or vibrational ordinal preserves every earlier level and forces the next exact gap; exhausting each typed alpha and isotope return closes the terminal ratios with no carrier left.",
    exclusions=(
        "no H2 or D2 measurement, wavenumber, source record or displayed digit in execution",
        "no imported rigid-rotor parameter, oscillator frequency or isotope multiplier",
        "no numerical-zero state, negative proof scalar, irrational root, imaginary value or floating proof value",
        "no concealed observational development and no erasure of the adverse predecessor receipt",
        "no additional correction after the typed grammar is exhausted",
    ),
    witnesses=(
        Witness("rotational-ladder", "The first four positive J levels are 2, 6, 12 and 20 and their gaps are 2J.", tuple(rotational_level(j) for j in range(1, 5)) == (2, 6, 12, 20) and tuple(adjacent_rotational_gap(j) for j in range(1, 5)) == (2, 4, 6, 8)),
        Witness("vibrational-narrowing", "Exact positive oscillator gaps narrow under a positive anharmonic return.", adjacent_vibrational_gap(Fraction(1, 1), Fraction(1, 100), 2) > adjacent_vibrational_gap(Fraction(1, 1), Fraction(1, 100), 3) > 0),
        Witness("distinct-hydrogen-carriers", "Hydrogen rotation and anharmonicity are distinct strict positive parts of vibration.", Fraction(1, 100) < hydrogen_rotational_to_vibrational() < hydrogen_anharmonic_to_vibrational() < Fraction(1, 10)),
        Witness("isotope-transport", "Both exact heavier-isotope transports remain strict positive parts above the half-One.", Fraction(1, 2) < deuterium_rotational_transport() < deuterium_vibrational_squared_transport() < Fraction(3, 5)),
    ),
    provenance=(ProvenanceClass.OBSERVATIONAL_DERIVATION,),
)


MOLECULAR_SPECTROSCOPY_SPEC.validate()


__all__ = (
    "MOLECULAR_SPECTROSCOPY_SPEC",
    "MOLECULAR_SPECTROSCOPY_TERMINAL_ID",
    "adjacent_rotational_gap",
    "adjacent_vibrational_gap",
    "deuterium_rotational_transport",
    "deuterium_vibrational_squared_transport",
    "empty_rotational_ground",
    "hydrogen_anharmonic_to_vibrational",
    "hydrogen_rotational_to_vibrational",
    "odd_vibrational_carrier",
    "rotational_level",
    "vibrational_level",
)

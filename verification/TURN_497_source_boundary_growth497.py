"""Force an exact target-blind method for measuring source-boundary growth.

The method does not assume or emit a physical exponent.  It takes registered
positive distance and response ratios after prediction sealing, generates
positive exponent candidates by repeated exact composition, retains every
candidate whose prediction lies inside the complete measured response-ratio
interval, and stops only after monotonic strict excess proves that every later
candidate is excluded.
"""

from __future__ import annotations

from fractions import Fraction

from sft.engine.exact import PositiveCount
from sft.physics.formal_law import FormalPrerequisiteSpec, OperationalWitness, binary_axis


CLAIM_ID = "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001"


def compatible_positive_exponents(
    distance_ratio: Fraction,
    response_ratio_lower: Fraction,
    response_ratio_upper: Fraction,
) -> tuple[PositiveCount, ...]:
    """Enumerate every compatible positive exponent without logarithms.

    For a distance ratio greater than the One, successive positive powers are
    strictly increasing.  The first power strictly above the response upper
    endpoint therefore closes every later candidate by induction.
    """

    if not all(isinstance(value, Fraction) for value in (distance_ratio, response_ratio_lower, response_ratio_upper)):
        raise ValueError("boundary-growth comparison requires exact fractions")
    if distance_ratio <= 1:
        raise ValueError("distance ratio must be greater than the One")
    if response_ratio_lower <= 1 or response_ratio_lower > response_ratio_upper:
        raise ValueError("response-ratio interval must be positive, ordered and above the One")

    exponent = PositiveCount(1)
    predicted = distance_ratio
    survivors: list[PositiveCount] = []
    while predicted <= response_ratio_upper:
        if response_ratio_lower <= predicted:
            survivors.append(exponent)
        exponent = PositiveCount(exponent.value + 1)
        predicted *= distance_ratio
    return tuple(survivors)


def monotonic_stop_certificate(distance_ratio: Fraction, response_upper: Fraction) -> bool:
    """Check that strict excess remains strict for every positive successor."""

    if distance_ratio <= 1 or response_upper <= 1:
        raise ValueError("monotonic certificate requires ratios above the One")
    exponent = PositiveCount(1)
    predicted = distance_ratio
    while predicted <= response_upper:
        exponent = PositiveCount(exponent.value + 1)
        predicted *= distance_ratio
    successor = predicted * distance_ratio
    return predicted > response_upper and successor > predicted


_SYNTHETIC_THREE = compatible_positive_exponents(Fraction(3, 1), Fraction(27, 1), Fraction(27, 1))
_SYNTHETIC_INTERVAL = compatible_positive_exponents(Fraction(2, 1), Fraction(7, 1), Fraction(9, 1))


SPEC = FormalPrerequisiteSpec(
    claim_id=CLAIM_ID,
    title="Exact source-boundary growth measurement discriminator",
    statement=(
        "Within a complete source-boundary dilution experiment, physical boundary-growth dimension is measured "
        "without a fitted exponent or logarithm by comparing exact positive distance and response ratios, "
        "generating every positive exponent by repeated composition, retaining the complete compatible family "
        "and closing all later candidates only after a monotonic strict-excess certificate."
    ),
    dependencies=(
        "SFT-FOUNDATION-PART-EQUIVALENCE-001",
        "SFT-MATH-EXACT-ARITHMETIC-001",
        "SFT-MATH-ORDER-LATTICE-001",
        "SFT-MATH-COMBINATORICS-001",
        "SFT-PHYS-MEAS-VALUE-RECORD-001",
        "SFT-PHYS-MEAS-UNCERTAINTY-001",
        "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001",
        "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
        "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001",
        "SFT-PHYS-FIELD-SOURCE-RESPONSE-001",
        "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001",
    ),
    generation_rule=(
        "Generate the complete product of source carrier, distance comparison, response comparison, scale, "
        "candidate generation, selection, stopping, target access, evidence record and extra-rule forms."
    ),
    grammar_boundary=(
        "All finite exact procedures for inferring a positive source-boundary growth exponent from two or more "
        "registered distance/response observations under admitted conserved-source dilution, including complete "
        "uncertainty support and a depth-independent stopping certificate."
    ),
    axes=(
        binary_axis("source", "What fixes the compared carrier?", "unbound-response-values", "Unbound responses may come from different sources or preparations.", "one-retained-source-boundary", "Every comparison retains one source, boundary preparation and observation trace."),
        binary_axis("distance", "How are distance changes represented?", "floating-or-signed-distance", "Floating or signed distances are outside the exact positive proof domain.", "exact-positive-distance-ratio", "Two retained positive supports produce an exact held ratio above the One."),
        binary_axis("response", "How are measured responses represented?", "point-answer-without-uncertainty", "A point answer discards unresolved measurement support.", "complete-positive-response-ratio-interval", "All registered response and uncertainty endpoints enter one exact ordered ratio interval."),
        binary_axis("scale", "How is unknown source scale handled?", "fitted-source-amplitude", "A fitted amplitude is a free target-derived parameter.", "same-source-ratio-cancellation", "Comparing one source at two distances cancels its unchanged scale by exact pairing."),
        binary_axis("candidates", "How are growth exponents generated?", "borrowed-or-fitted-exponent", "A borrowed exponent selects the answer before measurement.", "positive-successor-power-family", "Start at the first positive count and generate each later power by one exact product."),
        binary_axis("selection", "Which exponent is reported?", "best-fit-or-first-match", "Best fit or first match can erase tied compatible alternatives.", "all-interval-compatible-exponents", "Every generated power within the complete measured interval remains held."),
        binary_axis("stopping", "When is the candidate family closed?", "fixed-search-depth", "A fixed depth can hide a later compatible candidate.", "monotonic-strict-excess-certificate", "Once a power exceeds the upper interval, multiplication by a ratio above the One excludes every successor."),
        binary_axis("target", "Can the method read observations before sealing?", "target-readable-method", "Target access can choose the exponent rule.", "postseal-custodied-observations", "The complete method and inputs are sealed before the custodian releases observations."),
        binary_axis("record", "What evidence is retained?", "reported-exponent-only", "An exponent alone cannot reproduce generation, comparison or closure.", "complete-ratio-power-decision-trace", "Distances, responses, intervals, powers, decisions and stopping witness remain held."),
        binary_axis("extension", "May an extra dimensional rule be added?", "free-dimension-rule", "An added spatial model can force a desired exponent.", "no-extra-rule", "The exact ratios and positive power census supply the complete method."),
    ),
    exact_result=(
        "One source-bound exact ratio experiment, complete response uncertainty, positive successor-power "
        "enumeration, all-compatible selection, monotonic closure, post-seal custody and complete trace."
    ),
    induction_base=(
        "The first positive exponent predicts the registered distance ratio itself and receives one exact "
        "inside/below/above interval decision."
    ),
    induction_step=(
        "If the current power has not strictly exceeded the response upper endpoint, multiply once by the same "
        "distance ratio to obtain the next positive exponent.  If it has exceeded, every successor is strictly "
        "larger and is closed without a completed infinite census."
    ),
    exclusions=(
        "no logarithm, irrational exponent, floating fit or regression",
        "no semantic numerical zero or negative proof magnitude",
        "no physical dimension or inverse-power answer supplied before observation",
        "no target access before the complete method seal",
        "no omitted measurement, uncertainty component or compatible exponent",
    ),
    witnesses=(
        OperationalWitness("generic-exponent", "A synthetic exact cubic relation retains only the third positive exponent.", _SYNTHETIC_THREE == (PositiveCount(3),)),
        OperationalWitness("interval-family", "An interval comparison retains every compatible exponent rather than fitting a point.", _SYNTHETIC_INTERVAL == (PositiveCount(3),)),
        OperationalWitness("monotonic-closure", "Strict excess remains strict at the generated successor.", monotonic_stop_certificate(Fraction(5, 2), Fraction(40, 1))),
    ),
)


SPEC.validate()


__all__ = (
    "CLAIM_ID",
    "SPEC",
    "compatible_positive_exponents",
    "monotonic_stop_certificate",
)

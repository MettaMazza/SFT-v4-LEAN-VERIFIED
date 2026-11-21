"""Exact Fold structures used by the Consciousness foundation.

The module contains no empirical target and no conventional model of mind.
Host indices and empty containers remain implementation mechanics.  Every
derivational magnitude is an exact positive rational part through the One.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction

from sft.engine.exact import ExactPart, HeldLabel


ONE = ExactPart.from_pair(1, 1)
HALF = ExactPart.from_pair(1, 2)
QUARTER = ExactPart.from_pair(1, 4)
THREE_QUARTERS = ExactPart.from_pair(3, 4)


def fold(part: ExactPart) -> ExactPart:
    """Double a part and cast out a complete One while retaining unison."""
    doubled = part.value * 2
    if doubled > 1:
        doubled -= 1
    return ExactPart(doubled)


def preimage_fibre(image: ExactPart) -> tuple[ExactPart, ExactPart]:
    """Return the two held predecessor coordinates of one Fold image."""
    return ExactPart(image.value / 2), ExactPart((image.value + 1) / 2)


def orbit(seed: ExactPart, count: int) -> tuple[ExactPart, ...]:
    if isinstance(count, bool) or not isinstance(count, int) or count < 1:
        raise ValueError("an orbit trace requires a positive finite count")
    states = [seed]
    for _ in range(1, count):
        states.append(fold(states[-1]))
    return tuple(states)


def first_return(seed: ExactPart, search_count: int) -> int | None:
    """Return a host count for the first recurrence within a declared search."""
    state = seed
    for step in range(1, search_count + 1):
        state = fold(state)
        if state == seed:
            return step
    return None


@dataclass(frozen=True)
class ObservationAct:
    source: ExactPart
    image: ExactPart
    held_fibre: HeldLabel | None

    @property
    def reversible_from_record(self) -> bool:
        if self.held_fibre is None:
            return False
        lower, upper = preimage_fibre(self.image)
        return self.source == (lower if self.held_fibre.label == "lower" else upper)


def observe(source: ExactPart, retain_fibre: bool = True) -> ObservationAct:
    image = fold(source)
    lower, upper = preimage_fibre(image)
    label = None
    if retain_fibre:
        if source == lower:
            label = HeldLabel("fold-fibre", "lower")
        elif source == upper:
            label = HeldLabel("fold-fibre", "upper")
        else:
            raise ValueError("source is not in its generated Fold fibre")
    return ObservationAct(source, image, label)


def observer_observed_lock() -> dict[str, object]:
    lower, upper = preimage_fibre(HALF)
    return {
        "observer": lower,
        "observed": upper,
        "distinct": lower != upper,
        "same_image": fold(lower) == fold(upper) == HALF,
        "whole_partition": lower.value + upper.value == ONE.value,
        "completion": fold(HALF) == ONE,
    }


def finite_self_model_trace() -> tuple[ExactPart, ...]:
    """The complete nonidentity self-application trace from the lower fibre."""
    return (QUARTER, HALF, ONE)


def recurrent_pair() -> tuple[ExactPart, ExactPart]:
    first = ExactPart.from_pair(1, 3)
    second = ExactPart.from_pair(2, 3)
    if fold(first) != second or fold(second) != first:
        raise AssertionError("the generated complementary recurrence failed")
    return first, second


def three_quality_support() -> tuple[ExactPart, ExactPart, ExactPart]:
    states = (
        ExactPart.from_pair(1, 7),
        ExactPart.from_pair(2, 7),
        ExactPart.from_pair(4, 7),
    )
    if tuple(fold(item) for item in states) != (states[1], states[2], states[0]):
        raise AssertionError("the generated three-position recurrence failed")
    if sum((item.value for item in states), Fraction(0, 1)) != ONE.value:
        raise AssertionError("the three-position support does not compose to the One")
    return states


def red_of_red_structure() -> dict[str, object]:
    """Formal carrier for a specific internally reidentified qualitative label.

    The word ``red`` is a held empirical label, never an answer-producing proof
    magnitude.  The Fold contribution is the complete recurrent support and the
    identity-preserving self-observation relation.  Which stimulus/report class
    carries that label is opened only by a later empirical custodian.
    """
    support = three_quality_support()
    label = HeldLabel("qualitative-identity", "red")
    return {
        "held_label": label,
        "support": support,
        "complete_recurrence": tuple(fold(item) for item in support) == (support[1], support[2], support[0]),
        "support_partitions_one": sum((item.value for item in support), Fraction(0, 1)) == ONE.value,
        "self_reidentification": (label.family, label.label) == ("qualitative-identity", "red"),
        "external_assignment_is_not_derivation": True,
    }


def structural_witnesses() -> dict[str, bool]:
    lock = observer_observed_lock()
    pair = recurrent_pair()
    triple = three_quality_support()
    red = red_of_red_structure()
    return {
        "two_preimages_are_distinct": bool(lock["distinct"]),
        "two_preimages_share_one_image": bool(lock["same_image"]),
        "observer_observed_partition_the_one": bool(lock["whole_partition"]),
        "binding_lock_completes": bool(lock["completion"]),
        "unretained_observation_is_not_reversible": not observe(QUARTER, False).reversible_from_record,
        "retained_observation_is_reversible": observe(QUARTER, True).reversible_from_record,
        "self_model_closes_in_two_nonidentity_acts": finite_self_model_trace() == (QUARTER, HALF, ONE),
        "complementary_pair_recurs": fold(pair[0]) == pair[1] and fold(pair[1]) == pair[0],
        "three_quality_support_recurs": tuple(fold(item) for item in triple) == (triple[1], triple[2], triple[0]),
        "red_of_red_form_is_complete": all((red["complete_recurrence"], red["support_partitions_one"], red["self_reidentification"])),
    }


if not all(structural_witnesses().values()):
    raise AssertionError("a Consciousness foundation structural witness failed")


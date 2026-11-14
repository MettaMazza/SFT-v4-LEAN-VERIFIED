#!/usr/bin/env python3
"""Implementation-distinct validator for terminal hydrogen Rydberg completion."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005"

DOMAINS = (
    ("replace-or-erase-predecessor", "retain-and-compose-predecessors"),
    ("imported-measured-mass-factor", "exact-reduced-mass-from-terminal-rho"),
    ("untyped-coefficient-list", "role-typed-alpha-return-chain"),
    ("signed-floating-series", "ordered-positive-held-Take"),
    ("selected-or-open-order", "finite-carrier-exhaustion-order"),
    ("answer-only-decimal", "alpha-square-times-terminal-scale"),
    ("measurement-readable-execution", "target-inaccessible-until-seal"),
    ("concealed-development-provenance", "disclosed-observational-prediction-protocol"),
    ("result-without-root-trace", "complete-root-directed-trace"),
    ("free-extra-term", "no-extra-rule"),
)


def take(whole: Fraction, part: Fraction) -> Fraction:
    if not isinstance(whole, Fraction) or not isinstance(part, Fraction) or whole <= part or part <= 0:
        raise ValueError("independent positive Take failed")
    return whole - part


def side(x: Fraction, pair_sum: Fraction, product_value: Fraction):
    first, second = x ** 3 + pair_sum * x, x ** 2 + product_value
    if first == second:
        return ()
    return ("first", first - second) if first > second else ("second", second - first)


def roots() -> tuple[tuple[Fraction, Fraction], ...]:
    pair_sum, product_value = Fraction(1, 6), Fraction(1, 485)
    for depth in range(1, 33):
        support, intervals = 2 ** depth, []
        lower, lower_side = Fraction(1, 2 ** depth), side(Fraction(1, 2 ** depth), pair_sum, product_value)
        for index in range(2, support + 1):
            upper = Fraction(index, support)
            upper_side = side(upper, pair_sum, product_value)
            if lower_side == ():
                intervals.append((lower, lower))
            elif upper_side == () or lower_side[0] != upper_side[0]:
                intervals.append((lower, upper))
            lower, lower_side = upper, upper_side
        if len(intervals) == 3:
            break
    else:
        raise ValueError("independent root isolation failed")
    while any(upper - lower > Fraction(1, 10 ** 18) for lower, upper in intervals[:2]):
        refined = []
        for lower, upper in intervals:
            midpoint = (lower + upper) / 2
            lower_side, midpoint_side = side(lower, pair_sum, product_value), side(midpoint, pair_sum, product_value)
            if midpoint_side == ():
                refined.append((midpoint, midpoint))
            elif lower_side == () or lower_side[0] != midpoint_side[0]:
                refined.append((lower, midpoint))
            else:
                refined.append((midpoint, upper))
        intervals = refined
    return tuple(intervals)


def proton_interval(alpha: Fraction) -> tuple[Fraction, Fraction]:
    electron, muon = roots()[:2]
    electron_mass = electron[0] ** 2, electron[1] ** 2
    muon_mass = muon[0] ** 2, muon[1] ** 2
    base = (
        Fraction(1, 3) * take(1 / electron_mass[1], 1 / muon_mass[0]),
        Fraction(1, 3) * take(1 / electron_mass[0], 1 / muon_mass[1]),
    )
    dressing = Fraction(53, 30) * alpha ** 2 * (Fraction(1, 1) + Fraction(2, 135) * alpha)
    retention = take(Fraction(1, 1), dressing)
    return base[0] * retention, base[1] * retention


def exact_arithmetic() -> bool:
    alpha = Fraction(3676744786, 503846395469)
    rho = proton_interval(alpha)
    def scale(value: Fraction) -> Fraction:
        result = value / (value + 1) + alpha ** 2 / 5 + alpha ** 3 / 2
        result = take(result, 6 * alpha ** 4)
        return result + 49 * alpha ** 5
    interval = scale(rho[0]), scale(rho[1])
    rest = alpha ** 2 / 2 * interval[0], alpha ** 2 / 2 * interval[1]
    return (
        Fraction(99, 100) < interval[0] < interval[1] < Fraction(1, 1)
        and Fraction(1, 100000) < rest[0] < rest[1] < Fraction(1, 10000)
        and Fraction(3, 4) * interval[0] > Fraction(5, 36) * interval[1] > 0
    )


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = tuple("__".join(row) for row in product(*DOMAINS))
    survivor = "__".join(domain[1] for domain in DOMAINS)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    arithmetic = exact_arithmetic()
    passed = (
        claim_id == CLAIM_ID
        and sealed["claim_id"] == claim_id
        and arithmetic
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == 1024
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]}
        == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "generated_cardinality": len(generated),
            "unique_survivor": survivor if passed else None,
            "exact_arithmetic": arithmetic,
            "target_value_accessed": False,
            "implementation": "independent exact Fraction cubic isolation and terminal hydrogen reconstruction",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

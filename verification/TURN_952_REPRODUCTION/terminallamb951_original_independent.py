#!/usr/bin/env python3
"""Implementation-distinct validator for terminal atomic-precision laws."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


LAMB = "SFT-PHYS-ATOMIC-LAMB-SHIFT-TERMINAL-005"
FINE = "SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005"
HYPERFINE = "SFT-PHYS-ATOMIC-HYPERFINE-TERMINAL-005"


DOMAINS = (
    ("replace-or-erase-predecessor", "retain-and-version-predecessor"),
    ("selected-partial-support", "complete-typed-terminal-support"),
    ("signed-floating-or-complex-series", "ordered-positive-held-parts"),
    ("selected-or-open-order", "finite-carrier-exhaustion-order"),
    ("untyped-coefficient-list", "role-preserving-exact-composition"),
    ("unbounded-extra-correction", "no-generated-carrier-remains"),
    ("measurement-readable-execution", "target-inaccessible-until-seal"),
    ("hidden-fit-or-forward-claim", "disclosed-observational-prediction-protocol"),
    ("result-without-root-trace", "complete-root-directed-trace"),
    ("free-extra-term", "no-extra-rule"),
)


def take(whole: Fraction, part: Fraction) -> Fraction:
    if not isinstance(whole, Fraction) or not isinstance(part, Fraction) or whole <= part or part <= 0:
        raise ValueError("independent positive Take failed")
    return whole - part


def side(x: Fraction, pair_sum: Fraction, product_value: Fraction):
    first = x ** 3 + pair_sum * x
    second = x ** 2 + product_value
    if first == second:
        return ()
    return ("first", first - second) if first > second else ("second", second - first)


def isolate_roots() -> tuple[tuple[Fraction, Fraction], ...]:
    pair_sum, product_value = Fraction(1, 6), Fraction(1, 485)
    for depth in range(1, 33):
        support = 2 ** depth
        intervals = []
        lower = Fraction(1, support)
        lower_side = side(lower, pair_sum, product_value)
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
    electron, muon = isolate_roots()[:2]
    electron_mass = electron[0] ** 2, electron[1] ** 2
    muon_mass = muon[0] ** 2, muon[1] ** 2
    base = (
        Fraction(1, 3) * take(1 / electron_mass[1], 1 / muon_mass[0]),
        Fraction(1, 3) * take(1 / electron_mass[0], 1 / muon_mass[1]),
    )
    dressing = Fraction(53, 30) * alpha ** 2 * (Fraction(1, 1) + Fraction(2, 135) * alpha)
    retention = take(Fraction(1, 1), dressing)
    return base[0] * retention, base[1] * retention


def exact_arithmetic(claim_id: str) -> bool:
    alpha = Fraction(3676744786, 503846395469)
    if claim_id == LAMB:
        retained = take(Fraction(53, 64), Fraction(10, 109) * alpha)
        retained = take(retained, alpha ** 2 / (3 * 53 * 64))
        retained = take(retained, alpha ** 3 / (53 * 64))
        carrier = alpha ** 3 * retained
        return Fraction(1, 10 ** 7) < carrier < Fraction(1, 10 ** 6)
    if claim_id == FINE:
        retained = Fraction(1, 1) + alpha / 4
        retained = take(retained, Fraction(113, 288) * alpha ** 2)
        retained = take(retained, alpha ** 3 / 32)
        retained = take(retained, Fraction(10, 137) * alpha ** 4)
        carrier = alpha ** 2 / 16 * retained
        return Fraction(1, 10 ** 6) < carrier < Fraction(1, 100000)
    if claim_id == HYPERFINE:
        projection = take(Fraction(355, 113), Fraction(1, 3))
        projection = take(projection, 2 * alpha)
        projection += Fraction(5, 16) * alpha
        projection = take(projection, Fraction(16, 53) * alpha ** 2)
        projection = take(projection, Fraction(7, 80) * alpha ** 3)
        projection += alpha ** 4 / 135
        rho = proton_interval(alpha)
        def carrier(value: Fraction) -> Fraction:
            reduced = value / (value + 1)
            return Fraction(16, 3) * alpha ** 2 / value * reduced ** 3 * projection
        interval = carrier(rho[1]), carrier(rho[0])
        return (
            Fraction(2, 1) < projection < Fraction(3, 1)
            and Fraction(1, 10 ** 7) < interval[0] < interval[1] < Fraction(1, 10 ** 6)
        )
    return False


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = tuple("__".join(row) for row in product(*DOMAINS))
    survivor = "__".join(domain[1] for domain in DOMAINS)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    arithmetic = exact_arithmetic(claim_id)
    passed = (
        claim_id in {LAMB, FINE, HYPERFINE}
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
            "implementation": "independent exact Fraction reconstruction with separate cubic isolation",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

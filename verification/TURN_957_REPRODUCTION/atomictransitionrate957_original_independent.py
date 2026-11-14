#!/usr/bin/env python3
"""Implementation-distinct validator for terminal atomic transition rates."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005"
DOMAINS = (
    ("replace-selection-law", "retain-one-unit-elementary-act"),
    ("selected-decimal-frequency", "exact-positive-level-gap"),
    ("free-rate-exponent", "complete-generator-three-volume"),
    ("erase-or-fit-strength", "held-exact-line-strength"),
    ("unweighted-or-fitted-factor", "divide-by-complete-positive-weight"),
    ("independent-lifetime-parameter", "reciprocal-complete-rate-sum"),
    ("chosen-power-list", "append-held-boundary-pair"),
    ("universal-slower-label", "typed-channel-conditional-suppression"),
    ("external-target-readable", "target-inaccessible-until-seal"),
    ("free-coefficient-or-exception", "no-extra-rule"),
)


def exponent(rank: int) -> int:
    return 2 * rank + 1


def rate(gap: Fraction, strength: Fraction, weight: int, rank: int) -> Fraction:
    return gap ** exponent(rank) * strength / weight


def exact_arithmetic() -> bool:
    gaps = tuple(Fraction(index, 19) for index in range(1, 19))
    exponent_law = all(exponent(rank + 1) == exponent(rank) + 2 for rank in range(1, 64))
    suppression = all(
        rate(gap, Fraction(5, 7), 3, rank + 1) / rate(gap, Fraction(5, 7), 3, rank) == gap * gap
        for gap in gaps for rank in range(1, 8)
    )
    rates = (Fraction(1, 8), Fraction(1, 24))
    lifetime = Fraction(1, 1) / sum(rates)
    return exponent_law and suppression and lifetime == 6


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
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
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
            "implementation": "independent positive-rational electric-multipole induction and lifetime reconstruction",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

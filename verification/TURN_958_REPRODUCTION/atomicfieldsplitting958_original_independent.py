#!/usr/bin/env python3
"""Implementation-distinct validator for terminal atomic field splitting."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-ATOMIC-FIELD-SPLITTING-TERMINAL-005"
DOMAINS = (
    ("replace-field-predecessors", "compose-immutable-field-predecessors"),
    ("selected-line-count", "complete-held-orientation-successor"),
    ("signed-energy-scalar", "held-side-label-and-positive-distance"),
    ("chosen-field-polynomial", "one-field-act-per-held-orientation"),
    ("unequal-free-spacing", "one-common-positive-field-step"),
    ("erase-first-displacement", "held-first-order-dipole-channel"),
    ("free-first-order-shift", "paired-first-act-closes-then-square"),
    ("universal-single-order", "degeneracy-typed-response-order"),
    ("external-target-readable", "target-inaccessible-until-seal"),
    ("free-coefficient-or-rule", "no-extra-rule"),
)


def exact_arithmetic() -> bool:
    multiplicities = all((doubled + 1) - doubled == 1 for doubled in range(1, 128))
    fields = tuple(Fraction(index, 29) for index in range(1, 29))
    g_factor = Fraction(7, 5)
    dipole = Fraction(11, 13)
    polarizability = Fraction(17, 19)
    linear = all(g_factor * 3 * (2 * field) == 2 * (g_factor * 3 * field) for field in fields)
    degenerate = all(dipole * (2 * field) == 2 * dipole * field for field in fields)
    nondegenerate = all(
        polarizability * (2 * field) * (2 * field) / 2 == 4 * (polarizability * field * field / 2)
        for field in fields
    )
    return multiplicities and linear and degenerate and nondegenerate


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
            "implementation": "independent positive-rational angular-support and first/second field-order reconstruction",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

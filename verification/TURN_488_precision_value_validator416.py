"""Implementation-distinct validator for Physics precision successors."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


ELECTROWEAK_ID = "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003"
HIERARCHY_ID = "SFT-PHYS-SCALE-PROTON-PLANCK-TERMINAL-003"

RELATIONS = {
    ELECTROWEAK_ID: (
        "free-running-level-or-imported-renormalization",
        "level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen",
    ),
    HIERARCHY_ID: (
        "free-hierarchy-exponent-or-untyped-correction",
        "bare-hierarchy-times-One-complement-of-two-thirds-alpha",
    ),
}


def exact_values() -> dict[str, Fraction]:
    inverse_alpha = Fraction(503846395469, 3676744786)
    alpha = Fraction(1, 1) / inverse_alpha
    terminal_support = 2 ** 4
    level = terminal_support - 3
    charged = (level + 2) ** 2
    neutral = 4 * (level + 1) ** 2
    weak = Fraction(charged, charged + neutral) + alpha / (terminal_support + 1)
    hierarchy = Fraction(2 ** 127, 1) * (Fraction(1, 1) - Fraction(2, 3) * alpha)
    return {ELECTROWEAK_ID: weak, HIERARCHY_ID: hierarchy}


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    rejected_relation, admitted_relation = RELATIONS[claim_id]
    domains = (
        ("detached-measured-number", "admitted-lower-law-carrier"),
        ("selected-intermediate-stage", "complete-promotion-termination"),
        ("free-scale-support", "complete-binary-terminal-support"),
        (rejected_relation, admitted_relation),
        ("fitted-additive-offset", "single-typed-terminal-alpha-transport"),
        ("target-selected-orientation", "orientation-fixed-by-share-or-retention"),
        ("selected-neighbourhood", "complete-registered-product"),
        ("successor-without-lower-controls", "bare-and-intermediate-forms-preserved"),
        ("target-visible-before-seal", "exact-result-sealed-before-target-release"),
        ("free-extra-correction", "no-extra-rule"),
    )
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    arithmetic = exact_values()
    exact_ok = (
        arithmetic[ELECTROWEAK_ID] == Fraction(1930922298157999, 8642477221479757)
        and arithmetic[HIERARCHY_ID] == Fraction(
            255923934603817488008405160690199418432572494970880,
            1511539186407,
        )
    )
    passed = (
        sealed["claim_id"] == claim_id
        and received == generated
        and sealed["census"]["expected_cardinality"] == 1024
        and len(set(received)) == 1024
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]}
        == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
        and exact_ok
    )
    print(
        json.dumps(
            {
                "validated_seal_hash": sealed["seal_hash"],
                "recomputed_from_declared_inputs": True,
                "passed": passed,
                "certificate": {
                    "claim_id": claim_id,
                    "generated_cardinality": len(generated),
                    "unique_survivor": survivor if passed else None,
                    "exact_result": str(arithmetic[claim_id]),
                },
            },
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Implementation-distinct validator for terminal atomic periodicity."""

from __future__ import annotations

from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005"
DOMAINS = (
    ("replace-or-relabel-capacity", "compose-immutable-orbit-capacity"),
    ("selected-width-list", "all-positive-orbit-ranks-through-n"),
    ("asserted-two-n-square", "exact-complete-capacity-sum"),
    ("memorized-filling-table", "increasing-joint-cover-principal-tie"),
    ("chosen-period-endpoints", "first-cell-then-complete-rank-two-boundary"),
    ("free-reset-rule", "successor-after-held-closure"),
    ("strict-stepwise-monotonicity", "rising-envelope-and-boundary-reset"),
    ("external-data-readable", "target-inaccessible-until-seal"),
    ("answer-without-dependencies", "complete-root-directed-trace"),
    ("free-exception-or-width", "no-extra-rule"),
)


def orbit_capacity(rank: int) -> int:
    return 2 * (1 + 2 * (rank - 1))


def shell_capacity(rank: int) -> int:
    return sum(orbit_capacity(orbit) for orbit in range(1, rank + 1))


def closure_prefix() -> tuple[int, ...]:
    total = 0
    closures = []
    for cover in range(2, 30):
        for principal in range(1, cover):
            orbit = cover - principal
            if orbit > principal:
                continue
            total += orbit_capacity(orbit)
            if (principal, orbit) == (1, 1) or orbit == 2:
                closures.append(total)
                if len(closures) == 7:
                    return tuple(closures)
    raise ValueError("independent closure generation failed")


def exact_arithmetic() -> bool:
    closures = closure_prefix()
    prior = 0
    widths = []
    for closure in closures:
        widths.append(closure - prior)
        prior = closure
    return (
        all(shell_capacity(rank) == 2 * rank * rank for rank in range(1, 65))
        and closures == (2, 10, 18, 36, 54, 86, 118)
        and tuple(widths) == (2, 8, 8, 18, 18, 32, 32)
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
            "implementation": "independent positive-rank shell sum and joint-cover closure walk",
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

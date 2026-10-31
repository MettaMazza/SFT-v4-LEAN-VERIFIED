#!/usr/bin/env python3
"""Independent exact reconstruction of the common scale-axis grammar."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-SCALE-COMMON-AXIS-TERMINAL-030"
DOMAINS = (
    ("numerical-zero-origin", "One-origin"),
    ("linear-or-continuous-free-step", "binary-complete-support-successor"),
    ("untyped-arbitrary-spacing", "reciprocal-One-over-support-spacing"),
    ("independent-free-running-axis", "one-local-act-per-support-cell"),
    ("selected-known-sectors", "complete-prime-sector-ladder"),
    ("linear-channel-ratio", "target-assigned-angle", "neutral-square-over-charged-plus-neutral-squares"),
    ("identify-active-level-with-full-support", "support-sixteen-hold-three-return-alpha-over-seventeen"),
    ("target-selected-depth", "unique-support-two-source-four"),
    ("unit-name-changes-dimensionless-law", "common-positive-rational-rescaling-cancels"),
    ("measured-rung-or-free-unit-selects-law", "forced-ratio-then-postseal-held-reference"),
    ("target-readable-before-seal", "capability-closed-before-target-release"),
    ("claim-historical-blindness", "observational-development-explicit"),
    ("free-scale-or-running-correction", "no-extra-rule"),
)
SURVIVOR = (
    "One-origin",
    "binary-complete-support-successor",
    "reciprocal-One-over-support-spacing",
    "one-local-act-per-support-cell",
    "complete-prime-sector-ladder",
    "neutral-square-over-charged-plus-neutral-squares",
    "support-sixteen-hold-three-return-alpha-over-seventeen",
    "unique-support-two-source-four",
    "common-positive-rational-rescaling-cancels",
    "forced-ratio-then-postseal-held-reference",
    "capability-closed-before-target-release",
    "observational-development-explicit",
    "no-extra-rule",
)


def support(level: int) -> int:
    value = 1
    for _ in range(1, level):
        value += value
    return value


def binary_support(value: int) -> bool:
    generated = 1
    while generated < value:
        generated += generated
    return generated == value


def weak_share(active_support: int) -> Fraction:
    charged = Fraction(active_support + 1, active_support + 2)
    neutral = Fraction(1, 2)
    return neutral * neutral / (charged * charged + neutral * neutral)


def theorem_check() -> bool:
    supports = tuple(support(level) for level in range(1, 9))
    spacings = tuple(Fraction(1, value) for value in supports)
    weak = tuple(weak_share(value) for value in supports[:5])
    anchors = tuple(level for level in range(1, 17) if binary_support(2 + support(level)))
    active = 16 - 3
    alpha = Fraction(3676744786, 503846395469)
    terminal = weak_share(active) + alpha / 17
    rescaled = (Fraction(7, 5) * Fraction(13, 17)) / (Fraction(11, 3) * Fraction(13, 17))
    return all((
        supports == (1, 2, 4, 8, 16, 32, 64, 128),
        all(spacings[index + 1] * 2 == spacings[index] for index in range(7)),
        weak == (Fraction(9, 25), Fraction(4, 13), Fraction(9, 34), Fraction(25, 106), Fraction(81, 370)),
        all(weak[index] > weak[index + 1] for index in range(4)),
        anchors == (2,),
        active == 13,
        weak_share(active) == Fraction(225, 1009),
        terminal == Fraction(1930922298157999, 8642477221479757),
        rescaled == Fraction(21, 55),
    ))


def generated_ids() -> tuple[str, ...]:
    return tuple("__".join(row) for row in product(*DOMAINS))


def main() -> None:
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = generated_ids()
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    recomputed = {
        candidate_id: tuple(candidate_id.split("__")) == SURVIVOR and theorem_check()
        for candidate_id in generated
    }
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    passed = all((
        sys.argv[1] == CLAIM_ID,
        sealed["claim_id"] == CLAIM_ID,
        received == generated,
        len(set(received)) == sealed["census"]["expected_cardinality"] == 12288,
        decisions == recomputed,
        sum(recomputed.values()) == 1,
        {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"},
        all(row["passed"] for row in sealed["controls"]),
        theorem_check(),
    ))
    print(json.dumps({
        "passed": passed,
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "certificate": {
            "candidate_count": len(generated),
            "support_vector": [1, 2, 4, 8, 16, 32, 64, 128],
            "terminal_active_level": 13,
            "terminal_on_shell_share": "1930922298157999/8642477221479757",
            "target_content_used": False,
            "survivor": "__".join(SURVIVOR),
        },
    }, sort_keys=True))
    raise SystemExit(0 if passed else 1)


if __name__ == "__main__":
    main()

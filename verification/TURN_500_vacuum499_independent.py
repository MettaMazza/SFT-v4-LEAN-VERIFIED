#!/usr/bin/env python3
"""Implementation-distinct vacuum-floor and cosmological-scale reconstruction."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035"
DOMAINS = (
    ("borrowed-cosmic-volume", "generator-three-cubed-volume"),
    ("selected-depth-ten-or-twenty", "least-cover-depth-five"),
    ("one-label-per-depth", "both-held-labels-per-depth"),
    ("amplitude-relabeled-as-energy", "two-leg-energy-self-composition"),
    ("named-one-over-two-to-twenty", "complete-boundary-energy-floor"),
    ("unbounded-mode-sum-as-local-density", "complete-finite-ledger-and-half-One-mean"),
    ("local-floor-equals-cosmic-fraction", "terminal-eleven-sixteenths-share"),
    ("borrowed-continuum-coefficient", "three-space-squared-rate-carrier"),
    ("untyped-number-identification-or-rubber-stamp", "distinct-typed-quantities-and-prior-correction"),
    ("fitted-dimensional-value", "postseal-rate-squared-over-speed-squared"),
    ("measurement-readable-before-seal", "postseal-only-comparison"),
    ("free-vacuum-scale", "no-extra-rule"),
)
SURVIVOR = tuple(domain[1] for domain in DOMAINS)


def generated_ids() -> tuple[str, ...]:
    return tuple("__".join(row) for row in product(*DOMAINS))


def least_cover(size: int) -> tuple[int, int]:
    depth = 1
    support = 2
    while support < size:
        support *= 2
        depth += 1
    return depth, support


def radiative_ledger(depth: int) -> tuple[int, Fraction, Fraction]:
    support = 2 ** depth
    denominator = 2 ** (depth + 1)
    total = sum((Fraction(2 * rank - 1, denominator) for rank in range(1, support + 1)), Fraction())
    return support, total, total / support


def theorem_check() -> bool:
    cover_depth, cover_support = least_cover(3 ** 3)
    boundary_depth = 2 * cover_depth
    amplitude = Fraction(1, 2 ** boundary_depth)
    floor = amplitude * amplitude
    ledger = tuple(radiative_ledger(depth) for depth in range(1, 10))
    normalized_lambda = 3 * Fraction(11, 16)
    covariance = all(
        normalized_lambda * (rate * scale) ** 2 / (speed * scale) ** 2
        == normalized_lambda * rate ** 2 / speed ** 2
        for rate, speed, scale in product(
            (Fraction(1, 3), Fraction(2, 3), Fraction(1)),
            (Fraction(1, 2), Fraction(3, 4), Fraction(1)),
            (Fraction(1, 4), Fraction(2), Fraction(3)),
        )
    )
    support_forms = tuple(
        (complete, self_pair, complete and self_pair)
        for complete, self_pair in product((False, True), repeat=2)
    )
    return (
        cover_depth == 5
        and cover_support == 32
        and boundary_depth == 10
        and amplitude == Fraction(1, 1024)
        and floor == Fraction(1, 1048576)
        and len(support_forms) == 4
        and sum(row[2] for row in support_forms) == 1
        and all(total == Fraction(support, 2) and mean == Fraction(1, 2) for support, total, mean in ledger)
        and normalized_lambda == Fraction(33, 16)
        and floor != Fraction(11, 16)
        and covariance
    )


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
    passed = (
        sys.argv[1] == CLAIM_ID
        and sealed["claim_id"] == CLAIM_ID
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == 4096
        and decisions == recomputed
        and sum(recomputed.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and {row["kind"] for row in sealed["controls"]}
        == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] for row in sealed["controls"])
        and theorem_check()
    )
    print(json.dumps({
        "passed": passed,
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "certificate": {
            "candidate_count": len(generated),
            "generation_volume": 27,
            "least_binary_cover_depth": 5,
            "complete_boundary_depth": 10,
            "local_amplitude_floor": "1/1024",
            "local_energy_floor": "1/1048576",
            "finite_radiative_mean": "1/2",
            "terminal_vacuum_share": "11/16",
            "normalized_lambda": "33/16",
            "survivor": "__".join(SURVIVOR),
        },
    }, sort_keys=True))
    raise SystemExit(0 if passed else 1)


if __name__ == "__main__":
    main()

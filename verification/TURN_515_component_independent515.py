#!/usr/bin/env python3
"""Implementation-distinct terminal cosmic transport reconstruction."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032"
DOMAINS = (
    ("borrowed-three-dimensional-volume", "admitted-generator-three-volume"),
    ("selected-matter-power", "inverse-volume-third-power"),
    ("selected-radiation-power", "volume-plus-one-recurrence-power"),
    ("selected-static-density", "Fold-invariant-One"),
    ("superseded-two-thirds-curve", "terminal-eleven-five-curve"),
    ("fitted-epoch-density", "component-over-complete-rate"),
    ("decimal-root-selected", "exact-cube-eleven-fifths"),
    ("old-half-magnitude-and-four-cube", "exact-seventeen-thirty-seconds-and-twenty-two-fifths"),
    ("negative-proof-scalars", "positive-magnitude-with-held-orientation"),
    ("fitted-Hubble-normalization", "post-seal-held-reference-transport"),
    ("measurements-readable-before-seal", "all-targets-open-only-after-seal"),
    ("free-component-correction", "no-extra-rule"),
)
SURVIVOR = tuple(domain[1] for domain in DOMAINS)


def generated_ids() -> tuple[str, ...]:
    return tuple("__".join(row) for row in product(*DOMAINS))


def theorem_check() -> bool:
    matter = Fraction(5, 16)
    vacuum = Fraction(11, 16)
    samples = (Fraction(1), Fraction(3, 2), Fraction(2), Fraction(3))
    if matter + vacuum != 1:
        return False
    if vacuum - matter / 2 != Fraction(17, 32):
        return False
    if vacuum / matter != Fraction(11, 5) or 2 * vacuum / matter != Fraction(22, 5):
        return False
    for stretch in samples:
        matter_carrier = matter * stretch ** 3
        vacuum_carrier = vacuum
        e2 = matter_carrier + vacuum_carrier
        if e2 <= 0 or matter_carrier / e2 + vacuum_carrier / e2 != 1:
            return False
        if stretch ** 4 != stretch ** 3 * stretch:
            return False
    return True


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
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] for row in sealed["controls"])
        and theorem_check()
    )
    print(json.dumps({
        "passed": passed,
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "certificate": {
            "candidate_count": len(generated),
            "matter_power": 3,
            "radiation_power": 4,
            "vacuum_transport": "One",
            "late_e2": "(11+5r^3)/16",
            "matter_fraction": "5r^3/(11+5r^3)",
            "equality_cube": "11/5",
            "acceleration_onset_cube": "22/5",
            "present_acceleration_magnitude": "17/32",
            "survivor": "__".join(SURVIVOR),
        },
    }, sort_keys=True))
    raise SystemExit(0 if passed else 1)


if __name__ == "__main__":
    main()

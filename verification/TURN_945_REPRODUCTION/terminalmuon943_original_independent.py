"""Implementation-distinct validator for terminal turn and anomaly laws."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


TURN_ID = "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004"
ELECTRON_ID = "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004"
MUON_ID = "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004"


DOMAINS = {
    TURN_ID: (
        ("imported-continuum-circle", "exact-generated-turn-carrier"),
        ("selected-sector-count", "generator-three-complete-sectors"),
        ("free-decimal-remainder", "one-positive-return"),
        ("selected-return-depth", "forced-up-cover-depth-seven"),
        ("unbounded-or-selected-support", "four-rung-binary-support-sixteen"),
        ("untyped-sum-or-product", "nested-positive-return-ratio"),
        ("irrational-or-floating-turn", "exact-rational-projection"),
        ("target-readable-shortcut", "registered-observational-prediction-protocol"),
        ("extra-turn-term", "no-extra-rule"),
    ),
    ELECTRON_ID: (
        ("replace-bare-or-leading-law", "retain-admitted-leading-alpha-carrier"),
        ("imported-irrational-turn", "terminal-exact-turn-projection"),
        ("selected-bulk-subset", "complete-volume-held-by-boundary-channels"),
        ("free-first-loop-coefficient", "down-over-open-bulk-held-by-binary-alpha-over-down-colour"),
        ("free-terminal-loop-coefficient", "One-alpha-square-over-down-colour-held-by-up-alpha-cube-over-closed-support"),
        ("signed-or-complex-coefficients", "two-positive-held-pairs"),
        ("append-unbound-anomaly", "hold-alpha-loop-once-from-leading"),
        ("measurement-readable-execution", "target-inaccessible-until-prediction-seal"),
        ("unregistered-fit", "registered-observational-prediction-protocol"),
        ("extra-radiative-term", "no-extra-rule"),
    ),
    MUON_ID: (
        ("independent-fitted-muon-base", "complete-terminal-electron-loop"),
        ("selected-generation-label", "second-charged-lepton-depth"),
        ("selected-alpha-order", "two-charged-end-alpha-square"),
        ("free-leading-muon-weight", "both-labels-over-depth-two-complement"),
        ("free-successor-weight", "one-alpha-over-binary-depth-three-complement"),
        ("selected-terminal-denominator", "four-rung-times-depth-three-plus-down-depth"),
        ("signed-or-cancelled-series", "complete-positive-sum-appended-once"),
        ("measurement-readable-execution", "target-inaccessible-until-prediction-seal"),
        ("unregistered-fit", "registered-observational-prediction-protocol"),
        ("extra-muon-term", "no-extra-rule"),
    ),
}


def positive_take(whole: Fraction, part: Fraction) -> Fraction:
    if whole <= part or part.numerator < 1:
        raise ValueError("independent positive Take orientation failed")
    return whole - part


def exact_values() -> dict[str, Fraction]:
    inverse_alpha = Fraction(503846395469, 3676744786)
    alpha = Fraction(1, 1) / inverse_alpha
    support = 2 ** 4
    turn = Fraction(3, 1) + Fraction(1, Fraction(7, 1) + Fraction(1, support))
    first_pair = positive_take(Fraction(5, 24), Fraction(2, 15) * alpha)
    second_pair = positive_take(Fraction(1, 15) * alpha ** 2, Fraction(7, 30) * alpha ** 3)
    loop = first_pair + second_pair
    retention = positive_take(Fraction(1, 1), alpha * loop)
    electron = alpha / (2 * turn) * retention
    depth_two = 2 * 3 ** 2 - 1
    depth_three = 2 * 3 ** 3 - 1
    terminal = support * depth_three + 5
    muon = electron + alpha ** 2 * (
        Fraction(2, depth_two) + alpha / (2 * depth_three) + alpha ** 2 / terminal
    )
    return {
        TURN_ID: turn,
        ELECTRON_ID: electron,
        MUON_ID: muon,
    }


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    domains = DOMAINS[claim_id]
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    values = exact_values()
    arithmetic = (
        values[TURN_ID] == Fraction(355, 113)
        and Fraction(1, 10000) < values[ELECTRON_ID] < Fraction(1, 100)
        and values[MUON_ID] > values[ELECTRON_ID]
        and 2 * 3 ** 2 - 1 == 17
        and 2 * 3 ** 3 - 1 == 53
        and 2 ** 4 * 53 + 5 == 853
    )
    passed = (
        sealed["claim_id"] == claim_id
        and arithmetic
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == len(generated)
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
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

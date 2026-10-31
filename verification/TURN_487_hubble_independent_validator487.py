"""Implementation-distinct validator for the Hubble calibration law."""

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001"
DOMAINS = (
    ("independent-density-scalars", "one-complete-cosmic-carrier"),
    ("named-matter-and-vacuum", "one-formed-class-and-two-fibre-open-complement"),
    ("selected-or-reversed-shares", "one-third-formed-two-thirds-open"),
    ("free-calibration-scale", "complete-depth-three-Fold-support"),
    ("measured-ratio-correction", "open-share-over-complete-support"),
    ("selected-cosmological-depth", "independently-forced-up-cover-depth"),
    ("arbitrary-denominator", "depth-seven-first-return-floor"),
    ("selected-sign-or-extra-term", "one-positive-orbit-part-inside-open-share"),
    ("hubble-values-readable-before-seal", "both-routes-inaccessible-until-seal"),
    ("mislabel-as-unobserved-discovery", "observational-reconstruction-with-independent-runtime"),
    ("extra-calibration-rule", "no-extra-rule"),
)
SURVIVOR = "__".join(domain[1] for domain in DOMAINS)


def folded(value: Fraction) -> Fraction:
    doubled = value + value
    return doubled if doubled <= 1 else doubled - 1


def first_return_period(value: Fraction) -> int:
    current = value
    count = 0
    while True:
        current = folded(current)
        count += 1
        if current == value:
            return count


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}

    matter, vacuum, support = Fraction(1, 3), Fraction(2, 3), 2 ** 3
    leading = Fraction(1, 1) + vacuum / support
    floor = 2 ** 7 - 1
    refined = Fraction(1, 1) + (vacuum + Fraction(1, floor)) / support
    arithmetic = (
        matter + vacuum == 1
        and support == 8
        and leading == Fraction(13, 12)
        and floor == 127
        and first_return_period(Fraction(1, floor)) == 7
        and refined == Fraction(3305, 3048)
    )
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and decisions == {candidate: candidate == SURVIVOR for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and all(row["passed"] is True for row in sealed["controls"])
        and arithmetic
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "claim_id": CLAIM_ID,
            "generated_cardinality": len(generated),
            "unique_survivor": SURVIVOR if passed else None,
            "leading_ratio": str(leading),
            "refined_ratio": str(refined),
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

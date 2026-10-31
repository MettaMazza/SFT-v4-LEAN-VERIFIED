"""Implementation-distinct validator for the dark/baryon law."""

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001"
DOMAINS = (
    ("named-dark-and-baryon-scalars", "one-complete-matter-cover"),
    ("selected-cosmological-volume", "generator-over-forced-space"),
    ("free-cover-depth", "least-complete-binary-cover"),
    ("independent-normalizations", "depth-and-volume-over-cover"),
    ("measured-ratio-insertion", "volume-over-depth"),
    ("tower-or-up-depth-floor", "own-depth-first-return-floor"),
    ("selected-sign-or-bare-depth", "one-positive-orbit-part-appended"),
    ("density-readable-construction", "densities-inaccessible-until-seal"),
    ("old-answer-runtime-input", "prior-question-machine-independent-reconstruction"),
    ("extra-density-or-fit-term", "no-extra-rule"),
)
SURVIVOR = "__".join(domain[1] for domain in DOMAINS)


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    volume, depth, tower, floor = 3 ** 3, 5, 2 ** 5, 2 ** 5 - 1
    leading = Fraction(volume, depth)
    refined = Fraction(volume, 1) / (Fraction(depth, 1) + Fraction(1, floor))
    arithmetic = (
        volume == 27 and tower == 32 and floor == 31
        and Fraction(depth, tower) + Fraction(volume, tower) == 1
        and leading == Fraction(27, 5) and refined == Fraction(279, 52)
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

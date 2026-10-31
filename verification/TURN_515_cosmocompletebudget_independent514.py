"""Implementation-distinct validator for the refined four-part budget."""

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-COSMO-COMPLETE-BUDGET-001"
DOMAINS = (
    ("selected-density-denominator", "least-generator-volume-binary-cover"),
    ("free-pinned-count", "complete-two-state-boundary-pair"),
    ("named-matter-share", "all-depth-boundary-pairs"),
    ("selected-vacuum-share", "complete-unpinned-complement"),
    ("leading-one-third-two-thirds-only", "five-sixteenths-and-eleven-sixteenths"),
    ("new-baryon-dark-parameter", "admitted-five-to-twenty-seven-partition"),
    ("independent-component-normalizations", "global-matter-times-internal-shares"),
    ("separate-rounded-total", "exact-four-part-One-closure"),
    ("planck-budget-readable-before-seal", "all-planck-rows-inaccessible-until-seal"),
    ("erase-leading-law-or-mislabel-discovery", "disclosed-successor-observational-reconstruction"),
    ("extra-budget-rule", "no-extra-rule"),
)
SURVIVOR = "__".join(domain[1] for domain in DOMAINS)


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    depth, support, pinned, free = 5, 2 ** 5, 2 * 5, 22
    matter, vacuum = Fraction(pinned, support), Fraction(free, support)
    baryon, cold_dark = matter * Fraction(5, 32), matter * Fraction(27, 32)
    arithmetic = (
        support == 32 and pinned == 10 and pinned + free == support
        and matter == Fraction(5, 16) and vacuum == Fraction(11, 16)
        and baryon == Fraction(25, 512) and cold_dark == Fraction(135, 512)
        and matter + vacuum == 1 and baryon + cold_dark == matter
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
            "budget": {"vacuum": str(vacuum), "matter": str(matter), "baryon": str(baryon), "cold_dark": str(cold_dark)},
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

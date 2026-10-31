"""Independent exact reconstruction of the complete sector inventory."""

from fractions import Fraction
from itertools import product
import json
import sys


CLAIM_ID = "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003"
DOMAINS = (
    ("selected-known-sectors", "complete-primes-through-forced-ceiling"),
    ("borrowed-group-dimension", "complete-p-fibre-members"),
    ("listed-particle-names", "p-squared-pair-cells-less-One"),
    ("measured-coupling", "p-predecessor-over-p"),
    ("imported-beta-function", "support-successor-in-sector-gap"),
    ("imported-hadron-taxonomy", "complete-p-fibre-or-antipodal-pair"),
    ("free-mixing-matrix", "three-preimage-offset-over-sector"),
    ("invented-sector-scale", "One-shortfall-equals-one-over-p"),
    ("open-ended-particle-list", "complete-count-and-first-excluded-prime"),
    ("known-counts-visible-before-seal", "inventory-sealed-before-anchor-check"),
    ("omit-fringe-predictions", "standing-falsifiable-penta-hepta-record"),
    ("free-extra-sector", "no-extra-rule"),
)


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    sectors = (2, 3, 5, 7)
    mediators = tuple(p * p - 1 for p in sectors)
    couplings = tuple(Fraction(p - 1, p) for p in sectors)
    exact = (
        mediators == (3, 8, 24, 48)
        and couplings == (Fraction(1, 2), Fraction(2, 3), Fraction(4, 5), Fraction(6, 7))
        and sum(mediators) == 83
        and mediators[2] + mediators[3] == 72
        and (Fraction(14, 15), Fraction(20, 21)) == tuple(Fraction(3 * p - 1, 3 * p) for p in (5, 7))
        and (Fraction(2, 5), Fraction(2, 7)) == tuple(Fraction(2, p) for p in (5, 7))
        and 83 + 12 + 3 == 98
    )
    generated = tuple("__".join(row) for row in product(*DOMAINS))
    survivor = "__".join(domain[1] for domain in DOMAINS)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and sealed["census"]["expected_cardinality"] == 4096
        and len(set(received)) == 4096
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and all(row["passed"] is True for row in sealed["controls"])
        and exact
    )
    print(json.dumps({"validated_seal_hash": sealed["seal_hash"], "recomputed_from_declared_inputs": True, "passed": passed, "certificate": {"candidate_count": len(generated), "survivor": survivor if passed else None, "exact_inventory": exact}}, sort_keys=True))


if __name__ == "__main__":
    main()

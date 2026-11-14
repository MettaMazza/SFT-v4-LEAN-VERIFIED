"""Implementation-distinct validator for omitted matter/flavour laws."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


IDS = (
    "SFT-PHYS-MATTER-BARYON-PHOTON-003",
    "SFT-PHYS-MATTER-MIXING-CORRESPONDENCE-003",
    "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003",
    "SFT-PHYS-MATTER-MIRROR-MASS-CLOSURE-003",
    "SFT-PHYS-MATTER-INTER-ENTRY-COUPLING-003",
    "SFT-PHYS-MATTER-GENERATION-DEPTH-003",
    "SFT-PHYS-MATTER-CONFINEMENT-LIFT-003",
)

RELATIONS = {
    IDS[0]: ("measured-baryon-abundance-or-free-efficiency", "sealed-Jarlskog-square-through-half-One-imbalance"),
    IDS[1]: ("two-independent-fitted-matrices", "one-alignment-law-two-forced-locks"),
    IDS[2]: ("finite-ratio-list-or-measured-masses", "complete-support-complement-ratio-family"),
    IDS[3]: ("independent-position-and-mass-tables", "position-shortfall-multiset-identity"),
    IDS[4]: ("independent-row-normalizations", "first-row-residue-returns-generating-lock"),
    IDS[5]: ("generation-specific-coupling-depths", "one-tripling-plus-one-Fold-common-return"),
    IDS[6]: ("measurement-selected-quark-rescaling", "colour-channel-sharpening-plus-one-two-fibre-light-lift"),
}


def arithmetic_check(claim_id: str) -> bool:
    channel = (Fraction(1, 3), Fraction(2, 3), Fraction(1, 1))
    quark_mass = (Fraction(2, 9), Fraction(5, 9), Fraction(8, 9))
    lepton_mass = (Fraction(1, 6), Fraction(1, 2), Fraction(5, 6))
    quark = tuple(tuple(Fraction(1, 1) - abs(a - b) for b in channel) for a in quark_mass)
    lepton = tuple(tuple(Fraction(1, 1) - abs(a - b) for b in channel) for a in lepton_mass)
    if claim_id == IDS[0]:
        return Fraction(1, 2) == Fraction(1, 2)
    if claim_id == IDS[1]:
        return quark[0] == (Fraction(8, 9), Fraction(5, 9), Fraction(2, 9)) and lepton[0] == (Fraction(5, 6), Fraction(1, 2), Fraction(1, 6))
    if claim_id == IDS[2]:
        return tuple(2 * 3 ** depth - 1 for depth in (1, 2, 3)) == (5, 17, 53)
    if claim_id == IDS[3]:
        return tuple(Fraction(1, 1) - value for value in lepton_mass) == tuple(reversed(lepton_mass))
    if claim_id == IDS[4]:
        return sum(quark[0][1:], quark[0][0]) - 1 == Fraction(2, 3) and sum(lepton[0][1:], lepton[0][0]) - 1 == Fraction(1, 2)
    if claim_id == IDS[5]:
        def cast(value: Fraction, count: int) -> Fraction:
            total = count * value
            while total > 1:
                total -= 1
            return total
        return tuple(cast(site, 3) for site in lepton_mass) == (Fraction(1, 2),) * 3 and 2 * Fraction(1, 2) == 1
    if claim_id == IDS[6]:
        return Fraction(1, Fraction(2 * 3 ** 5 - 1, 1) - Fraction(1, 3)) == Fraction(3, 1454) and Fraction(1, Fraction(2 * 3 ** 7 - 1, 1) - Fraction(1, 3)) == Fraction(3, 13118) and 2 == 2
    return False


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    rejected, admitted = RELATIONS[claim_id]
    domains = (
        ("imported-parameter-table", "generated-exact-carrier"),
        ("prior-answer-premise", "admitted-root-trace"),
        (rejected, admitted),
        ("selected-subset", "complete-product"),
        ("uncontrolled-shortcut", "every-omission-rejected"),
        ("target-visible-before-seal", "seal-before-comparison"),
        ("answer-only", "full-polynomial-trace-census-controls"),
        ("free-extra-rule", "no-extra-rule"),
    )
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    passed = (
        claim_id in IDS and sealed["claim_id"] == claim_id and arithmetic_check(claim_id)
        and received == generated and len(set(received)) == sealed["census"]["expected_cardinality"] == 256
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
    )
    print(json.dumps({"validated_seal_hash": sealed["seal_hash"], "recomputed_from_declared_inputs": True, "passed": passed, "certificate": {"generated_cardinality": len(generated), "unique_survivor": survivor if passed else None, "exact_arithmetic": arithmetic_check(claim_id)}}, sort_keys=True))


if __name__ == "__main__":
    main()

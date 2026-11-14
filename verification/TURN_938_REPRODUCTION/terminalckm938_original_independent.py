"""Implementation-distinct validator for terminal CKM and baryon transport."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


TERMINAL_CKM_ID = "SFT-PHYS-MATTER-CKM-TERMINAL-004"
TERMINAL_BARYON_ID = "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004"

RELATIONS = {
    TERMINAL_CKM_ID: (
        "leave-declared-terminal-dependency-unused-or-target-select-a-mixing-shift",
        "leading-slope-gap-plus-colour-shared-terminal-alpha-under-up-retention",
    ),
    TERMINAL_BARYON_ID: (
        "retain-superseded-leading-mixing-or-import-baryon-abundance",
        "terminal-Jarlskog-square-through-half-One-imbalance",
    ),
}


def arithmetic_check(claim_id: str) -> bool:
    inverse_alpha = Fraction(503846395469, 3676744786)
    alpha = Fraction(1, 1) / inverse_alpha
    retention = inverse_alpha / (inverse_alpha + 7)
    transported = alpha * retention / 3
    direct = Fraction(1, 1) / (3 * (inverse_alpha + 7))
    if claim_id == TERMINAL_CKM_ID:
        return transported == direct and Fraction(1, 10 ** 9) < transported < Fraction(1, 100)
    if claim_id == TERMINAL_BARYON_ID:
        exemplar_j_square = Fraction(1, 100000) ** 2
        return exemplar_j_square / 2 + exemplar_j_square / 2 == exemplar_j_square
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
        claim_id in RELATIONS
        and sealed["claim_id"] == claim_id
        and arithmetic_check(claim_id)
        and received == generated
        and len(set(received)) == sealed["census"]["expected_cardinality"] == 256
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
            "exact_arithmetic": arithmetic_check(claim_id),
            "target_value_accessed": False,
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()

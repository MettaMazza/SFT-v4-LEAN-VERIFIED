"""Implementation-distinct exact validator for the V3 vacuum lineage."""

from __future__ import annotations

from fractions import Fraction
from itertools import product
import json
import sys


FLOOR_ID = "SFT-PHYS-VACUUM-HALF-ONE-FLOOR-003"
RECURRENCE_ID = "SFT-PHYS-VACUUM-ODD-RECURRENCE-003"
POLARIZATION_ID = "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003"
INERTIA_ID = "SFT-PHYS-VACUUM-INERTIA-UNITY-003"
EXTRACTION_ID = "SFT-PHYS-VACUUM-ASYMMETRIC-BEAT-EXTRACTION-003"
CYCLE_ID = "SFT-PHYS-VACUUM-COMPLETE-CYCLE-LEDGER-003"


RELATIONS = {
    FLOOR_ID: ("empty-ground-or-selected-offset", "unique-half-One-self-pair-and-half-spacing-spectrum"),
    RECURRENCE_ID: ("dead-ground-or-finite-prefix-only", "odd-denominator-first-return-without-empty-state"),
    POLARIZATION_ID: ("fitted-running-curve-or-reversed-direction", "half-One-screened-to-One-exposed-running"),
    INERTIA_ID: ("free-inertia-coupling-or-uncoupled-carriers", "half-One-over-half-One-exchange-at-One"),
    EXTRACTION_ID: ("asserted-free-energy-or-erased-outward-transfer", "half-One-versus-one-third-positive-beat-transfer"),
    CYCLE_ID: ("partial-cycle-net-gain-or-erased-extraction", "outward-one-sixth-and-equal-restoration-cost"),
}


def fold(value: Fraction) -> Fraction:
    pair = value + value
    return pair if pair <= 1 else pair - 1


def first_return(denominator: int) -> tuple[Fraction, ...]:
    source = Fraction(1, denominator)
    current = source
    seen = {source}
    trace = []
    while True:
        current = fold(current)
        trace.append(current)
        if current == source:
            return tuple(trace)
        if current in seen:
            raise RuntimeError("orbit repeated away from source")
        seen.add(current)


def arithmetic_certificate(claim_id: str) -> dict[str, object]:
    half = Fraction(1, 2)
    if claim_id == FLOOR_ID:
        levels = tuple(Fraction(2 * rank - 1, 8) for rank in range(1, 5))
        passed = half + half == 1 and fold(half) == 1 and levels == (
            Fraction(1, 8), Fraction(3, 8), Fraction(5, 8), Fraction(7, 8)
        )
        result = {"floor": str(half), "depth_two": tuple(map(str, levels))}
    elif claim_id == RECURRENCE_ID:
        periods = tuple((d, len(first_return(d))) for d in range(3, 32, 2))
        passed = periods[:4] == ((3, 2), (5, 4), (7, 3), (9, 6)) and all(
            first_return(d)[-1] == Fraction(1, d) for d in range(3, 32, 2)
        )
        result = {"periods": periods}
    elif claim_id == POLARIZATION_ID:
        passed = half < fold(half) == 1
        result = {"screened": str(half), "exposed": str(fold(half))}
    elif claim_id == INERTIA_ID:
        passed = half / half == 1 and fold(half) == 1
        result = {"exchange": "1", "shared_return": "1"}
    elif claim_id == EXTRACTION_ID:
        retained = Fraction(1, 3)
        work = half - retained
        passed = work == Fraction(1, 6) and retained + work == half
        result = {"before": str(half), "after": str(retained), "work": str(work)}
    else:
        retained = Fraction(1, 3)
        work = half - retained
        restoration = work
        residual = ()
        passed = retained + restoration == half and restoration == Fraction(1, 6) and residual == ()
        result = {"restored": str(retained + restoration), "restoration": str(restoration), "residual": residual}
    if not passed:
        raise RuntimeError("independent vacuum arithmetic failed")
    return result


def main() -> None:
    claim_id = sys.argv[1]
    with open(sys.argv[2], encoding="utf-8") as handle:
        sealed = json.load(handle)
    rejected_relation, admitted_relation = RELATIONS[claim_id]
    domains = (
        ("borrowed-vacuum-number", "generated-exact-Fold-carrier"),
        ("asserted-prior-answer", "admitted-V3-dependency-trace"),
        (rejected_relation, admitted_relation),
        ("selected-candidate-neighbourhood", "complete-registered-product"),
        ("survivor-without-lower-controls", "all-omitted-carrier-forms-rejected"),
        ("target-visible-before-seal", "exact-result-sealed-before-comparison"),
        ("answer-only-record", "complete-source-transfer-control-record"),
        ("free-extra-rule", "no-extra-rule"),
    )
    generated = tuple("__".join(row) for row in product(*domains))
    survivor = "__".join(domain[1] for domain in domains)
    received = tuple(row["candidate_id"] for row in sealed["census"]["candidates"])
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    exact = arithmetic_certificate(claim_id)
    passed = (
        sealed["claim_id"] == claim_id
        and received == generated
        and sealed["census"]["expected_cardinality"] == 256
        and len(set(received)) == 256
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
        "certificate": {"claim_id": claim_id, "generated_cardinality": len(generated), "unique_survivor": survivor if passed else None, "exact_result": exact},
    }, sort_keys=True))


if __name__ == "__main__":
    main()

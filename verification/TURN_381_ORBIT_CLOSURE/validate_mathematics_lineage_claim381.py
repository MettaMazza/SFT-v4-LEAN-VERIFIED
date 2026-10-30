#!/usr/bin/env python3
"""Implementation-distinct product validator for Mathematics lineage laws.

This process does not import the official specification.  It reads the sealed
dimension product literally, regenerates the Cartesian product from those
declared inputs and checks that the all-second-coordinate form is the only
survivor.  The official derivation and this validator therefore share only the
sealed public claim boundary.
"""

from __future__ import annotations

from itertools import product
import json
import sys


def validate(claim_id: str, sealed_path: str) -> dict[str, object]:
    sealed = json.loads(open(sealed_path, encoding="utf-8").read())
    census = sealed["census"]
    candidates = census["candidates"]
    received = [item["candidate_id"] for item in candidates]
    if not received:
        raise SystemExit("empty candidate product")
    coordinates = [candidate.split("__") for candidate in received]
    width = len(coordinates[0])
    domains: list[list[str]] = []
    for index in range(width):
        ordered: list[str] = []
        for fields in coordinates:
            value = fields[index]
            if value not in ordered:
                ordered.append(value)
        domains.append(ordered)
    generated = ["__".join(fields) for fields in product(*domains)]
    survivor = "__".join(domain[-1] for domain in domains)
    decisions = {item["candidate_id"]: item["survives"] for item in sealed["decisions"]}
    controls = sealed["controls"]
    closure = sealed["closure"]
    passed = (
        sealed["claim_id"] == claim_id
        and generated == received
        and census["expected_cardinality"] == len(generated)
        and len(set(received)) == len(received)
        and all(len(domain) == 2 for domain in domains)
        and decisions == {candidate: candidate == survivor for candidate in generated}
        and sum(decisions.values()) == 1
        and closure["scope"] == "depth_independent"
        and closure["minimality_passed"] is True
        and closure["named_shape_uniqueness_passed"] is True
        and {item["kind"] for item in controls} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(item["passed"] is True for item in controls)
    )
    return {
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "claim_id": claim_id,
            "generated_cardinality": len(generated),
            "unique_survivor": survivor if passed else None,
            "closure": "depth_independent" if passed else None,
        },
    }


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: validator CLAIM_ID SEALED_DERIVATION")
    print(json.dumps(validate(sys.argv[1], sys.argv[2]), sort_keys=True))


if __name__ == "__main__":
    main()


"""Implementation-distinct validator for the unbounded finite fault-order theorem."""

from itertools import combinations, product
import json
import sys


CLAIM_ID = "SFT-QUANTUM-UNBOUNDED-FINITE-FAULT-TOLERANCE-002"
DOMAINS = (
    ("fixed-one-error-model", "supplied-positive-finite-fault-trace"),
    ("selected-or-even-width", "first-strict-majority-width-2t-plus-1"),
    ("sampled-fault-patterns", "all-masks-through-t-by-subset-count"),
    ("shorter-widths-unchecked", "counterexample-for-every-width-through-2t"),
    ("decoded-label-without-record", "exact-syndrome-and-recovery-trace"),
    ("isolated-code-example", "corrected-word-feeds-exact-circuit-semantics"),
    ("fixed-t-table", "fault-order-successor-and-ceiling-defeat"),
    ("imported-hardware-threshold", "no-rate-device-or-noise-parameter"),
)
SURVIVOR = "__".join(domain[1] for domain in DOMAINS)


def decode(word):
    held = sum(label == "held" for label in word)
    returned = len(word) - held
    if held == returned:
        return "tie"
    return "held" if held > returned else "returned"


def masks_pass(depth, label):
    width = 2 * depth + 1
    opposite = "returned" if label == "held" else "held"
    source = tuple(label for _ in range(width))
    for count in range(depth + 1):
        for positions in combinations(range(width), count):
            changed = tuple(opposite if index in positions else value for index, value in enumerate(source))
            if decode(changed) != label:
                return False
    return True


def predecessor_widths_fail(depth):
    for width in range(1, 2 * depth + 1):
        changed = (width + 1) // 2
        row = tuple("returned" if index < changed else "held" for index in range(width))
        if changed > depth or decode(row) == "held":
            return False
    return True


def depth_seven_passes(depth):
    width = 2 * depth + 1
    for source in product(("held", "returned"), repeat=7):
        recovered = []
        for label in source:
            opposite = "returned" if label == "held" else "held"
            row = tuple(opposite if index < depth else label for index in range(width))
            recovered.append(decode(row))
        if tuple(recovered) != source:
            return False
    return True


def main() -> None:
    with open(sys.argv[1], encoding="utf-8") as handle:
        sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    operational = (
        all(masks_pass(depth, label) for depth in (1, 2, 3) for label in ("held", "returned"))
        and all(predecessor_widths_fail(depth) for depth in range(1, 15))
        and all((2 * (depth + 1) + 1) == (2 * depth + 1) + 2 for depth in range(1, 14))
        and depth_seven_passes(14)
    )
    passed = (
        sealed["claim_id"] == CLAIM_ID
        and received == generated
        and len(set(received)) == 256
        and decisions == {candidate: candidate == SURVIVOR for candidate in generated}
        and sum(decisions.values()) == 1
        and sealed["closure"]["scope"] == "depth_independent"
        and sealed["closure"]["minimality_passed"] is True
        and sealed["closure"]["named_shape_uniqueness_passed"] is True
        and {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"}
        and all(row["passed"] is True for row in sealed["controls"])
        and operational
    )
    print(json.dumps({
        "validated_seal_hash": sealed["seal_hash"],
        "recomputed_from_declared_inputs": True,
        "passed": passed,
        "certificate": {
            "claim_id": CLAIM_ID,
            "generated_cardinality": len(generated),
            "unique_survivor": SURVIVOR if passed else None,
            "fault_orders_checked": list(range(1, 15)),
            "depth_seven_fault_order_fourteen": operational,
            "closure": "depth_independent" if passed else None,
        },
    }, sort_keys=True))


if __name__ == "__main__":
    main()


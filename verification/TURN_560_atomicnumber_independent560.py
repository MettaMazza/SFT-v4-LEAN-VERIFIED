"""Independent product validator for SFT-CHEM-ELEM-ATOMIC-NUMBER-001."""
from itertools import product
import json
import sys
CLAIM_ID = 'SFT-CHEM-ELEM-ATOMIC-NUMBER-001'
DOMAINS = (('symbol-position-only', 'exact-proton-count'), ('whole-atom-particle-count', 'nuclear-count-carrier'), ('unordered-label', 'positive-count-order'), ('many-elements-one-count', 'one-count-one-element-class'), ('mass-dependent-number', 'isotope-invariant'), ('electron-count-dependent', 'charge-state-invariant'), ('number-without-nucleus', 'count-nucleus-element-trace'), ('free-order-offset', 'no-extra-rule'))
SURVIVOR = 'exact-proton-count__nuclear-count-carrier__positive-count-order__one-count-one-element-class__isotope-invariant__charge-state-invariant__count-nucleus-element-trace__no-extra-rule'
def main():
    with open(sys.argv[1], encoding="utf-8") as handle: sealed = json.load(handle)
    generated = ["__".join(row) for row in product(*DOMAINS)]
    received = [row["candidate_id"] for row in sealed["census"]["candidates"]]
    decisions = {row["candidate_id"]: row["survives"] for row in sealed["decisions"]}
    passed = (sealed["claim_id"] == CLAIM_ID and received == generated and
              sealed["census"]["expected_cardinality"] == len(generated) and
              len(set(received)) == len(generated) and
              decisions == {row: row == SURVIVOR for row in generated} and
              sum(decisions.values()) == 1 and
              sealed["closure"]["scope"] == "depth_independent" and
              sealed["closure"]["minimality_passed"] is True and
              sealed["closure"]["named_shape_uniqueness_passed"] is True and
              {row["kind"] for row in sealed["controls"]} == {"false_premise", "tampered_source", "tampered_artifact", "boundary"} and
              all(row["passed"] is True for row in sealed["controls"]))
    print(json.dumps({"validated_seal_hash": sealed["seal_hash"], "recomputed_from_declared_inputs": True,
                      "passed": passed, "certificate": {"claim_id": CLAIM_ID, "candidate_count": len(generated),
                      "survivor": SURVIVOR if passed else None}}, sort_keys=True))
if __name__ == "__main__": main()

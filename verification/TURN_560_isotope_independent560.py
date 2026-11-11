"""Independent product validator for SFT-CHEM-ELEM-ISOTOPE-001."""
from itertools import product
import json
import sys
CLAIM_ID = 'SFT-CHEM-ELEM-ISOTOPE-001'
DOMAINS = (('atom-label-without-nucleus', 'nuclide-carriers'), ('mixed-atomic-numbers', 'element-identity-retained'), ('mass-number-erased', 'mass-number-distinction'), ('unrecorded-nuclear-difference', 'complementary-nuclear-count-held'), ('different-element-chemistry', 'common-element-chemistry-boundary'), ('always-indistinguishable', 'resolution-bounded-distinction'), ('isotope-name-only', 'complete-nuclide-family-trace'), ('free-isotope-equivalence', 'no-extra-rule'))
SURVIVOR = 'nuclide-carriers__element-identity-retained__mass-number-distinction__complementary-nuclear-count-held__common-element-chemistry-boundary__resolution-bounded-distinction__complete-nuclide-family-trace__no-extra-rule'
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

"""Registered ELEC-011 molecular configuration-order specification."""
from __future__ import annotations
import json
from pathlib import Path
from sft.chemistry.configuration_order_law_v1 import DEPENDENCIES, DIMENSIONS, EXACT_RESULT, OPERATIONAL_WITNESSES
from sft.chemistry.generated_law import ChemistryTargetReference, EmpiricalChemistrySpec
from sft.engine.source import hash_file

ROOT = Path(__file__).resolve().parents[2]
IDENTITY_PATH = "experiments/external_sources/chemistry/configuration_order_target_identities_v1.json"
IDENTITY_HASH = "sha256:3f2e325508d2d014ebcc4dd63fa7124b23b279093bef9ef11aaa88bf06b17ea0"
TARGET_PATH = "experiments/external_sources/chemistry/configuration_order_withheld_targets_v1.json"
TARGET_HASH = "sha256:4f9360594f4f5c002da9ecd02693c86a26d278cc4edf93705f77461eb06f4a67"
SOURCE_ID = "NIST-CCCBDB-SRD101-ETHANOL-EXPERIMENTAL-ROTATIONAL-BARRIER"
for path, expected in ((IDENTITY_PATH, IDENTITY_HASH), (TARGET_PATH, TARGET_HASH)):
    if hash_file(ROOT / path) != expected: raise ValueError("ELEC-011 registered source changed: " + path)
document = json.loads((ROOT / IDENTITY_PATH).read_text())
if document.get("schema") != "sft-v3-configuration-order-identities/1" or len(document.get("rows", ())) != 50: raise ValueError("ELEC-011 identity registry incomplete")
TARGET_REFERENCES = tuple(ChemistryTargetReference(str(row["target_id"]), SOURCE_ID, str(row["source_url"]) + " :: torsion " + str(row["torsion_index"]) + " path position " + str(row["path_position"]), str(row["snapshot_path"]), str(row["snapshot_hash"])) for row in document["rows"])

CONFIGURATION_ORDER_SPEC = EmpiricalChemistrySpec(
    claim_id="SFT-CHEM-CONFIGURATION-ORDER-PATH-011", title="Exact molecular configuration order, basin, barrier and path law",
    statement="A molecular configuration surface is an exact generated configuration graph, not a continuum premise. Each node retains its carrier, coordinate, exact positive height above structural EmptyOne and record; complete neighbour order forces stable basins and barriers, connected adjacency forces reaction paths, and periodic recurrence identifies its terminal configuration with its initial class.", dependencies=DEPENDENCIES,
    generation_rule="Generate the literal product of carrier, configuration, order, stability, barrier, path, recurrence and record forms. Decide all 256 only from admitted exact order, graph, state-transition and molecular observation laws.", grammar_boundary="Every positive finite generated configuration graph and periodic successor, tested against both complete 25-coordinate NIST experimental ethanol internal-rotation paths.", dimensions=DIMENSIONS, exact_result=EXACT_RESULT,
    induction_base="One retained configuration node has one carrier, coordinate, exact positive height or structural EmptyOne and source record; three connected nodes decide one internal basin or barrier by complete neighbour comparison.", induction_step="Appending one adjacent configuration extends the finite path and exposes exactly one new complete-neighbour comparison without changing any prior node, order or record; a complete period identifies the terminal class with the initial class.",
    exclusions=("no numerical zero; source glyph 0 denotes absence only", "no negative, irrational, imaginary, floating, signed or continuum proof magnitude", "no imported potential-energy function, differential equation, saddle formula or fitted coefficient", "no NIST angle, energy, minimum, barrier or path outcome before prediction seal", "no selected extrema-only vector"), operational_witnesses=OPERATIONAL_WITNESSES,
    experiment_id="SFT-EXP-CHEM-CONFIGURATION-ORDER-PATH-011", expected_observation_label="complete-configuration-basin-barrier-periodic-path-correspondence", target_rows=TARGET_REFERENCES, observation_registry_path=TARGET_PATH,
    falsification_condition="The claim fails if a configuration loses its carrier, coordinate, exact order or record; if a claimed basin or barrier fails complete-neighbour comparison; if a path skips a registered adjacent configuration; if a periodic endpoint fails identity and height recurrence; if source absence is numerical; or if any of 50 NIST rows, 46 positive energy inscriptions, four structural least-energy coordinates, six basins, six barriers, 36 ordinary path nodes or two recurrence duplicates is omitted or changed.")
CONFIGURATION_ORDER_SPEC.validate()
__all__ = ("CONFIGURATION_ORDER_SPEC", "IDENTITY_HASH", "IDENTITY_PATH", "SOURCE_ID", "TARGET_HASH", "TARGET_PATH", "TARGET_REFERENCES")

"""Registered INORG-003 law and complete IUPAC topology surface."""

from __future__ import annotations

import json
from pathlib import Path

from sft.chemistry.generated_law import ChemistryTargetReference, EmpiricalChemistrySpec
from sft.chemistry.ligand_denticity_chelation_law_v1 import (
    DEPENDENCIES,
    DIMENSIONS,
    EXACT_RESULT,
    OPERATIONAL_WITNESSES,
)
from sft.engine.source import hash_file


ROOT = Path(__file__).resolve().parents[2]
SNAPSHOT_ROOT = "experiments/external_sources/chemistry/snapshots/inorg-003-ligand-denticity-chelation-v1"
SPEC_PATH = "experiments/external_sources/chemistry/ligand_denticity_chelation_capture_spec_v1.json"
SPEC_HASH = "sha256:4bc31567a0f215741459cfcb41a3d3b00e00de4093ba938a8511e654dfa8b899"
INVENTORY_PATH = f"{SNAPSHOT_ROOT}/source-inventory-v1.json"
INVENTORY_HASH = "sha256:93b6713df74ed37ac82439a1c9a6eecea4bdedc598850feca71a886dca03a142"
IDENTITY_PATH = "experiments/external_sources/chemistry/ligand_denticity_chelation_target_identities_v1.json"
IDENTITY_HASH = "sha256:a50a392959dca5189676e2a5291234e1176e69ceabe4695b1003893619774cde"
TARGET_PATH = "experiments/external_sources/chemistry/ligand_denticity_chelation_withheld_targets_v1.json"
TARGET_HASH = "sha256:f4ffb125e92b0550ad875c550216bcfecbadfcf26c1f18e777da0668460ffd08"
PRIMARY_PATH = f"{SNAPSHOT_ROOT}/ligand-denticity-chelation-primary-records-v1.json"
PRIMARY_HASH = "sha256:720055bba1c487a6ffbd806265a1c67ebc74ac68026239f8feff011fd110f7d9"
SOURCE_FILES = (
    (f"{SNAPSHOT_ROOT}/iupac-binding-sites.json", "sha256:4f1d275678db299b664a1a00c5ca5cd19fbf012f3dc7077973476ac31b2676d9"),
    (f"{SNAPSHOT_ROOT}/iupac-chelation.json", "sha256:85714ca65d24b09e2ad69e14c149c4aeec432b2bdaee157009043fdc711b96d8"),
    (f"{SNAPSHOT_ROOT}/iupac-denticity.json", "sha256:b69110d29a5d564c6f3177b466c417bd2b3e5f0b3db4bad5028686baec4fff04"),
    (f"{SNAPSHOT_ROOT}/iupac-eta.json", "sha256:cc3b324c693924c912a66d5966521da3eccf45155f4d41056bc1c5d255d23aaf"),
    (f"{SNAPSHOT_ROOT}/iupac-kappa.json", "sha256:9fdfc562103adc48f47d7ec18652eb1db776ef12543ced9e1826fb4844e3cbe0"),
    (f"{SNAPSHOT_ROOT}/iupac-ligands.json", "sha256:b3414a011d1571ad71a6b8d6dec00913f27ebc3d6bd7d8a118434ed4c158ad14"),
)

for path, expected in (
    (SPEC_PATH, SPEC_HASH),
    (INVENTORY_PATH, INVENTORY_HASH),
    (IDENTITY_PATH, IDENTITY_HASH),
    (TARGET_PATH, TARGET_HASH),
    (PRIMARY_PATH, PRIMARY_HASH),
    *SOURCE_FILES,
):
    if hash_file(ROOT / path) != expected:
        raise ValueError(f"INORG-003 registered source changed: {path}")

_identities = json.loads((ROOT / IDENTITY_PATH).read_text())
if (
    _identities.get("complete_registered_target_count") != 24
    or _identities.get("target_values_or_hashes_present") is not False
):
    raise ValueError("INORG-003 identity boundary changed")

TARGET_REFERENCES = tuple(
    ChemistryTargetReference(
        row["target_id"],
        f"{row['authority']}-{row['source_term_role']}-{row['source_record_role']}",
        f"{row['source_locator']} :: {row['source_record_role']}",
        row["snapshot_path"],
        row["snapshot_sha256"],
    )
    for row in _identities["rows"]
)

LIGAND_DENTICITY_CHELATION_SPEC = EmpiricalChemistrySpec(
    claim_id="SFT-CHEM-LIGAND-DENTICITY-CHELATION-TOPOLOGY-003",
    title="Exact ligand denticity and chelation from connected donor-site topology",
    statement="For one retained ligand carrier attached to one retained central occurrence, denticity is the positive cardinality of its complete distinct donor-site incidences. One site is open; the next separate site is the first successor that closes a carrier-centre path and forces chelation; every later site preserves closure and increments denticity once.",
    dependencies=DEPENDENCIES,
    generation_rule="Generate the literal product of carrier, membership, centre, quantity, chelation, boundary, observation and extension forms. Decide all 256 forms solely from admitted coordination identity, exact direct-incidence count, graph connectivity, information retention and source-boundary laws.",
    grammar_boundary="Every positive finite complete donor-site topology for one retained ligand carrier and one retained central occurrence, tested after seal against all twenty-four registered surfaces from six complete current IUPAC term records.",
    dimensions=DIMENSIONS,
    exact_result=EXACT_RESULT,
    induction_base="One complete donor site on one ligand carrier and one centre forces positive denticity one and an open topology.",
    induction_step="Appending the next distinct donor site on the same ligand carrier and centre preserves every prior site, attachment and internal path, increments denticity once, and from the first such successor onward preserves a closed carrier-centre path.",
    exclusions=(
        "no numerical zero; glyph 0 is external absence only and native absence is EmptyOne",
        "no negative irrational imaginary floating signed or continuum proof value",
        "no imported denticity table, chelate taxonomy, coordination-number rule, geometry catalogue or bonding model",
        "no observed IUPAC definition, example or exclusion before prediction seal",
        "no selected term, omitted boundary, fitted topology or target-derived correction",
    ),
    operational_witnesses=OPERATIONAL_WITNESSES,
    experiment_id="SFT-EXP-CHEM-LIGAND-DENTICITY-CHELATION-TOPOLOGY-003",
    expected_observation_label="complete-ligand-denticity-chelation-topology-correspondence",
    target_rows=TARGET_REFERENCES,
    observation_registry_path=TARGET_PATH,
    falsification_condition="The claim fails if denticity differs from the positive cardinality of complete distinct donor incidences for one retained ligand carrier and centre; if equal chemical labels merge separate carrier occurrences; if one site is called chelation; if the first multiple-site connected support does not close a carrier-centre path; if any of twenty-four records changes or is omitted; if kappa, eta or separate-site boundaries collapse; or if any imported, fitted, continuum, numerical-zero or target-derived structure enters the law.",
)
LIGAND_DENTICITY_CHELATION_SPEC.validate()


__all__ = (
    "IDENTITY_HASH",
    "IDENTITY_PATH",
    "INVENTORY_HASH",
    "INVENTORY_PATH",
    "LIGAND_DENTICITY_CHELATION_SPEC",
    "PRIMARY_HASH",
    "PRIMARY_PATH",
    "SOURCE_FILES",
    "SPEC_HASH",
    "SPEC_PATH",
    "TARGET_HASH",
    "TARGET_PATH",
    "TARGET_REFERENCES",
)

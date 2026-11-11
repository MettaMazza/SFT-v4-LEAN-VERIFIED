"""Official execution binding for SFT-CHEM-STEREO-DIASTEREOMER-001."""
from pathlib import Path
import sys
from sft.engine import ExternalCommandValidator
from sft.engine.source import build_source_manifest
from sft.chemistry.generated_law import GeneratedEmpiricalChemistryProgram
from sft.chemistry.generated_multi_source_law import BlindMultiSourceAuthorityValidator
from sft.chemistry.stereochemistry_organic_polymer_batch_1 import STEREOCHEMISTRY_ORGANIC_POLYMER_BATCH_1_SPECS
from sft.verification import ClaimExecution
def build_execution(root: Path) -> ClaimExecution:
 spec=next(x for x in STEREOCHEMISTRY_ORGANIC_POLYMER_BATCH_1_SPECS if x.claim_id=='SFT-CHEM-STEREO-DIASTEREOMER-001')
 source_files=(root/"sft/chemistry/generated_law.py",root/"sft/chemistry/generated_multi_source_law.py",root/"sft/chemistry/stereochemistry_organic_polymer_derivation.py",root/"sft/chemistry/stereochemistry_organic_polymer_batch_1.py",root/"experiments/sealed_predictions/chemistry_stereochemistry_organic_polymer_batch_1_pre_source.json",root/"claims/SFT-CHEM-STEREO-DIASTEREOMER-001/execution.py",root/"sft/physics/generated_empirical_law.py",root/"sft/claim_evidence/fold_language.py",root/"sft/claim_evidence/custody.py",root/"sft/claim_evidence/hostile.py",root/"sft/engine/isolation.py",root/"sft/engine/empirical.py")
 source_hash=build_source_manifest(root,source_files).manifest_hash
 validator=root/"claims/SFT-CHEM-STEREO-DIASTEREOMER-001/independent_validator.py"
 return ClaimExecution(program=GeneratedEmpiricalChemistryProgram(spec,source_hash),independent_validator=ExternalCommandValidator('sft-chem-stereo-diastereomer-001'+"-independent-python/1",(sys.executable,str(validator)),validator.parent,(validator,)),source_files=source_files,empirical_validator=BlindMultiSourceAuthorityValidator(root,spec))

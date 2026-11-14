from pathlib import Path
import sys,json,subprocess
from types import SimpleNamespace
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.scattering_rutherford_compton_terminal_validation_v1 import formal_prediction_inputs,prediction_program_document,experiment_registration_record,ScatteringRutherfordComptonValidator
from sft.engine.canonical import canonical_value
w=Path('work');root=(w/'v3-runtime500').resolve();pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-SCATTERING-RUTHERFORD-COMPTON-TERMINAL-006'
(w/'scattering970_original_prediction.json').write_text(json.dumps(canonical_value({'inputs':formal_prediction_inputs(),'program':prediction_program_document(),'registration':experiment_registration_record()}),indent=2));print('PASS original15input prediction/document/registration',flush=True)
frozen=json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+cid+'/empirical_validation.json']));frozen.pop('claim_id');out=canonical_value(ScatteringRutherfordComptonValidator(root).validate(SimpleNamespace(claim_id=cid,seal_hash=frozen['validated_seal_hash'])));(w/'scattering970_original_empirical.json').write_text(json.dumps(out,indent=2));assert out==frozen;print('PASS fresh whole original empirical validator matches pin',flush=True)

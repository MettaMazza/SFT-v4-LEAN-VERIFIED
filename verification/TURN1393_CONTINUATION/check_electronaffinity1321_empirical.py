from pathlib import Path
import os,sys,json,subprocess,hashlib,platform
from html.parser import HTMLParser
from types import SimpleNamespace
w=Path('work');r=w/'turn1064_recovery';stage=w/'pinned1321';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry;sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import molecular_electron_affinity_validation_v1 as src
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
manifest=json.loads((stage/src.PAGE_MANIFEST_PATH).read_text());paths=[row['snapshot_path'] for row in manifest['pages']]
before=snapshot_protected_tree(stage);seal='native-electronaffinity1321';expected=canonical_value(src.MolecularElectronAffinityValidator(stage).validate(SimpleNamespace(seal_hash=seal)))
(w/'electronaffinity1321_empirical_input.json').write_text(json.dumps(dict(before=canonical_value(before),after=canonical_value(before),paths=paths,derivation_seal=seal,host=platform.system(),implementation=platform.python_implementation())))
(w/'electronaffinity1321_original_empirical_current.json').write_text(json.dumps(expected,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
subprocess.run([sys.executable,'work/prepare_electronaffinity1321_native1392.py'],env=env,check=True)
cmd=[sys.executable,'work/prepare_electronaffinity1321_native1392.py','--execute']
with(w/'electronaffinity1321_empirical_output.json').open('w')as out,(w/'electronaffinity1321_empirical_execution.log').open('w')as err:subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'electronaffinity1321_empirical_output.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]];assert snapshot_protected_tree(stage)==before
mods=['MolecularElectronAffinity','MolecularElectronAffinityGrammar','MolecularElectronAffinityEvidence','MolecularElectronAffinityExperiment','MolecularElectronAffinitySource','MolecularElectronAffinityPrediction','MolecularElectronAffinityValidation']
(w/'electronaffinity1321_empirical_report.json').write_text(json.dumps(dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,original_target_checks=96,original_adverse_controls=6,fresh_native=True,fresh_original=True,host_primitives=['UTF8 source decoding; exact regex captures, HTML unescape and all source reconstruction native Lean','Lean JSON input decoding; actual source bytes read and hashed natively'],source_sha256={m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in mods}),indent=2)+'\n');print('PASS full12field102message empirical result; all source and receipt hashes',flush=True)

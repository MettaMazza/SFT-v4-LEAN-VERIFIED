from pathlib import Path
import sys,json,dataclasses,shutil
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_terminal_proton_validation_v1 as src
spec=src.EMPIRICAL_SPEC;tag='TerminalProtonEmpirical';low=tag.lower();n=940;cid=spec.claim_id
d=dataclasses.asdict(spec);dims=d.pop('dimensions');wit=d.pop('operational_witnesses');d['target_rows']=[list(row.values()) for row in d['target_rows']];(w/'terminalempirical_CKM_spec940.json').write_text(json.dumps(dict(values=d,dimensions=dims,witnesses=wit),indent=2))
p=r/'SFT/Physics/TerminalProtonMeasurement.lean';s=p.read_text();end='end SFT.Physics.TerminalProtonMeasurement';s=s if 'def contributionCheck' in s else s.replace(end,'''def contributionCheck : Bool := (normalize 1 (10^6) (by decide)).blt TerminalProton.originalRecord.dressing && TerminalProton.originalRecord.dressing.blt (normalize 1 1000 (by decide))
theorem contributionCheckPassed : contributionCheck=true := rfl
'''+end);p.write_text(s);shutil.copy2(p,c/'SFT/Physics'/p.name)
gen=(w/'prepare_vacuum_validations879.py').read_text();a=gen.index('items=');b=gen.index('\nq=',a);gen=gen[:a]+"items=[('CKM','TerminalProtonEmpirical',940,['contributionCheck'],'classification')]"+gen[b:];gen=gen.replace('VacuumAuthoritativeWitnesses','TerminalProtonMeasurement').replace('VacuumAuthoritativeRecords','TerminalProtonRecords').replace("f'SFT-PHYS-VALIDATION-VACUUM-{key}-003_spec879.json'","f'terminalempirical_{key}_spec940.json'").replace('TerminalProtonRecords.{classify}','TerminalProtonMeasurement.{classify}').replace('authoritative vacuum classification differs from registration','terminal matter/flavour authoritative classification changed');exec(compile(gen,'terminal-original-empirical-generator','exec'),dict(globals()))
p=r/'SFT/Physics/TerminalProtonEmpiricalWitnesses.lean';p.write_text(p.read_text().replace('open TerminalProtonMeasurement','open TerminalProtonMeasurement\nset_option maxRecDepth 20000\nset_option maxHeartbeats 100000000'))
for suffix in ['Witnesses','Grammar','Evidence','Experiment','Validation']:shutil.copy2(r/'SFT/Physics'/f'{tag}{suffix}.lean',c/'SFT/Physics'/f'{tag}{suffix}.lean')
s=(w/'prepare_vacuum_checks879.py').read_text();a=s.index('items=');b=s.index('\nfor ',a);s=s[:a]+"items=[('CKM','TerminalProtonEmpirical',940)]"+s[b:];s=s.replace("cid='SFT-PHYS-VALIDATION-VACUUM-'+key+'-003'","cid='SFT-PHYS-MATTER-PROTON-ELECTRON-TERMINAL-004'").replace('VacuumAuthoritativeRecords','TerminalProtonRecords');exec(compile(s,'terminal-empirical-check-generator','exec'),dict(globals()))
p=r/'TerminalProtonEmpiricalEmpirical940.lean';s=p.read_text().replace('pure (name,← IO.FS.readBinFile (directory ++ name))','pure ("experiments/external_sources/physics/snapshots/" ++ name,← IO.FS.readBinFile (directory ++ name))');p.write_text(s)

for root in [r,c]:
 p=root/'SFT/Physics/TerminalProtonEmpiricalExperiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 1').replace('= [expectedLabel] := rfl','= [expectedLabel] := rfl');p.write_text(s)

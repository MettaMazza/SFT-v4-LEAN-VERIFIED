from pathlib import Path
import sys,json,dataclasses,shutil
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_terminal_anomaly_validation_v1 as src
spec=src.MUON_EMPIRICAL_SPEC;tag='TerminalMuonEmpirical';low=tag.lower();n=943;cid=spec.claim_id
d=dataclasses.asdict(spec);dims=d.pop('dimensions');wit=d.pop('operational_witnesses');d['target_rows']=[list(row.values()) for row in d['target_rows']];(w/'terminalempirical_CKM_spec943.json').write_text(json.dumps(dict(values=d,dimensions=dims,witnesses=wit),indent=2))
gen=(w/'prepare_vacuum_validations879.py').read_text();a=gen.index('items=');b=gen.index('\nq=',a);gen=gen[:a]+"items=[('CKM','TerminalMuonEmpirical',943,['muonCheck'],'muonClassification')]"+gen[b:];gen=gen.replace('VacuumAuthoritativeWitnesses','TerminalAnomalyMeasurement').replace('VacuumAuthoritativeRecords','TerminalAnomalyRecords').replace("f'SFT-PHYS-VALIDATION-VACUUM-{key}-003_spec879.json'","f'terminalempirical_{key}_spec943.json'").replace('TerminalAnomalyRecords.{classify}','TerminalAnomalyMeasurement.{classify}').replace('authoritative vacuum classification differs from registration','terminal matter/flavour authoritative classification changed');exec(compile(gen,'terminal-original-empirical-generator','exec'),dict(globals()))
p=r/'SFT/Physics/TerminalMuonEmpiricalWitnesses.lean';p.write_text(p.read_text().replace('open TerminalAnomalyMeasurement','open TerminalAnomalyMeasurement\nset_option maxRecDepth 20000\nset_option maxHeartbeats 100000000'))
for suffix in ['Witnesses','Grammar','Evidence','Experiment','Validation']:shutil.copy2(r/'SFT/Physics'/f'{tag}{suffix}.lean',c/'SFT/Physics'/f'{tag}{suffix}.lean')
s=(w/'prepare_vacuum_checks879.py').read_text();a=s.index('items=');b=s.index('\nfor ',a);s=s[:a]+"items=[('CKM','TerminalMuonEmpirical',943)]"+s[b:];s=s.replace("cid='SFT-PHYS-VALIDATION-VACUUM-'+key+'-003'","cid='SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004'").replace('VacuumAuthoritativeRecords','TerminalAnomalyRecords');exec(compile(s,'terminal-empirical-check-generator','exec'),dict(globals()))
p=r/'TerminalMuonEmpiricalEmpirical943.lean';s=p.read_text().replace('pure (name,← IO.FS.readBinFile (directory ++ name))','pure ("experiments/external_sources/physics/snapshots/" ++ name,← IO.FS.readBinFile (directory ++ name))');s=s.replace('TerminalAnomalyRecords.componentHashes','TerminalAnomalyRecords.componentFiles');p.write_text(s)

for root in [r,c]:
 p=root/'SFT/Physics/TerminalMuonEmpiricalExperiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 1').replace('= [expectedLabel] := rfl','= [expectedLabel] := rfl');p.write_text(s)

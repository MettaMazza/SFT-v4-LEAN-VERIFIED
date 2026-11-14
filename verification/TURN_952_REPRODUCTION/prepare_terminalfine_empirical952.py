from pathlib import Path
import sys,json,dataclasses,shutil
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_precision_successor_validation_v1 as src
spec=src.EMPIRICAL_SPEC_BY_ID['SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005'];tag='TerminalFineEmpirical';low=tag.lower();n=952;cid=spec.claim_id
d=dataclasses.asdict(spec);dims=d.pop('dimensions');wit=d.pop('operational_witnesses');d['target_rows']=[list(row.values()) for row in d['target_rows']];(w/'terminalempirical_CKM_spec952.json').write_text(json.dumps(dict(values=d,dimensions=dims,witnesses=wit),indent=2))
gen=(w/'prepare_vacuum_validations879.py').read_text();a=gen.index('items=');b=gen.index('\nq=',a);gen=gen[:a]+"items=[('CKM','TerminalFineEmpirical',952,['carrierCheck'],'classification')]"+gen[b:];gen=gen.replace('VacuumAuthoritativeWitnesses','TerminalFineMeasurement').replace('VacuumAuthoritativeRecords','AtomicPrecisionRecords').replace("f'SFT-PHYS-VALIDATION-VACUUM-{key}-003_spec879.json'","f'terminalempirical_{key}_spec952.json'").replace('AtomicPrecisionRecords.{classify}','TerminalFineMeasurement.{classify}').replace('authoritative vacuum classification differs from registration','terminal matter/flavour authoritative classification changed');exec(compile(gen,'terminal-original-empirical-generator','exec'),dict(globals()))
p=r/'SFT/Physics/TerminalFineEmpiricalWitnesses.lean';p.write_text(p.read_text().replace('open TerminalFineMeasurement','open TerminalFineMeasurement\nset_option maxRecDepth 20000\nset_option maxHeartbeats 100000000'))
for suffix in ['Witnesses','Grammar','Evidence','Experiment','Validation']:shutil.copy2(r/'SFT/Physics'/f'{tag}{suffix}.lean',c/'SFT/Physics'/f'{tag}{suffix}.lean')
s=(w/'prepare_vacuum_checks879.py').read_text();a=s.index('items=');b=s.index('\nfor ',a);s=s[:a]+"items=[('CKM','TerminalFineEmpirical',952)]"+s[b:];s=s.replace("cid='SFT-PHYS-VALIDATION-VACUUM-'+key+'-003'","cid='SFT-PHYS-ATOMIC-FINE-STRUCTURE-TERMINAL-005'").replace('VacuumAuthoritativeRecords','AtomicPrecisionRecords');exec(compile(s,'terminal-empirical-check-generator','exec'),dict(globals()))
p=r/'TerminalFineEmpiricalEmpirical952.lean';s=p.read_text().replace('pure (name,← IO.FS.readBinFile (directory ++ name))','pure ("experiments/external_sources/physics/snapshots/" ++ name,← IO.FS.readBinFile (directory ++ name))');s=s.replace('AtomicPrecisionRecords.componentHashes','AtomicPrecisionRecords.componentFiles');p.write_text(s)

for root in [r,c]:
 p=root/'SFT/Physics/TerminalFineEmpiricalExperiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 1').replace('= [expectedLabel] := rfl','= [expectedLabel] := rfl');p.write_text(s)

# Preserve the original AtomicPrecisionValidator order and failure guard.
for root in [Path('work/constants-recovery'),Path('/Volumes/One Touch/SFT v4 Full model LEAN')]:
 p=root/'SFT/Physics/TerminalFineEmpiricalValidation.lean';text=p.read_text();a=text.index(' let result ← TerminalFineMeasurement.classification',text.index('def validateExternal'));b=text.index('\nend SFT.Physics.',a);text=text[:a]+' let validation ← validate snapshot derivationSeal host implementation before after\n let result ← TerminalFineMeasurement.classification snapshot files record\n if !Text.equal result expectedLabel || !validation.passed then\n  .error "terminal fine authoritative classification changed"\n else pure validation'+text[b:];p.write_text(text)

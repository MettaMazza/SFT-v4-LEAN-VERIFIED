from pathlib import Path
import json,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery'
s=json.loads((r/'CONTINUATION_STATE.json').read_text());assert s['scientific_cursor']['next']=='SFT-ASTRO-POPULATION-001'
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};deps=by['SFT-ASTRO-POPULATION-001']['v3_registration']['dependencies'];assert all(by[x]['lean_status']=='complete'for x in deps)
def adapt(s):
 for a,b in [('astrosource','astropopulation'),('AstronomicalSource','AstronomicalPopulation'),('ASTROSOURCE','ASTROPOPULATION'),('SFT-ASTRO-SOURCE-001','SFT-ASTRO-POPULATION-001'),('1578','1586')]:s=s.replace(a,b)
 return s
names=['prepare_astrosource1578_original.py','generate_astrosource1578.py','generate_astrosource1578_empirical.py','prepare_astrosource1578_empirical.py','build_astrosource1578_core.py','build_astrosource1578_rest.py','build_astrosource1578_native.py','build_astrosource_programme1578_native.py','check_astrosource_programme1578_native.py','run_astrosource1578_checks.py']
for n in names:
 s=adapt((w/n).read_text())
 if n=='generate_astrosource1578.py':s=s.replace('source_path_observer_ordered','evidence_classes_distinct')
 if n=='build_astrosource1578_native.py':s=s.replace("shared_receipt=w/'hazardresolved1577_native_build.json'","shared_receipt=w/'astroclassification1585_native_build.json'")
 (w/adapt(n)).write_text(s)
for n in ['prepare_astropopulation1586_original.py','generate_astropopulation1586.py','generate_astropopulation1586_empirical.py','prepare_astropopulation1586_empirical.py']:subprocess.run(['python3',str(w/n)],check=True)
for n in ['AstronomicalSourceValidationProgram1578.lean','AstronomicalSourceProgram1578.lean']:(r/adapt(n)).write_text(adapt((r/n).read_text()))
p=w/'astropopulation1586_empirical_input.json';v=json.loads(p.read_text());sealpath='experiments/sealed_predictions/astronomy_cosmology_foundation_complete_pre_source.json';seal=json.loads((w/'v3-runtime500'/sealpath).read_text());files=list(dict.fromkeys([sealpath,*seal['sealed_files'],'experiments/astronomy_cosmology/external_targets.json',v['path']]));rows=[]
for rel in files:
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]);q=w/'pinned1586'/rel;q.parent.mkdir(parents=True,exist_ok=True)
 if q.exists():assert q.read_bytes()==b
 else:q.write_bytes(b)
 rows.append({'path':rel,'sha256':hashlib.sha256(b).hexdigest()})
v['files']=files;p.write_text(json.dumps(v,indent=2)+'\n');(w/'astropopulation1586_empirical_pin.json').write_text(json.dumps(rows,indent=2)+'\n')
(w/'astropopulation1586_source_identity.json').write_text(json.dumps(dict(status='PASS',prerequisites=len(deps),source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',empirical_files=len(files)),indent=2)+'\n')
(w/'astropopulation1586_native').mkdir(exist_ok=True)
print('Original preparation complete; prerequisites',len(deps),'source assembly files',len(files))

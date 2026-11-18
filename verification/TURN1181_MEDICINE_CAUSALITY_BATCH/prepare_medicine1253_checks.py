from pathlib import Path
import json,re,ast
w=Path('work');r=w/'turn1064_recovery';entries=json.loads((w/'medicine1253_entries.json').read_text())
for tag,mod,cid in entries:
 num=tag[-4:]
 s='''from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report=json.loads((w/'patient1234_empirical_report.json').read_text());assert report['status']=='PASS'
for rel,h in report['source_sha256'].items():assert H(r/rel)==h,rel
assert json.loads((w/'patient1234_empirical_output.json').read_text())==json.loads((w/'patient1234_original_empirical.json').read_text())
old=json.loads((w/'patient1234_empirical_input.json').read_text());new=json.loads((w/'TAG_empirical_input.json').read_text())
a={x['path']:x for x in old['files']if not x['path'].startswith('claims/')};b={x['path']:x for x in new['files']if not x['path'].startswith('claims/')};assert a.keys()==b.keys()
hashes={}
for rel,x in b.items():
 h=H(Path(x['local']));assert h==H(Path(a[rel]['local'])),rel;hashes[rel]=h
assert old['pre_source_payload']==new['pre_source_payload']
new['verified_source_seal']=old['pre_source_payload']['complete_branch_pre_source_seal_hash']
(w/'TAG_resolved_input.json').write_text(json.dumps(new,ensure_ascii=False)+'\\n')
(w/'TAG_reused_source_evidence.json').write_text(json.dumps(dict(status='PASS',prior_full_native='patient1234_empirical_report.json',shared_module_sha256=report['source_sha256'],same_registered_input_files=hashes,same_pre_source_payload=True,source_label_rebinding='SFT.Medicine.MODSource.sourceDerivedTarget',binding='Identical original WHO/ICH requirements; original family source delegates to PatientIdentitySource; only original claim-specific observed label differs'),indent=2)+'\\n')
print('Reused actual full native PatientIdentity source/seal with identical bytes and binding',flush=True)
'''.replace('TAG',tag).replace('MOD',mod);ast.parse(s);(w/('prepare_'+tag+'_reuse.py')).write_text(s)
 runner=(w/(mod+'ValidationProgram'+num+'.lean')).read_text();a=runner.index('def main');runner=runner[:a]+'''def sourceReceiptHash : Except String String := do
 let receipts ← SFT.Medicine.MODSource.requirements.mapM fun requirement => do
  let source ← SFT.Medicine.PatientIdentitySource.lookup requirement.sourceId
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  let digest := match source.snapshotHash with | some x => SFT.Host.Canonical.Value.text x | none => .null
  return SFT.Host.Canonical.Value.array [.text requirement.sourceId,digest,.text requirement.fragment,
   .text (SFT.Host.Canonical.identity (.array [.text requirement.sourceId,.text folded]))]
 return SFT.Host.Canonical.identity (.array receipts)
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/TAG_resolved_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let result ← IO.ofExcept (do
  let before ← field input "before" >>= protectedSnapshot
  let after ← field input "after" >>= protectedSnapshot
  let sourceSeal ← text input "verified_source_seal"
  SFT.Medicine.MODExperiment.validateSpec
  let registrationHash := SFT.Host.Canonical.identity (SFT.Medicine.MODExperiment.registration sourceSeal)
  let program ← CapabilityDocuments.loadProgramFields SFT.Medicine.MODExperiment.programFields
  let derivationSeal ← text input "derivation_seal"
  let inputs ← SFT.Medicine.MODValidation.inputValues derivationSeal
  SFT.Medicine.MODValidation.validateResolved registrationHash program inputs SFT.Medicine.MODSource.expectedLabel
   (← sourceReceiptHash) derivationSeal (← text input "host") (← text input "implementation") before after)
 IO.println (SFT.Host.Canonical.render result)
'''.replace('TAG',tag).replace('MOD',mod);(w/(mod+'ResolvedProgram'+num+'.lean')).write_text(runner)
 p=w/('check_'+tag+'_empirical.py');s=p.read_text().replace(mod+'ValidationProgram'+num,mod+'ResolvedProgram'+num);p.write_text(s)
 modules=[mod+x for x in ['','Grammar','Evidence','Source','Experiment','Validation']];count=sum(len(re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Medicine'/(m+'.lean')).read_text(),re.M))for m in modules)
 s=(w/'register_patient1234.py').read_text().replace('patient1234',tag).replace('PatientIdentity',mod).replace('SFT-MED-PATIENT-IDENTITY-001',cid).replace('TURN1234_PATIENT','TURN'+num+'_'+tag[:-4].upper()).replace('TURN1234','TURN'+num).replace('Patient identity',mod).replace('==121','=='+str(count)).replace('+121','+'+str(count)).replace('121 audited',str(count)+' audited').replace('121 empty',str(count)+' empty').replace('121 current',str(count)+' current')
 # Keep the unchanged first entry seal/source as dependency evidence, not duplicated declarations.
 a=s.index(';scopes=')+1;b=s.index('\noldNames=',a);scopes={
 mod:('sft/medicine/obligations.py and generated_law.py','Exact original eight-field obligation and three original operational witnesses.'),
 mod+'Grammar':('sft/medicine/generated_law.py','All eight original binary axes,256alternatives,full enumeration,original decisions and unique survivor.'),
 mod+'Evidence':('sft/medicine/empirical_program.py','Original forward-forcing registration,census,decisions,closure and controls.'),
 mod+'Source':('sft/medicine/external_bindings.py and empirical_program.py:_source_derived_target','Original WHO/ICH family requirements exactly equal PatientIdentity; delegate its unchanged native source operation,retaining extraction receipt and rebinding only original observed label.'),
 mod+'Experiment':('sft/medicine/empirical_program.py','Original registration,prediction,envelope and blueprint guards; reuse unchanged Medicine pre-source seal.'),
 mod+'Validation':('sft/medicine/empirical_program.py:BlindMedicineAuthorityValidator.validate','Original complete sealing,custody,isolation,target comparison,tampered control and12field4message result with retained full source/seal evidence.')};s=s[:a]+'scopes='+repr(scopes)+s[b:];s=s.replace("reports=[","reports=['"+tag+"_reused_source_evidence.json',",1);ast.parse(s);(w/('register_'+tag+'.py')).write_text(s)
 print(tag,count,'native declarations queued after actual PatientIdentity PASS',flush=True)

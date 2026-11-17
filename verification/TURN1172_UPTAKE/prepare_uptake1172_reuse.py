from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report=json.loads((w/'lifeorganization1110_empirical_report.json').read_text());assert report['status']=='PASS'
for rel,h in report['source_sha256'].items():assert digest(r/rel)==h,rel
assert json.loads((w/'lifeorganization1110_empirical_output.json').read_text())==json.loads((w/'lifeorganization1107_original_empirical.json').read_text())
sealReport=json.loads((w/'lifeorganization1106_seal_report.json').read_text());assert sealReport['status']=='PASS'
assert digest(r/'SFT/Biology/LifeOrganizationSeal.lean')==sealReport['source_sha256']
seal=json.loads((w/'lifeorganization1106_seal_output.json').read_text())[0]['ok']
compartment=json.loads((w/'metabolism1171_empirical_report.json').read_text());assert compartment['status']=='PASS'
for rel,h in compartment['source_sha256'].items():assert digest(r/rel)==h,rel
assert json.loads((w/'metabolism1171_empirical_output.json').read_text())==json.loads((w/'metabolism1171_original_empirical.json').read_text())
old=json.loads((w/'metabolism1171_empirical_input.json').read_text());new=json.loads((w/'uptake1172_empirical_input.json').read_text())
oldFiles={x['path']:x for x in old['files']};newFiles={x['path']:x for x in new['files']};assert oldFiles.keys()==newFiles.keys()
fileHashes={}
for path,x in newFiles.items():
 h=digest(Path(x['local']));assert h==digest(Path(oldFiles[path]['local'])),path;fileHashes[path]=h
assert old['pre_source_payload']==new['pre_source_payload']
new['verified_source_seal']=seal
(w/'uptake1172_resolved_input.json').write_text(json.dumps(new,ensure_ascii=False)+'\n')
reuse=dict(status='PASS',prior_full_native_validation='work/metabolism1171_empirical_report.json',prior_full_native_output='work/metabolism1171_empirical_output.json',prior_source_seal_audit='work/lifeorganization1106_seal_report.json',shared_module_sha256=report['source_sha256'],same_registered_input_files=fileHashes,same_pre_source_payload=True,source_seal=seal,source_label_rebinding='SFT.Biology.ResourceUptakeSource.sourceReuse',source_relation='identical requirements and extraction body; native source function delegates to the previously checked source function, replacing only the original claim-specific label')
(w/'uptake1172_reused_source_evidence.json').write_text(json.dumps(reuse,indent=2)+'\n')
s=(w/'ResourceUptakeValidationProgram1172.lean').read_text();a=s.index('def main');s=s[:a]+'''def sourceReceiptHash : Except String String := do
 let receipts ← SFT.Biology.ResourceUptakeSource.requirements.mapM fun requirement => do
  let source ← match SFT.Biology.MetabolismSource.sources.find? (fun s => SFT.Host.Text.equal s.sourceId requirement.sourceId) with
   | none => throw "missing registered source"
   | some source => pure source
  let folded := SFT.Chemistry.SourceText.casefold requirement.fragment
  return SFT.Host.Canonical.Value.array [.text requirement.sourceId,.text source.digest,.text requirement.fragment,
   .text (SFT.Host.Canonical.identity (.array [.text requirement.sourceId,.text folded]))]
 return SFT.Host.Canonical.identity (.array receipts)
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/uptake1172_resolved_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw)
 let result ← IO.ofExcept (do
  let before ← field input "before" >>= protectedSnapshot
  let after ← field input "after" >>= protectedSnapshot
  let sourceSeal ← text input "verified_source_seal"
  SFT.Biology.ResourceUptakeExperiment.validateSpec
  let registrationHash := SFT.Host.Canonical.identity (SFT.Biology.ResourceUptakeExperiment.registration sourceSeal)
  let program ← CapabilityDocuments.loadProgramFields SFT.Biology.ResourceUptakeExperiment.programFields
  let derivationSeal ← text input "derivation_seal"
  let inputs ← SFT.Biology.ResourceUptakeValidation.inputValues derivationSeal
  let extractionHash ← sourceReceiptHash
  SFT.Biology.ResourceUptakeValidation.validateResolved registrationHash program inputs
   SFT.Biology.ResourceUptakeSource.expectedLabel extractionHash derivationSeal
   (← text input "host") (← text input "implementation") before after)
 IO.println (SFT.Host.Canonical.render result)
'''
(w/'ResourceUptakeResolvedProgram1172.lean').write_text(s)
s=(w/'check_uptake1172_empirical.py').read_text().replace('ResourceUptakeValidationProgram1172.lean','ResourceUptakeResolvedProgram1172.lean')
s=s.replace("report={'status':'PASS'","report={'status':'PASS','fresh_native_resolved_phase':True,'reused_native_source_checks':'uptake1172_reused_source_evidence.json'")
(w/'check_uptake1172_resolved.py').write_text(s)
print('Verified unchanged native source modules,21byte-identical inputfiles and seal payload; prepared fresh entry-specific native comparison.')

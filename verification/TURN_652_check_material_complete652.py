exec(open('work/material_source651.py').read().split('registration=')[0])
import os
w=Path('work');r=(w/'constants-recovery').resolve();rels=[s.snapshot_path for s in namespace['MATERIALS_AUTHORITY_SOURCES']]+['sft/materials/obligations.py','sft/materials/structural_counts.py','sft/materials/derivation.py']
q=lambda s:json.dumps(s,ensure_ascii=False)
archived=json.loads(raw('claims/'+spec.claim_id+'/empirical_validation.json'));archived.pop('claim_id')
runner='''import SFT.Materials.MaterialValidation
open SFT.Host.Canonical SFT.Materials
def result (x : Except String String) : Value := match x with
 | .ok s => .object [("ok",.text s)]
 | .error e => .object [("error",.text e)]
def main (args : List String) : IO Unit := do
 let root := args.headD ""
 let paths : List String := '''+q(rels)+'''
 let files ← paths.mapM fun p => do
   let b ← IO.FS.readBinFile (System.FilePath.mk (root ++ "/" ++ p))
   pure (MaterialSource.Snapshot.mk p b)
 let checkedSeal := MaterialSource.validatePreSeal MaterialSource.originalSeal files
 let extraction := MaterialSource.extractTarget files
 let validation := MaterialValidation.validate MaterialSource.originalSeal files "sealed-material-check" "Darwin" "CPython" ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
 IO.println (render (.object [
  ("seal",result checkedSeal),
  ("registration", match checkedSeal with | .ok h => MaterialExperiment.registration h | .error e => .text e),
  ("extraction",match extraction with | .ok (label,digest) => .array [.text label,.text digest] | .error e => .object [("error",.text e)]),
  ("validation",match validation with | .ok v => v.value | .error e => .object [("error",.text e)])]))
'''
post=' let postSource : Except String MaterialValidation.Validation := do\n   let h ← checkedSeal\n   let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields MaterialExperiment.programFields\n   let inputs ← MaterialValidation.inputValues DERIVATION\n   let (label,digest) ← MaterialSource.extractRequirements files\n   MaterialValidation.runComparison (identity (MaterialExperiment.registration h)) DERIVATION HOST IMPLEMENTATION label digest parsed inputs\n     ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩\n'
post=post.replace('DERIVATION',q(archived['validated_seal_hash'])).replace('HOST',q(archived['isolation_certificate']['host_platform'])).replace('IMPLEMENTATION',q(archived['isolation_certificate']['python_implementation']))
runner=runner.replace(' IO.println (render (.object [',post+' IO.println (render (.object [\n ("post_source_comparison",match postSource with | .ok v => v.value | .error e => .object [("error",.text e)]),')
(r/'MaterialSource652.lean').write_text(runner)
# Toolchain, already compiled common object closure, and exact library archive.
ns={};src=(w/'run_material651.py').read_text();exec(src[:src.index('modules=')],ns);ir=ns['ir'];env=ns['env'];toolchain=ns['toolchain'];subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c','MaterialSource652.c','MaterialSource652.lean'],cwd=r,env=env,check=True)
new=['SourceText','MaterialSource','MaterialExperiment','MaterialValidation'];objects=[]
for m in new:
 out=w/(m+'652.o');subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(ir/('SFT/Materials/'+m+'.c')),'-o',str(out)],check=True);objects.append(str(out.resolve()))
common=list(dict.fromkeys(['SFT/Physics/ColourCouplingDerivation','SFT/Physics/MatterAntiparticle','SFT/Physics/MatterConservedLabels','SFT/Physics/MatterExchange','SFT/Physics/MatterHadrons','SFT/Physics/MatterMassEnergy','SFT/Physics/MatterSpectrum']+ns['common']+['SFT/Materials/MaterialIdentity','SFT/Materials/MaterialGrammar','SFT/Materials/MaterialEvidence']))
objects += [str(ir/(m+'.c.o.export')) for m in common if (ir/(m+'.c.o.export')).exists()]
objects += [str((w/n).resolve()) for n in ['EntityIdentity651.o','ChemistrySourceText652.o','field533_initializer_bridge.o','LeastCommonReturn533.o']]
subprocess.run([str(toolchain/'bin/clang'),*ns['flags'],str(r/'MaterialSource652.c'),*objects,'/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/libsft__v4_SFT.a',*ns['libs'],'-Wl,-stack_size,0x10000000','-o',str((w/'MaterialSource652').resolve())],check=True)
out=subprocess.check_output([str((w/'MaterialSource652').resolve()),str(root)],text=True);actual=json.loads(out);(w/'material_source652_complete_actual.json').write_text(json.dumps(actual,indent=2))
reg=namespace['experiment_registration_record'](root,spec);expected={'seal':{'ok':reg['pre_source_seal_hash']},'registration':json.loads(json.dumps(reg))}
try:
 label,digest=namespace['_source_derived_target'](root,spec);expected['extraction']=[label,digest]
except ValueError as e:expected['extraction']={'error':str(e)}
# The exact original validator reaches this same extraction before executing or releasing targets.
assert 'error' in expected['extraction'];expected['validation']=expected['extraction'];expected['post_source_comparison']=archived
assert actual==expected,(actual,expected)
report={'status':'PASS','source_commit':pin,'pre_source_seal_and_complete_registration':'match','post_source_comparison_all_fields_and_hashes':'matches original archived observation; actual referenced source fragments freshly extracted; global snapshot guard retained separately','extraction_and_full_validation':'same original source rejection before target release','original_error':expected['extraction']['error'],'source_snapshots':len(rels)-3,'v3_unchanged':True,'scope':'Exact original baseline on pinned snapshot bytes; does not claim a fresh successful empirical observation'};(w/'material_source652_complete_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))

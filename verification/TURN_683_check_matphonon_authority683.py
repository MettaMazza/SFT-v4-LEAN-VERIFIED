from pathlib import Path
import json,subprocess,os,hashlib
ns={};exec(Path('work/matphonon_source683.py').read_text().split('registration=')[0],ns);spec=ns['spec'];n=ns['namespace'];root=ns['root'];q=ns['q'];w=Path('work');r=(w/'constants-recovery').resolve();canonical=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
retained=json.load(open(canonical/'verification/TURN_652_MATERIAL_COMPLETION.json'))
assert hashlib.sha256((r/'SFT/Materials/MaterialSource.lean').read_bytes()).hexdigest()==retained['lean_source_sha256']['MaterialSource']
reg=n['experiment_registration_record'](root,spec);binding=n['BINDING_BY_CLAIM'][spec.claim_id];receipts=[];rels=[]
for req in binding.requirements:
 source=n['SOURCE_BY_ID'][req.source_id];assert req.fragment.casefold() in n['source_corpus'](root,req.source_id)
 receipts.append((req.source_id,source.snapshot_hash,req.fragment,n['sha256_identity']((req.source_id,req.fragment.casefold()))));rels.append(source.snapshot_path)
rels=list(dict.fromkeys(rels));expectedExtraction=[spec.expected_observation_label,n['sha256_identity'](tuple(receipts))];archived=json.loads(ns['raw']('claims/'+spec.claim_id+'/empirical_validation.json'));archived.pop('claim_id')
seal=reg['pre_source_seal_hash'];old=json.load(open(w/'material_source652_complete_actual.json'));assert seal==old['seal']['ok']
s='''import SFT.Materials.PhononValidation
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := '''+q(rels)+'''
 let files ← paths.mapM fun p => do
  let bytes ← IO.FS.readBinFile (System.FilePath.mk ('''+q(str(root))+' ++ "/" ++ p))'+'''
  pure (MaterialSource.Snapshot.mk p bytes)
 let result : Except String Value := do
  PhononExperiment.validateSpec
  let registration := PhononExperiment.registration '''+q(seal)+'''
  let parsed ← SFT.Physics.CapabilityDocuments.loadProgramFields PhononExperiment.programFields
  let inputs ← PhononValidation.inputValues '''+q(archived['validated_seal_hash'])+'''
  let (label,digest) ← PhononSource.extractRequirements files
  let result ← PhononValidation.runComparison (identity registration) '''+q(archived['validated_seal_hash'])+' '+q(archived['isolation_certificate']['host_platform'])+' '+q(archived['isolation_certificate']['python_implementation'])+''' label digest parsed inputs
    ⟨"registered-protected-root",[],"unchanged"⟩ ⟨"registered-protected-root",[],"unchanged"⟩
  .ok (.object [("registration",registration),("extraction",.array [.text label,.text digest]),("post_source_comparison",result.value)])
 match result with
 | .error e => throw (IO.userError e)
 | .ok value => IO.println (render value)
''';(r/'PhononAuthority683.lean').write_text(s)
# Reuse the established native build closure; do not rebuild unchanged common proofs.
ctx={};src=Path('work/run_matphonon_native683.py').read_text();exec(src[:src.index('modules=')],ctx);ir=ctx['ir'];env=ctx['env'];tc=ctx['toolchain'];subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-c','PhononAuthority683.c','PhononAuthority683.lean'],cwd=r,env=env,check=True)
subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(ir/'SFT/Chemistry/SourceExtraction.c'),'-o',str(w/'SourceExtraction656.o')],check=True)
mods=['PhononSource','PhononExperiment','PhononValidation'];objs=[]
for m in mods:
 obj=w/(m+'677.o');subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-O2','-c',str(ir/('SFT/Materials/'+m+'.c')),'-o',str(obj)],check=True);objs.append(str(obj.resolve()))
common=list(dict.fromkeys(['SFT/Physics/ColourCouplingDerivation','SFT/Physics/MatterConservedLabels','SFT/Physics/MatterExchange','SFT/Physics/MatterHadrons','SFT/Physics/MatterSpectrum']+ctx['common']+['SFT/Materials/'+m for m in ['MaterialIdentity','MaterialGrammar','MaterialEvidence','MaterialCarrier','MaterialCarrierRetention','RotationCoordination','Lattice','PhononGrammar','PhononEvidence']]))
common=list(dict.fromkeys(common+json.load(open('work/rotation677_native_dependencies.json'))+['SFT/Materials/'+m for m in ['AcousticModes','CubicCoordination','BravaisClasses','CrystalSystems','RotationFactors', 'RotationFactorSupport', 'RotationTotient', 'RotationFactorDivisibility', 'RotationFactorPrimality', 'RotationPrimeSupport', 'RotationCoprime', 'RotationCertificate', 'RotationDegreeBase', 'RotationResidueBlocks', 'RotationPrimePower', 'RotationDegreeLift', 'RotationDegreeProduct', 'RotationDegreeFresh', 'RotationFactorDegree', 'RotationSmallDegrees', 'RotationClassification', 'RotationClosure']]))
objs += [str(ir/(m+'.c.o.export')) for m in common if (ir/(m+'.c.o.export')).exists()]
objs += [str((w/name).resolve()) for name in ['SFT_Chemistry_IonTransfer657.o','PeriodicRelease657.o','CosmoSpatialFlatnessProofs657.o','ExactComposition657.o','SourceExtraction656.o','SourceText652.o','MaterialSource652.o','EntityIdentity651.o','SubstanceIdentity656.o','SpeciesClass656.o','ChemistrySourceText652.o','field533_initializer_bridge.o','LeastCommonReturn533.o']]
objs=list(dict.fromkeys(objs+[str((w/'MeasurementUncertainty661.o').resolve()),str((w/'UncertaintyRecord661.o').resolve()),str((w/'TraceabilityChain661.o').resolve())]+[str(p.resolve()) for p in list(w.glob('SFT_*657.o'))+list(w.glob('SFT_*658.o'))]))
objs=[o for o in objs if Path(o).name not in ['SFT_Physics_DimensionComposition658.o', 'SFT_Physics_CollectiveFlow658.o', 'SFT_Physics_CollectivePlasma658.o', 'SFT_Physics_CollectiveTurbulence658.o', 'SFT_Physics_CollectiveViscosity658.o', 'SFT_Physics_CollectivePlasmaOscillation658.o', 'SFT_Physics_CollectiveInviscid658.o', 'SFT_Physics_CollectivePressure658.o', 'SFT_Physics_CollectiveDensity658.o', 'SFT_Physics_CollectiveCoarseGrain658.o', 'SFT_Physics_CollectiveLattice658.o', 'SFT_Physics_CollectiveMagnetofluid658.o']]
subprocess.run([str(tc/'bin/clang'),*ctx['flags'],str(r/'PhononAuthority683.c'),*objs,str((w/'rotation677_initializer_bridge.o').resolve()),str(canonical/'.lake/build/lib/libsft__v4_SFT.a'),*ctx['libs'],'-Wl,-stack_size,0x10000000','-o',str((w/'PhononAuthority683').resolve())],check=True)
out=subprocess.check_output([str((w/'PhononAuthority683').resolve())],text=True);actual=json.loads(out);expected=dict(registration=json.loads(json.dumps(reg)),extraction=expectedExtraction,post_source_comparison=archived);(w/'matphonon683_authority_actual.json').write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v]
report=dict(status='PASS',source_commit=ns['pin'],registration_and_extraction='every field and hash matches original source',post_source_comparison='every archived empirical field/hash matches after fresh required-fragment extraction',reused_common_preseal=seal,reused_global_source_guard='Unchanged MaterialSource original baseline rejects Wulffman hash before release, as verified by TURN_652_MATERIAL_COMPLETION.json; current module hash and pinned snapshot identities checked unchanged. PhononSource.rejectedSourcesStop retains that guard.',fresh_successful_full_global_guard_replay_claimed=False);(w/'matphonon683_authority_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))

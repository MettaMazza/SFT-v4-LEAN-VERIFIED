from pathlib import Path
import json,subprocess,os,re,zlib,ast
ns={};exec(Path('work/periodicboundary_spec564.py').read_text(),ns);raw=ns['raw'];spec=ns['spec'];q=lambda s:json.dumps(s,ensure_ascii=False)
def rawbytes(path):return subprocess.check_output(['git','-C',ns['repo'],'show',ns['pin']+':'+path])
def cv(v):
 if v is None:return '.null'
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(cv(x) for x in v)+']'
 if isinstance(v,dict):return '.object ['+','.join('('+q(k)+','+cv(x)+')' for k,x in v.items())+']'
 raise TypeError(v)
expected=json.loads(raw('claims/'+spec.claim_id+'/empirical_validation.json'));expected.pop('claim_id');registry=raw(spec.observation_registry_path);ref=spec.target_rows[0];payload=rawbytes(ref.snapshot_path)
w=Path('work/periodic564_io').resolve();w.mkdir(exist_ok=True);pdf=w/'pinned.pdf';pdf.write_bytes(payload);paths=[]
for match in re.finditer(rb'stream\r?\n',payload):
 end=payload.find(b'endstream',match.end())
 if end<match.end():continue
 try:data=zlib.decompress(payload[match.end():end].rstrip(b'\r\n'))
 except zlib.error:continue
 path=w/('stream'+str(len(paths))+'.bin');path.write_bytes(data);paths.append(path)
mod=ast.parse(raw('sft/chemistry/generated_periodic_law.py'));nodes=[n for n in mod.body if getattr(n,'name',None) in ['_pdf_literal_strings','periodic_pdf_text']];pn={'re':re,'zlib':zlib,'Path':Path};exec(compile(ast.Module(body=nodes,type_ignores=[]),'pinned_periodic_parser','exec'),pn);texts=pn['periodic_pdf_text'](pdf)
s='import SFT.Chemistry.PeriodicBoundaryValidation\nopen SFT.Chemistry SFT.Physics SFT.Host.Canonical\nset_option maxRecDepth 100000\n'
s+='def registry : Value := '+cv(json.loads(registry))+'\n'
s+='def main : IO Unit := do\n let bytes ← IO.FS.readBinFile '+q(str(pdf))+'\n let streams ← (['+','.join(q(str(p)) for p in paths)+'] : List String).mapM (fun p => IO.FS.readBinFile (System.FilePath.mk p))\n'
s+=' let texts ← match PeriodicPDF.texts streams with\n  | .error e => throw (IO.userError e)\n  | .ok t => pure t\n IO.println (render (.array [.text texts.1,.text texts.2]))\n'
s+=' let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩\n'
s+=' match PeriodicBoundaryValidation.validate ('+q(registry)+').toUTF8 registry [⟨'+q(ref.snapshot_path)+',bytes,.null,streams⟩] '+q(expected['validated_seal_hash'])+' '+q(expected['isolation_certificate']['host_platform'])+' '+q(expected['isolation_certificate']['python_implementation'])+' before before with\n | .error e => throw (IO.userError e)\n | .ok result => IO.println (render result.value)\n'
r=Path('work/constants-recovery').resolve();(r/'PeriodicBoundaryValidationProgram564.lean').write_text(s);Path('work/periodicboundary_validation564_expected.json').write_text(json.dumps(expected,indent=2));env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','PeriodicBoundaryValidationProgram564.lean'],cwd=r,env=env,capture_output=True,text=True);Path('work/periodicboundary_validation564_output.log').write_text(p.stdout+p.stderr);assert p.returncode==0,(p.stdout+p.stderr)[-3000:];lines=p.stdout.splitlines();assert json.loads(lines[0])==list(texts),'native PDF text differs';actual=json.loads(lines[1]);Path('work/periodicboundary_validation564_output.json').write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v];Path('work/periodicboundary_validation564_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'all_validation_fields_and_hashes_match':True,'source_snapshot_bytes':len(payload),'registry_bytes':len(registry.encode()),'pdf_streams':len(paths),'native_text_matches_pinned_python_parser':True,'native_normalized_characters':len(texts[0]),'fresh_native_lean_execution':True,'adapter_inputs':'Original regex stream extraction and zlib decompression from same pinned PDF bytes; native literal parsing/normalization/feature extraction; original host metadata and equal protected snapshots'},indent=2));print('PASS native PDF parser and full original mixed-source empirical output')

from pathlib import Path
import json
w=Path('work');paths=[Path(p)for p in json.loads((w/'medicine_iteration1191_files.json').read_text())]
for p in paths:
 s=p.read_text().replace(' let totals ← sources.foldlM (fun (totals : Nat × Nat) source => do',' let mut capturedCount := 0\n let mut failedCount := 0\n for source in sources do')
 s=s.replace('  if Text.equal source.transportStatus "captured" then\n','  if Text.equal source.transportStatus "captured" then\n   capturedCount := capturedCount+1\n').replace('  else if Text.equal source.transportStatus "failed" then\n','  else if Text.equal source.transportStatus "failed" then\n   failedCount := failedCount+1\n')
 s=s.replace('   return (totals.1+1,totals.2)\n','').replace('   return (totals.1,totals.2+1)\n','').replace('source.sourceId)) (0,0)\n if totals.1 != 11 || totals.2 != 2 then','source.sourceId)\n if capturedCount != 11 || failedCount != 2 then')
 old='''   let (sp,sh,tp,th) ← match source.snapshotPath,source.snapshotHash,source.textPath,source.textHash with
    | some sp,some sh,some tp,some th => .ok (sp,sh,tp,th)
    | _,_,_,_ => .error (Text.append "Medicine captured source lacks immutable paths: " source.sourceId)'''
 new='\n'.join('   let '+name+' ← match source.'+field+' with\n    | some value => .ok value\n    | none => .error (Text.append "Medicine captured source lacks immutable paths: " source.sourceId)'for name,field in [('sp','snapshotPath'),('sh','snapshotHash'),('tp','textPath'),('th','textHash')])
 assert old in s,p;s=s.replace(old,new)
 old='''   let (fp,fh) ← match source.failurePath,source.failureHash with
    | some fp,some fh => .ok (fp,fh)
    | _,_ => .error (Text.append "Medicine failed-transport receipt changed: " source.sourceId)'''
 new='\n'.join('   let '+name+' ← match source.'+field+' with\n    | some value => .ok value\n    | none => .error (Text.append "Medicine failed-transport receipt changed: " source.sourceId)'for name,field in [('fp','failurePath'),('fh','failureHash')])
 assert old in s,p;s=s.replace(old,new);assert 'totals'not in s;p.write_text(s)
print('Restored original loop encoding; replaced only multi-field optional matches in',len(paths),'copies')
p=w/'repair_patient1191_build.py';s=p.read_text().replace("['PatientIdentitySource','PatientIdentitySeal','PatientIdentityValidation']","['PatientIdentitySource','PatientIdentitySeal','PatientIdentityExperiment','PatientIdentityValidation']");p.write_text(s)

from pathlib import Path
import json,shutil
w=Path('work');r=w/'turn1064_recovery';changed=[]
for p in list((r/'SFT/Medicine').glob('*Source.lean'))+list(w.glob('generate_*_source.py'))+list((r/'verification').rglob('generate_*_source.py')):
 s=p.read_text()
 if ' let mut capturedCount := 0\n let mut failedCount := 0\n for source in sources do'not in s:continue
 s=s.replace(' let mut capturedCount := 0\n let mut failedCount := 0\n for source in sources do',' let totals ← sources.foldlM (fun (totals : Nat × Nat) source => do').replace('   capturedCount := capturedCount+1\n','').replace('   failedCount := failedCount+1\n','')
 s=s.replace('  else if Text.equal source.transportStatus "failed" then','   return (totals.1+1,totals.2)\n  else if Text.equal source.transportStatus "failed" then')
 s=s.replace('  else throw (Text.append "Medicine source has unknown transport status: " source.sourceId)\n if capturedCount != 11 || failedCount != 2 then','   return (totals.1,totals.2+1)\n  else throw (Text.append "Medicine source has unknown transport status: " source.sourceId)) (0,0)\n if totals.1 != 11 || totals.2 != 2 then')
 assert 'let mut capturedCount'not in s and 'if totals.1 != 11' in s,p
 p.write_text(s);changed.append(str(p))
(w/'medicine_iteration1191_files.json').write_text(json.dumps(changed,indent=2)+'\n')
# Rebuild only the changed source and its imported source-dependent interfaces.
s=(w/'resume_patient1189_build.py').read_text().replace("for mod in mods[3:]:","for mod in ['PatientIdentitySource','PatientIdentitySeal','PatientIdentityValidation']:")
(w/'repair_patient1191_build.py').write_text(s)
print('Replaced generated for-loop with exact sequential fold in',len(changed),'source/generator copies')

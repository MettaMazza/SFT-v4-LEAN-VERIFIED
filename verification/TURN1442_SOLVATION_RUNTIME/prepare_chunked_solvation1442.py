from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';shadow=w/'solvation_chunked1442_source';p=shadow/'SFT/Host/Canonical.lean';p.parent.mkdir(parents=True,exist_ok=True)
original=(r/'SFT/Host/Canonical.lean').read_text();revised=original.replace('import SFT.Host.SHA256\n','import SFT.Host.SHA256Chunks\n').replace('SHA256.digest (render v).toUTF8','SHA256Chunks.digest (render v).toUTF8')
assert revised!=original and revised.replace('import SFT.Host.SHA256Chunks\n','import SFT.Host.SHA256\n').replace('SHA256Chunks.digest (render v).toUTF8','SHA256.digest (render v).toUTF8')==original
p.write_text(revised)
(w/'ChunkedHashAudit1442.lean').write_text('import SFT.Host.SHA256Chunks\n#print axioms SFT.Host.SHA256Chunks.digestPreserved\n#print axioms SFT.Host.SHA256Chunks.digest\n')
s=(w/'prepare_solvation1342_empirical_native1413.py').read_text().replace('solvation1342_empirical_native1413','solvation1342_chunked1442').replace('solvation1342_empirical_native_build1413','solvation1342_chunked_build1442')
s=s.replace("p=r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p","p=(w/'solvation_chunked1442_source'/(rel+'.lean')) if m=='SFT.Host.Canonical' else r/(rel+'.lean');p=p if p.exists()else c/(rel+'.lean');assert p.exists(),p")
s=s.replace("'solvation1342_program_native_build1413.json']","'solvation1342_program_native_build1413.json','solvation1342_empirical_native_build1413.json']")
s=s.replace('scope\':\'compiled executable construction only; original comparison remains required','scope\':\'isolated chunked canonical identity; original comparison and existing digestPreserved equality required')
(w/'prepare_solvation1342_chunked1442.py').write_text(s)
H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
(w/'chunked_solvation1442_source_correspondence.json').write_text(json.dumps({'status':'PREPARED','unchanged_original_canonical':H(r/'SFT/Host/Canonical.lean'),'isolated_canonical':H(p),'equivalence_theorem':'SFT.Host.SHA256Chunks.digestPreserved','equivalence_source_sha256':H(r/'SFT/Host/SHA256Chunks.lean'),'changes':['Import existing SHA256Chunks','Replace identity hash call only'],'scientific_sources_changed':False},indent=2)+'\n')
print('Isolated existing-equivalence implementation prepared')

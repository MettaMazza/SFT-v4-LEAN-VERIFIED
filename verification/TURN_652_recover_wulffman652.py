from pathlib import Path
import hashlib,json,itertools,time
p=Path('/Volumes/One Touch/ernos-labs-sft-platform/experiments/external_sources/materials/snapshots/nist-wulffman-crystallography.html');b=p.read_bytes();lines=b.splitlines(keepends=True);target='52558a4ed54b8ecc464b0ba83d879a0cbbffcb7ed25385f7742d021e87b43cb6'
# Test only newline restoration at the captured page-template boundaries.
# Matching the original registered SHA-256 is mandatory; never replace the digest.
boundaries=sorted(set([0,len(lines)]+list(range(85,103))+list(range(990,1006))+list(range(0,25))+list(range(1025,len(lines)+1))))
count=0
for a,c in itertools.combinations(boundaries,2):
 for outer in [False,True]:
  candidate=b''.join(x.replace(b'\n',b'\r\n') if ((a<=i<c)!=outer) else x for i,x in enumerate(lines));count+=1
  if hashlib.sha256(candidate).hexdigest()==target:
   assert candidate.replace(b'\r\n',b'\n')==b
   Path('work/wulffman652_registered.html').write_bytes(candidate)
   receipt={'status':'registered_bytes_recovered','method':'CRLF restoration only; complete original registered SHA256 matched','range_start_zero_based':a,'range_stop_exclusive':c,'outside_range':outer,'sha256':target,'normalized_sha256':hashlib.sha256(b).hexdigest(),'bytes':len(candidate),'tested_variants':count,'v3_unchanged':True}
   Path('work/wulffman652_recovery.json').write_text(json.dumps(receipt,indent=2));print(json.dumps(receipt));raise SystemExit
print('No registered-byte match among',count,'page-boundary variants')

from pathlib import Path
import hashlib,json,time
b=Path('/Volumes/One Touch/ernos-labs-sft-platform/experiments/external_sources/materials/snapshots/nist-wulffman-crystallography.html').read_bytes();target='52558a4ed54b8ecc464b0ba83d879a0cbbffcb7ed25385f7742d021e87b43cb6';ends=[0]+[i+1 for i,c in enumerate(b) if c==10];cr=b.replace(b'\n',b'\r\n');count=0;t=time.time()
for a in range(len(ends)):
 for z in range(a+1,len(ends)):
  for outer in [False,True]:
   if outer:c=cr[:ends[a]+a]+b[ends[a]:ends[z]]+cr[ends[z]+z:]
   else:c=b[:ends[a]]+cr[ends[a]+a:ends[z]+z]+b[ends[z]:]
   count+=1
   if hashlib.sha256(c).hexdigest()==target:
    assert c.replace(b'\r\n',b'\n')==b
    Path('work/wulffman652_registered.html').write_bytes(c)
    result={'status':'registered_bytes_recovered','method':'newline restoration matching complete original SHA256','range_start_zero_based':a,'range_stop_exclusive':z,'outside_range':outer,'sha256':target,'normalized_sha256':hashlib.sha256(b).hexdigest(),'bytes':len(c),'tested_variants':count,'elapsed_seconds':time.time()-t,'v3_unchanged':True}
    Path('work/wulffman652_recovery.json').write_text(json.dumps(result,indent=2));print(json.dumps(result),flush=True);raise SystemExit
print('No original-hash match among',count,'contiguous CRLF variants',time.time()-t,flush=True)

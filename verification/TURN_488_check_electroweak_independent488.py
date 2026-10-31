from pathlib import Path
import subprocess,json,copy
repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';results=[]
for kind,cid,validator in [('electroweak_terminal','SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003','precision_value_validator416.py')]:
 assert Path('work/electroweak_native488_report.json').exists(), 'Fresh full-program comparison must finish first'
 base='claims/'+cid+'/'
 script=Path('work/'+validator)
 native=json.loads(Path('work/electroweak_native488_output.json').read_text());empirical=json.loads(subprocess.check_output(['git','-C',repo,'show',pin+':'+base+'certificate.json']))
 empirical['validated_seal_hash']=empirical['derivation_seal_hash']
 sealed=dict(claim_id=cid,census=native['census'],decisions=native['decisions'],closure=native['closure'],controls=native['controls'],seal_hash=empirical['validated_seal_hash'])
 variants=[('original',sealed,True)]
 row=copy.deepcopy(sealed);row['census']['candidates'].pop();variants.append(('omitted-row',row,False))
 row=copy.deepcopy(sealed);next(x for x in row['decisions'] if not x['survives'])['survives']=True;variants.append(('extra-survivor',row,False))
 row=copy.deepcopy(sealed);row['controls'][0]['passed']=False;variants.append(('failed-control',row,False))
 for label,row,expected in variants:
  data=Path('work/'+kind+'_independent_input374.json');data.write_text(json.dumps(row));actual=json.loads(subprocess.check_output(['python3',str(script),cid,str(data)],text=True));assert actual['passed']==expected and actual['validated_seal_hash']==sealed['seal_hash'];results.append(dict(claim_id=cid,case=label,expected=expected,actual=actual))
Path('work/electroweak_terminal_independent488_output.json').write_text(json.dumps(results,indent=2)+'\n');Path('work/electroweak_terminal_independent488_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,cases=len(results),scope='Pinned independent validators applied to fresh full native program outputs and original seal labels; omitted-row,extra-survivor and failed-control variants rejected. Seal labels are echoed by these source validators,not recomputed.'),indent=2)+'\n');print(len(results),'original independent-validator cases passed')

# Read-only source inspection: AST/getblock/regex only; no original module import,
# evaluation, probe function, model execution or historical game replay.
from pathlib import Path
import ast,inspect,re,json,hashlib,sys
r=Path(sys.argv[1])/'pure'; output=Path(sys.argv[2])
def functions(path):
 s=path.read_text();lines=s.splitlines(keepends=True);t=ast.parse(s)
 return {n.name:''.join(inspect.getblock(lines[n.lineno-1:]))for n in t.body if isinstance(n,ast.FunctionDef)}
w=functions(r/'claims_physics.py');c=functions(r/'compare.py');cs=functions(r/'correspondence.py')
t=ast.parse((r/'claims_physics.py').read_text());a=next(n for n in t.body if isinstance(n,ast.Assign)and any(isinstance(x,ast.Name)and x.id=='CLAIMS'for x in n.targets));rows=[([ast.literal_eval(x)for x in n.elts[:4]],n.elts[4].id)for n in a.value.elts]
patterns=[('standing_modes',r'standing_modes|fixed point|standing mode|returns to itself'),('coupling',r'take\(m, ?ONE\)|coupling|m-less-one over'),('mode_count',r'mode count|number of (interior )?modes|generation count'),('orbit_period',r'orbit|multiplicative order|fold-orbit|period'),('tower',r'two-?to-?the|covering tower|binary tower|doubling')]
raw=(output/'source_rows.tsv').read_text().splitlines();assert raw[0]=='COUNT\t334';assert len(raw)==335
errors=[];metadata=[]
for idx,((data,wrapper),line)in enumerate(zip(rows,raw[1:])):
 tag,status,description,_=data;parts=line.split('\t');actual_source=bytes.fromhex(parts[4]).decode();s=w.get(wrapper,'');m=re.search(r'test_[a-zA-Z0-9_]+',s)
 if m and m[0]in c:
  s=c[m[0]];cm=re.search(r'(?:Co|correspondence)\.([a-zA-Z0-9_]+)\(',s)
  if cm and cm[1]in cs:s=cs[cm[1]]
 family=next((name for name,pat in patterns if re.search(pat,s,re.I)),None)
 values=[n for name,n in zip(['two','three','four','five','six','seven','eight','nine','ten','eleven','twelve','thirteen'],range(2,14))if re.search(r'\b'+name+r'\b',s.lower())]
 values +=[x.count('ONE')for x in re.findall(r'(?:ONE(?:\s*\+\s*ONE)+)',s)]
 pin=max(values)if values and family else None
 expected=[tag,status,wrapper,description,s,str(family),str(pin)]
 actual=[parts[0],parts[1],parts[2],bytes.fromhex(parts[3]).decode(),actual_source,parts[5],parts[6]]
 for field,(x,y)in enumerate(zip(expected,actual)):
  if x!=y:errors.append({'tag':tag,'field':field,'expected_length':len(x),'actual_length':len(y),'expected':x[:120]if field>=5 else None,'actual':y[:120]if field>=5 else None})
 metadata.append({'tag':tag,'status':status,'family':family,'pin':pin,'source_sha256':hashlib.sha256(s.encode()).hexdigest()})
report={'status':'PASS'if not errors else'FAIL','registry_rows':len(rows),'source_text_and_metadata_fields':len(rows)*7,'original_module_executed':False,'errors':errors};(output/'source_reader_report.json').write_text(json.dumps(report,indent=2)+'\n');(output/'source_reader_inspection.json').write_text(json.dumps(metadata,indent=2)+'\n');print(json.dumps(report,indent=2))

assert not errors, errors

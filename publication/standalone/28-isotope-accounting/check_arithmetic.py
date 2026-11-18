from pathlib import Path
from fractions import Fraction
import ast,types,sys,json,hashlib,itertools,dataclasses
root=Path(__file__).resolve().parents[1];dest=root;sys.dont_write_bytecode=True

def load(name,relative,bindings=None,stop=None):
 tree=ast.parse((root/'v3'/relative).read_text(),filename=relative);body=[]
 for node in tree.body:
  if isinstance(node,ast.ImportFrom) and (node.module or '').startswith('sft.'):continue
  if stop and isinstance(node,ast.ClassDef) and node.name==stop:break
  body.append(node)
 tree.body=body;m=types.ModuleType(name);sys.modules[name]=m;m.__dict__.update(bindings or {});exec(compile(tree,relative,'exec'),m.__dict__);return m
exact=load('p28exact','sft/engine/exact.py');b={n:getattr(exact,n) for n in ['HeldLabel','PositiveCount','InadmissibleExactValue']};fold=load('p28fold','sft/claim_evidence/fold_language.py',b,'FoldOpcode');b.update({n:getattr(fold,n) for n in ['EMPTY_ONE','EmptyOne','PositiveRatio']});b['dimension']=lambda *a:a
stems=['nuclide_chemical_carrier','radioactive_chemical_transformation','activity_amount_time','radioactive_branching_yield','radiochemical_equilibrium','isotope_exchange','equilibrium_isotope_fractionation','kinetic_isotope_fractionation','radiotracer_custody','radiochemical_separation','fission_product_distribution'];mods={s:load('p28_'+s,'sft/chemistry/'+s+'_law_v1.py',b) for s in stems};witnesses=0;grammars={}
for stem,m in mods.items():
 assert len(m.OPERATIONAL_WITNESSES)==8 and all(w[2] for w in m.OPERATIONAL_WITNESSES);witnesses+=8;assert len(m.DIMENSIONS)==8
 grammars[stem]=[{'axis':x[0],'rejected':x[1],'rejection_reason':x[2],'admitted':x[3],'admitted_reason':x[4]} for x in m.DIMENSIONS]
H=exact.HeldLabel;N=exact.PositiveCount;E=fold.EMPTY_ONE
carrier=mods[stems[0]];r=carrier.NuclideChemicalCarrier(H('element','Sr'),N(90),H('nuclear-state','held'),H('chemical-species','solution'),H('chemical-phase','aqueous'),N(1))
for n in range(1,65):assert dataclasses.astuple(dataclasses.replace(r,occurrence=N(n)))[:-1]==dataclasses.astuple(r)[:-1]
activity=mods[stems[2]];activity_cases=0
for initial in range(1,13):
 for events in range(1,initial+1):
  for time in range(1,9):
   a=activity.ActivityLedger(H('nuclide','n'),H('chemical-species','s'),N(initial),N(events),N(time));assert a.activity.fraction==Fraction(events,time);assert (a.retained_amount is E) if initial==events else a.retained_amount.value==initial-events;activity_cases+=1
branch=mods[stems[3]];partitions=0
for width in range(1,5):
 for counts in itertools.product(range(1,5),repeat=width):
  rows=tuple(branch.BranchYield(H('decay-channel',str(i)),H('daughter-species',str(i)),N(n),N(1)) for i,n in enumerate(counts));shares=branch.branch_partition(rows);assert sum(s.fraction for s in shares)==1 and len(shares)==width;partitions+=1
frac=mods[stems[6]];exchange=mods[stems[5]];inventories=0;exchange_transitions=0
for la,ha,lb,hb in itertools.product(range(1,5),repeat=4):
 s=frac.EquilibriumIsotopePartition(H('isotope','L'),H('isotope','H'),H('chemical-phase','A'),H('chemical-phase','B'),N(la),N(ha),N(lb),N(hb));assert s.factor.fraction==s.ratio_a.fraction/s.ratio_b.fraction
 e=exchange.IsotopeExchangeState(H('element','e'),H('isotope','L'),H('isotope','H'),H('chemical-carrier','A'),H('chemical-carrier','B'),N(la),N(ha),N(lb),N(hb));assert e.quotient*s.factor.fraction==1 and exchange.exchange_transition(e,e) is E;inventories+=1
 if ha>1 and lb>1:
  nxt=dataclasses.replace(e,light_a=N(la+1),heavy_a=N(ha-1),light_b=N(lb-1),heavy_b=N(hb+1));assert exchange.exchange_transition(e,nxt).label=='heavy-A-to-B';assert exchange.exchange_transition(nxt,e).label=='heavy-B-to-A';exchange_transitions+=2
kin=mods[stems[7]];kinetic_cases=0
for li,hi in itertools.product(range(1,7),repeat=2):
 for lp,hp in itertools.product(range(1,li+1),range(1,hi+1)):
  s=kin.KineticIsotopeInterval(H('reaction-path','p'),H('isotope','L'),H('isotope','H'),N(1),N(li),N(hi),N(lp),N(hp),N(3));assert s.factor.fraction==s.light_rate/s.heavy_rate;kinetic_cases+=1
tr=mods[stems[8]];rows=tuple(tr.RadiotracerObservation(H('radiotracer','r'),H('chemical-carrier','c'),H('observation-location',str(i)),N(i),N(i),N(64)) for i in range(1,65));full=tr.tracer_record(rows)
for n in range(1,65):assert full[:n]==tr.tracer_record(rows[:n])
sep=mods[stems[9]];separations=0
for pt,pc,wt,wc in itertools.product(range(1,5),repeat=4):
 s=sep.SeparationLedger(H('target-species','t'),H('contaminant-species','c'),N(pt+wt),N(pc+wc),N(pt),N(pc),N(wt),N(wc));assert s.recovery==Fraction(pt,pt+wt) and s.decontamination_factor==Fraction(pc+wc,pt+wt)/Fraction(pc,pt);separations+=1
fission=mods[stems[10]];distributions=0
for width in range(1,5):
 for counts in itertools.product(range(1,4),repeat=width):
  rows=tuple(fission.FissionProductChemicalRow(H('fission-product',str(i)),H('chemical-species','s'),H('chemical-phase','p'),H('location','l'),N(n)) for i,n in enumerate(counts));d=fission.chemical_distribution(rows);assert sum(x[-1] for x in d)==1;after=tuple(dataclasses.replace(x,location=H('location','next')) for x in rows);assert fission.redistribute(rows,after)==fission.chemical_distribution(after);distributions+=1
import ast

def constants(path):
 d={}
 def val(n):
  if isinstance(n,ast.Constant):return n.value
  if isinstance(n,ast.Name):return d[n.id]
  if isinstance(n,(ast.Tuple,ast.List)):return tuple(val(x) for x in n.elts)
  if isinstance(n,ast.JoinedStr):return ''.join(str(val(x.value)) if isinstance(x,ast.FormattedValue) else val(x) for x in n.values)
  raise ValueError()
 for node in ast.parse(path.read_text()).body:
  if isinstance(node,ast.Assign):
   try:v=val(node.value)
   except (ValueError,KeyError):continue
   for t in node.targets:
    if isinstance(t,ast.Name):d[t.id]=v
 return d
authorities=0;vectors={};data={}
for family in ['initial','fractionation','terminal']:
 d=constants(root/'v3/sft/chemistry'/('nuchem_'+family+'_batch_v1.py'))
 for n,h in d['AUTHORITIES']:assert 'sha256:'+hashlib.sha256((root/'v3'/n).read_bytes()).hexdigest()==h;authorities+=1
 a=json.loads((root/'v3'/d['ANALYSIS_PATH']).read_text());v=dict(a);recorded=v.pop('complete_result_vector_sha256');actual=hashlib.sha256(json.dumps(v,sort_keys=True,separators=(',',':')).encode()).hexdigest();assert recorded in [actual,'sha256:'+actual]
 vectors[family]={'pdf_pages':a['complete_pdf_page_count'],'html_documents':a.get('complete_html_document_count',0),'characters':a['complete_extracted_character_count'],'complete_result_vector_sha256':recorded};data.update({k:v for k,v in a.items() if k.startswith('nuchem_')})
intervals=[]
for row in data['nuchem_003']['complete_massic_activity_vector']:
 v=Fraction(row['value']);u=Fraction(row['expanded_uncertainty']);intervals.append({'nuclide':row['nuclide'],'lower':str(v-u),'upper':str(v+u),'unit':row['unit'],'coverage_factor':row['coverage_factor']})
assert Fraction('2.2')-Fraction('0.5')==Fraction(17,10) and Fraction('2.2')+Fraction('0.5')==Fraction(27,10)
result={'status':'PASS','original_witnesses':witnesses,'original_grammars':11,'original_candidate_rows_per_grammar':256,'carrier_replacements':64,'activity_ledgers':activity_cases,'branch_partitions':partitions,'isotope_inventories':inventories,'exchange_transitions':exchange_transitions,'kinetic_intervals':kinetic_cases,'tracer_prefixes':64,'separation_ledgers':separations,'fission_distributions_and_redistributions':distributions,'authority_hash_checks':authorities,'complete_source_vectors':vectors,'massic_activity_intervals':intervals,'correction_interval_ppm':['1.7','2.7'],'new_lean_builds':0};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(result,indent=2)+'\n');(root/'grammar_axes.json').write_text(json.dumps(grammars,indent=2)+'\n');print(json.dumps(result))

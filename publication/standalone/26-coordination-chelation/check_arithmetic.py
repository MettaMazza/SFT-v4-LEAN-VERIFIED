from pathlib import Path
import ast,types,sys,json,hashlib
root=Path(__file__).resolve().parents[1];dest=root;sys.dont_write_bytecode=True

def load(name,relative,bindings=None,selected=None):
 tree=ast.parse((root/'v3'/relative).read_text(),filename=relative);body=[]
 for n in tree.body:
  if isinstance(n,ast.ImportFrom) and (n.module or '').startswith('sft.'):continue
  if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='DEPENDENCIES' for t in n.targets):break
  if selected and not (isinstance(n,ast.ImportFrom) and n.module=='__future__') and not (isinstance(n,(ast.FunctionDef,ast.ClassDef)) and n.name in selected):continue
  body.append(n)
 tree.body=body;m=types.ModuleType(name);sys.modules[name]=m;m.__dict__.update(bindings or {});exec(compile(tree,relative,'exec'),m.__dict__);return m
exact=load('paper26exact','sft/engine/exact.py');b={n:getattr(exact,n) for n in ['HeldLabel','PositiveCount','InadmissibleExactValue']};entity=load('paper26entity','sft/chemistry/coordination_entity_law_v1.py',b);b.update({n:getattr(entity,n) for n in ['CompleteCoordinationEntity','RetainedCoordinationAttachment']});number=load('paper26number','sft/chemistry/coordination_number_law_v1.py',b);ligand=load('paper26ligand','sft/chemistry/ligand_denticity_chelation_law_v1.py',b)
H=exact.HeldLabel;N=exact.PositiveCount;A=entity.RetainedCoordinationAttachment;E=entity.CompleteCoordinationEntity;T=ligand.CompleteLigandDonorTopology

def make(n):
 centre=H('coordination-central-occurrence','M');group=H('coordination-ligand-group','same-group');rows=tuple(A(N(i),centre,H('coordination-ligand-occurrence',str(i)),group,H('positive-coordination-incidence',str(i))) for i in range(1,n+1));return E(H('coordination-entity','entity'),H('coordination-central-element','M'),centre,rows)
def topology(e,n):
 rows=e.ordered_attachments[:n];return T(H('coordination-ligand-carrier-occurrence','L'),H('coordination-ligand-group','same-group'),e.central_occurrence,tuple(a.ligand_occurrence for a in rows),tuple(a.attachment_trace for a in rows),tuple(H('positive-ligand-internal-incidence',str(i)) for i in range(1,n)))
for n in range(1,65):
 e=make(n);t=topology(e,n);c=number.forced_coordination_number(e);r=ligand.forced_ligand_denticity_and_chelation(e,t);identity=entity.forced_coordination_entity_identity_law(e)
 assert c.positive_direct_incidence_count.value==r.positive_denticity.value==n
 assert c.ordered_incidence_traces==r.ordered_attachment_traces==identity.ordered_attachment_traces
 assert len(r.closed_topology_trace)==(0 if n==1 else n+1)
 assert r.ordered_donor_site_occurrences==identity.ordered_ligand_occurrences and r.ordered_internal_connection_traces==t.ordered_internal_connection_traces
 if n<64:
  extended=make(n+1);nextrow=extended.ordered_attachments[-1]
  assert entity.append_ligand_preserves_coordination_identity(e,nextrow)
  assert number.append_incidence_increments_coordination_number(e,nextrow)
  assert ligand.append_donor_site_preserves_topology_and_increments_denticity(extended,t,nextrow.ligand_occurrence,nextrow.attachment_trace,H('positive-ligand-internal-incidence',str(n)))
# Original constructor rejection guards and retained membership guards.
e=make(2);t=topology(e,2);args=[t.ligand_carrier_occurrence,t.ligand_group_identity,t.central_occurrence,t.ordered_donor_site_occurrences,t.ordered_attachment_traces,t.ordered_internal_connection_traces];invalid=[]
for index,value in [(0,H('wrong','L')),(1,H('wrong','L')),(2,H('wrong','M')),(3,()),(3,(t.ordered_donor_site_occurrences[0],)*2),(4,()),(4,(t.ordered_attachment_traces[0],)*2),(5,())]:
 a=args.copy();a[index]=value
 try:T(*a)
 except exact.InadmissibleExactValue:invalid.append(index)
 else:raise AssertionError('invalid topology accepted')
for index,value in [(2,H('coordination-central-occurrence','other')),(1,H('coordination-ligand-group','other')),(4,(H('positive-coordination-incidence','outside'),t.ordered_attachment_traces[1]))]:
 a=args.copy();a[index]=value
 try:ligand.forced_ligand_denticity_and_chelation(e,T(*a))
 except exact.InadmissibleExactValue:invalid.append(index)
 else:raise AssertionError('invalid binding accepted')
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
guards=0;census={}
for stem,count in [('coordination_entity',20),('coordination_number',23),('ligand_denticity_chelation',24)]:
 d=constants(root/'v3/sft/chemistry'/(stem+'_batch_v1.py'))
 for k,v in d.items():
  if k.endswith('_PATH') and k[:-5]+'_HASH' in d:
   assert 'sha256:'+hashlib.sha256((root/'v3'/v).read_bytes()).hexdigest()==d[k[:-5]+'_HASH'];guards+=1
 for path,h in d['SOURCE_FILES']:
  assert 'sha256:'+hashlib.sha256((root/'v3'/path).read_bytes()).hexdigest()==h;guards+=1
 identities=json.loads((root/'v3'/d['IDENTITY_PATH']).read_text())['rows'];targets=json.loads((root/'v3'/d['TARGET_PATH']).read_text())['rows'];assert len(identities)==len(targets)==count
 for i,(a,z) in enumerate(zip(identities,targets),1):
  assert a['source_record_ordinal']==z['source_record_ordinal']==i and all(z[k]==v for k,v in a.items());assert 'target_payload_hash' not in a and 'source_inscription' not in a
 census[stem]={'records':count,'authorities':{key:sum(x['authority']==key for x in targets) for key in sorted({x['authority'] for x in targets})}}
 if stem=='ligand_denticity_chelation':
  bb={**b,**{n:getattr(ligand,n) for n in ['CompleteLigandDonorTopology','append_donor_site_preserves_topology_and_increments_denticity','forced_ligand_denticity_and_chelation']}}
  v=load('paper26validation','sft/chemistry/ligand_denticity_chelation_validation_v1.py',bb,{'_entity','_topology','exact_ligand_denticity_chelation_analysis'})
  analysis=v.exact_ligand_denticity_chelation_analysis(tuple(targets),json.loads((root/'v3'/d['PRIMARY_PATH']).read_text()));assert len(analysis)==15 and all(bool(val) for k,val in analysis.items());assert analysis['source_class_census']=={'IUPAC':24}
  try:v.exact_ligand_denticity_chelation_analysis(tuple(targets[:-1]),{})
  except ValueError:pass
  else:raise AssertionError('omitted record accepted')
result={'status':'PASS','original_widths_checked':64,'original_entity_successors':63,'original_count_successors':63,'original_denticity_successors':63,'original_constructor_and_membership_rejections':len(invalid),'source_hash_guards':guards,'source_vectors':census,'original_ligand_analysis_fields':len(analysis),'original_ligand_analysis':analysis,'new_lean_builds':0};dest.mkdir(parents=True,exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({k:v for k,v in result.items() if k!='original_ligand_analysis'}))

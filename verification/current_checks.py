"""Shared fresh-build/audit helpers. No SFT Python source is executed."""
from pathlib import Path
import os,re,json,shutil,subprocess,tempfile
PROJECT=Path(__file__).resolve().parents[1]
LAKE=shutil.which('lake') or str(Path.home()/'.elan/bin/lake')
OUTPUT=PROJECT/'verification/current'
OUTPUT.mkdir(exist_ok=True)
def run(*args):
 try:
  return subprocess.check_output([LAKE,*args],cwd=PROJECT,text=True,stderr=subprocess.STDOUT)
 except subprocess.CalledProcessError as e:
  (OUTPUT/'FAILURE.log').write_text(e.output)
  raise RuntimeError(e.output) from e
def source():
 info=json.loads((PROJECT/'reference/SOURCE.json').read_text())
 path=Path(os.environ.get('SFT_V3_SOURCE',info['local_source'])).resolve()
 assert subprocess.check_output(['git','-C',str(path),'rev-parse','HEAD'],text=True).strip()==info['commit'],'V3 commit differs'
 return info,path
def fresh_audit():
 build=run('build');(OUTPUT/'BUILD.log').write_text(build)
 names=[];theorems=[]
 info,src=source()
 correspondence=json.loads((PROJECT/'reference/CORRESPONDENCE.json').read_text())
 mapped={m['module']:m for group in ['modules','host_modules','engine_modules','evidence_modules'] for m in correspondence.get(group,[])}
 import hashlib
 for m in mapped.values():
  original=subprocess.check_output(['git','-C',str(src),'show',info['commit']+':'+m['source_path']])
  assert hashlib.sha256(original).hexdigest()==m['source_sha256'],m['source_path']
  assert hashlib.sha256((PROJECT/m['module']).read_bytes()).hexdigest()==m['lean_source_sha256'],m['module']
 for f in sorted((PROJECT/'SFT').rglob('*.lean')):
  if f.name.startswith('._'):continue
  module=str(f.relative_to(PROJECT));assert module in mapped,module
  s=f.read_text()
  declarations=set(re.findall(r'^\s*(?:def|theorem|structure|inductive) (\w+)',s,re.M))
  assert declarations==set(mapped[module]['implemented']),module+' correspondence declarations differ'
  ns=re.search(r'^namespace (\S+)',s,re.M).group(1)
  assert not re.search(r'^\s*(axiom\s|sorry\b|admit\b|unsafe\s|partial\s)',s,re.M),str(f)
  for kind,n in re.findall(r'^\s*(def|theorem) (\w+)',s,re.M):
   names.append(ns+'.'+n)
   if kind=='theorem':theorems.append(ns+'.'+n)
 audit_source='import SFT\n'+'\n'.join('#print axioms '+n for n in names)+'\n'
 (OUTPUT/'AllDeclarationsAudit.lean').write_text(audit_source)
 audit=run('env','lean',str(OUTPUT/'AllDeclarationsAudit.lean'))
 assert 'depends on axioms:' not in audit and 'error:' not in audit,audit
 assert audit.count('does not depend on any axioms')==len(names)
 (OUTPUT/'ALL_DECLARATIONS_AUDIT.log').write_text(audit)
 return {'definitions_and_theorems':len(names),'native_theorems':len(theorems),'axiom_dependencies':0}

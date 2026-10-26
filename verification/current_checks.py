"""Shared fresh-build/audit helpers. No SFT Python source is executed."""
from pathlib import Path
import os,re,json,shutil,subprocess,tempfile
PROJECT=Path(__file__).resolve().parents[1]
LAKE=shutil.which('lake') or str(Path.home()/'.elan/bin/lake')
OUTPUT=PROJECT/'verification/current'
OUTPUT.mkdir(exist_ok=True)
def run(*args):
 return subprocess.check_output([LAKE,*args],cwd=PROJECT,text=True,stderr=subprocess.STDOUT)
def source():
 info=json.loads((PROJECT/'reference/SOURCE.json').read_text())
 path=Path(os.environ.get('SFT_V3_SOURCE',info['local_source'])).resolve()
 assert subprocess.check_output(['git','-C',str(path),'rev-parse','HEAD'],text=True).strip()==info['commit'],'V3 commit differs'
 return info,path
def fresh_audit():
 build=run('build');(OUTPUT/'BUILD.log').write_text(build)
 names=[];theorems=[]
 for f in sorted((PROJECT/'SFT').rglob('*.lean')):
  if f.name.startswith('._'):continue
  s=f.read_text();ns=re.search(r'^namespace (\S+)',s,re.M).group(1)
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

from pathlib import Path
import json,hashlib,re
w=Path('work');r=w/'constants-recovery';old=json.loads((w/'rotation675_comparison.json').read_text());prior=json.loads((w/'rotation676_comparison.json').read_text())
for report in [old,prior]:
 for path,digest in report['modules'].items():assert hashlib.sha256((r/path).read_bytes()).hexdigest()==digest,path
mods=list(Path(x).stem for x in old['modules'])+json.loads((w/'rotation676_config.json').read_text())['modules']+json.loads((w/'rotation677_config.json').read_text())['modules']+json.loads((w/'matrotation677_audit_config.json').read_text())['modules'];assert len(mods)==23 and len(set(mods))==23
logs=['rotation675_combined_audit.log','rotation676_repair_audit.log','rotation677_audit.log','matrotation677_audit.log'];audit='\n'.join((w/f).read_text() for f in logs);cfg={'modules':mods,'declarations':[],'theorems':[],'definitions_and_theorems':[],'audit_provenance':logs}
for m in mods:
 s=(r/f'SFT/Materials/{m}.lean').read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',s,re.M)
 for kind,n in re.findall(r'^\s*(def|theorem|structure|inductive|abbrev) (\w+)',s,re.M):
  name=f'SFT.Materials.{m}.{n}';assert "'"+name+"' does not depend on any axioms" in audit,name;cfg['declarations'].append(name)
  if kind=='theorem':cfg['theorems'].append(name)
  if kind in ['def','theorem']:cfg['definitions_and_theorems'].append(name)
(w/'matrotation677_combined_config.json').write_text(json.dumps(cfg,indent=2));(w/'matrotation677_combined_audit.log').write_text(audit);print('PASS',len(cfg['declarations']),'declarations',len(cfg['theorems']),'theorems')

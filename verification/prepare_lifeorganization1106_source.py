from pathlib import Path
import sys,json,hashlib,itertools,subprocess
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.biology
sft.biology.__path__=[str((w/'pinned1105/sft/biology').resolve())]+list(sft.biology.__path__)
from sft.biology.sources import BIOLOGY_AUTHORITY_SOURCES,source_corpus,validate_sources
from sft.biology.generated_law import BIOLOGY_SPECS,_source_derived_target
root=Path('/Volumes/One Touch/ernos-labs-sft-platform');stage=w/'pinned1105'
files=[]
for s in BIOLOGY_AUTHORITY_SOURCES:
 b=(root/s.snapshot_path).read_bytes()
 if 'sha256:'+hashlib.sha256(b).hexdigest()!=s.snapshot_hash:
  b=subprocess.check_output(['git','-C',str(root),'show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+s.snapshot_path])
 if 'sha256:'+hashlib.sha256(b).hexdigest()!=s.snapshot_hash:
  b=(w/'biology_snapshot_restored1106.html').read_bytes()
 assert 'sha256:'+hashlib.sha256(b).hexdigest()==s.snapshot_hash
 p=stage/s.snapshot_path;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);files.append({'path':s.snapshot_path,'local':str(p.resolve())})
spec=next(s for s in BIOLOGY_SPECS if s.claim_id=='SFT-BIO-LIFE-ORGANIZATION-001')
try: target={'ok':list(_source_derived_target(stage,spec))}
except ValueError as error: target={'error':str(error)}
cases=[[]]+[[a]for a in range(256)]+[[a,b]for a in range(256)for b in range(256)]
for a in [0xE0,0xE1,0xED,0xEF,0xF0,0xF1,0xF4,0xF5]:
 for b,c,d in itertools.product([0,0x20,0x7F,0x80,0x8F,0x90,0x9F,0xA0,0xBF,0xC0,0xFF],repeat=3):cases.append([a,b,c,d])
texts=['  A\tB  ','<p>A</p>\nB','<>abc<unclosed','A&amp;B','&#32;\t&#160;','&NotEqualTilde; ß İ Σ ς','&#0; &#xD800; &#x110000;','<a\nb> C </a>','&amp;lt;','&notit;','a\r\nb\rc']
import re,html
expected={'decode':[bytes(x).decode('utf8','replace')for x in cases],'corpus':[html.unescape(re.sub(r'\s+',' ',re.sub(r'<[^>]+>',' ',x))).casefold()for x in texts],'sources':[[s.source_id,hashlib.sha256(source_corpus(stage,s.source_id).encode()).hexdigest()]for s in BIOLOGY_AUTHORITY_SOURCES],'target':target}
(w/'lifeorganization1106_source_input.json').write_text(json.dumps({'files':files,'decode_cases':cases,'corpus_cases':texts},ensure_ascii=False)+'\n');(w/'lifeorganization1106_source_expected.json').write_text(json.dumps(expected,ensure_ascii=False)+'\n');print('Prepared',len(cases),'UTF8 cases,',len(texts),'corpus controls,17 complete snapshots,original target; bytes',sum(Path(x['local']).stat().st_size for x in files))

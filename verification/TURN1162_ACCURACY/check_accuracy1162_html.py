from pathlib import Path
import json,sys,hashlib,subprocess,os
from html.parser import HTMLParser
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'accuracy1162_testdeps').resolve()));from bs4 import BeautifulSoup
class P(HTMLParser):
 def __init__(self):super().__init__(convert_charrefs=True);self.events=[]
 def handle_starttag(self,t,a):self.events.append(['start',t])
 def handle_endtag(self,t):self.events.append(['end',t])
 def handle_data(self,s):self.events.append(['data',s])
x=json.loads((w/'accuracy1162_empirical_input.json').read_text());original=next(s for s in x['surfaces']if s['kind']=='html');cases=[original['events']];expected=[original['expected_surface']]
for raw in ['<p>A</p><noscript>B</noscript>','<script>hidden</script><p>A</p><style>hidden</style>','<template>hidden</template><p>A</p>','<p> a\u00adb </p><!--hidden--><p>C &amp; D</p>']:
 p=P();p.feed(raw);cases.append(p.events);t='\n'.join(z.strip()for z in BeautifulSoup(raw,'html.parser').get_text('\n').replace('\u00ad','').splitlines()if z.strip());expected.append([dict(page=1,character_count=len(t),text_sha256='sha256:'+hashlib.sha256(t.encode()).hexdigest())])
(w/'accuracy1162_html_input.json').write_text(json.dumps(cases,ensure_ascii=False))
s='''import SFT.Chemistry.AnalyticalAccuracySource
import Lean
open SFT.Chemistry
open NuclideCarrierSurface
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/accuracy1162_html_input.json"
 let j ← IO.ofExcept (Lean.Json.parse raw)
 let cases ← IO.ofExcept j.getArr?
 let results ← cases.toList.mapM fun c => do
  let rows ← IO.ofExcept c.getArr?
  let events ← rows.toList.mapM fun r => IO.ofExcept (do
   let a ← r.getArr?
   let tag ← a[0]!.getStr?
   let value ← a[1]!.getStr?
   if tag=="start" then return Event.startTag value
   else if tag=="end" then return Event.endTag value
   else return Event.data value)
  return SFT.Host.Canonical.Value.array (AnalyticalAccuracySource.surface "html" [] events)
 IO.println (SFT.Host.Canonical.render (.array results))
''';p=w/'AnalyticalAccuracyHTML1162.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],capture_output=True,text=True,env=env);(w/'accuracy1162_html_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=json.loads(p.stdout);assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b];(w/'accuracy1162_html_report.json').write_text(json.dumps(dict(status='PASS',complete_registered_html=True,additional_cases=4,source_sha256=hashlib.sha256((r/'SFT/Chemistry/AnalyticalAccuracySource.lean').read_bytes()).hexdigest()),indent=2));print('PASS complete registered HTML and4source-specific parser cases')

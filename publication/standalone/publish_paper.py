"""Publish an authorized standalone paper using the existing Zenodo account.

Actions are explicit. Reuse the persisted deposit ID; never create a second
record for an existing paper. Credentials are read locally and never retained.
"""
from pathlib import Path
import argparse,json,urllib.request,urllib.error,urllib.parse,hashlib,re,datetime
parser=argparse.ArgumentParser();parser.add_argument('directory',type=Path);parser.add_argument('action',choices=['create','upload','publish','verify']);a=parser.parse_args();p=a.directory.resolve()
token=(Path.home()/'.config/sft-zenodo/token').read_text().strip()
def call(method,url,data=None,rdm=False):
 payload=json.dumps(data).encode() if isinstance(data,(dict,list)) else data
 headers={'Authorization':'Bearer '+token,'Content-Type':'application/json'}
 if rdm:headers['Accept']='application/vnd.inveniordm.v1+json'
 try:
  with urllib.request.urlopen(urllib.request.Request(url,data=payload,method=method,headers=headers),timeout=180) as response:
   body=response.read();return json.loads(body) if body else None
 except urllib.error.HTTPError as e:raise RuntimeError(str(e.code)+' '+e.read().decode(errors='replace').replace(token,'[REDACTED]')[:1000]) from None
def save(name,d): (p/name).write_text(json.dumps(d,indent=2,ensure_ascii=False)+'\n')
meta=json.loads((p/'ZENODO_METADATA.json').read_text());sp=p/'ZENODO_STATE.json'
if a.action=='create':
 if sp.exists():
  s=json.loads(sp.read_text());print('Existing deposit',s['id'],s['doi']);raise SystemExit
 d=call('POST','https://zenodo.org/api/deposit/depositions',{'metadata':meta});s={'id':d['id'],'doi':d['metadata']['prereserve_doi']['doi'],'status':'draft','created_at':datetime.datetime.now(datetime.timezone.utc).isoformat()};save('ZENODO_STATE.json',s);print(json.dumps(s));raise SystemExit
s=json.loads(sp.read_text());rid=s['id'];base=f'https://zenodo.org/api/deposit/depositions/{rid}';rb=f'https://zenodo.org/api/records/{rid}';names=['SFT_PAPER.pdf','manuscript.md','SOURCE_CORRESPONDENCE.json','SOURCE_AND_EVIDENCE.zip','PUBLICATION_QA.json','ZENODO_METADATA.json'];hashes={n:hashlib.md5((p/n).read_bytes()).hexdigest() for n in names};sha=hashlib.sha256((p/'SFT_PAPER.pdf').read_bytes()).hexdigest();qa=json.loads((p/'PUBLICATION_QA.json').read_text());assert qa['pdf_sha256']==sha and qa['visual_review_passed']
if a.action=='upload':
 d=call('GET',base);assert not d.get('submitted'),'Published record: verify instead of changing deposited files'
 d=call('PUT',base,{'metadata':meta});old={x['filename']:x for x in d['files']}
 for n in names:
  if n in old and old[n]['checksum'].removeprefix('md5:')==hashes[n]:continue
  if n in old:call('DELETE',rb+'/draft/files/'+urllib.parse.quote(n),rdm=True)
  url=d['links']['bucket']+'/'+urllib.parse.quote(n);assert urllib.parse.urlsplit(url).hostname=='zenodo.org'
  with (p/n).open('rb') as data:
   req=urllib.request.Request(url,data=data,method='PUT',headers={'Authorization':'Bearer '+token,'Content-Type':'application/octet-stream','Content-Length':str((p/n).stat().st_size)})
   with urllib.request.urlopen(req,timeout=180) as res:result=json.load(res)
  assert result['checksum'].removeprefix('md5:')==hashes[n];print('Uploaded',n,flush=True)
 draft=call('GET',rb+'/draft',rdm=True);payload={k:draft[k] for k in ['metadata','access','custom_fields','pids'] if k in draft};payload['files']={'enabled':True,'default_preview':'SFT_PAPER.pdf','order':names};draft=call('PUT',rb+'/draft',payload,rdm=True)
 assert draft['files']['default_preview']=='SFT_PAPER.pdf' and set(draft['files']['entries'])==set(names)
 for n in names:assert draft['files']['entries'][n]['checksum'].removeprefix('md5:')==hashes[n]
 save('UPLOAD_VERIFIED.json',{'id':rid,'files':hashes,'pdf_sha256':sha,'default_preview':'SFT_PAPER.pdf','verified':True});print('Upload and default preview verified');raise SystemExit
if a.action=='publish':
 verified=json.loads((p/'UPLOAD_VERIFIED.json').read_text());assert verified['files']==hashes and verified['pdf_sha256']==sha
 d=call('GET',base)
 if not d.get('submitted'):
  draft=call('GET',rb+'/draft',rdm=True);assert draft['files']['default_preview']=='SFT_PAPER.pdf'
  for n in names:assert draft['files']['entries'][n]['checksum'].removeprefix('md5:')==hashes[n]
  result=call('POST',draft['links']['publish'],rdm=True);save('PUBLISHED_RESPONSE.json',result)
public=call('GET',rb,rdm=True);assert public['is_published'] and public['files']['default_preview']=='SFT_PAPER.pdf';assert public['metadata']['title']==meta['title'];assert public['metadata']['creators'][0]['person_or_org']['name']=='Smith, Maria';assert public['pids']['doi']['identifier']==s['doi']
for n in names:assert public['files']['entries'][n]['checksum'].removeprefix('md5:')==hashes[n]
url=f'https://zenodo.org/records/{rid}';html=urllib.request.urlopen(url,timeout=90).read().decode();(p/'PUBLIC_LANDING.html').write_text(html);m=re.search(r'id="preview-file-title">([^<]+)',html);assert m and m.group(1)=='SFT_PAPER.pdf';download=urllib.request.urlopen(url+'/files/SFT_PAPER.pdf?download=1',timeout=90).read();assert hashlib.sha256(download).hexdigest()==sha
receipt={'status':'PUBLISHED_VERIFIED','paper_id':int(p.name.split('-')[0]),'record_id':rid,'doi':s['doi'],'url':url,'public_default_preview':m.group(1),'public_pdf_sha256':sha,'uploaded_files':names,'all_remote_checksums_match':True,'title_and_author_verified':True,'checked_at':datetime.datetime.now(datetime.timezone.utc).isoformat()};save('PUBLICATION_RECEIPT.json',receipt);s['status']='published';save('ZENODO_STATE.json',s);print(json.dumps(receipt))

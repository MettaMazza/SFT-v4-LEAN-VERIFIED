from pathlib import Path
import json
w=Path('work');stage=w/'pinned1163'
class Decimal:
 def __init__(self,spelling):self.spelling=spelling
def encode(x):
 if isinstance(x,Decimal):return ['decimal',x.spelling]
 if x is None:return ['null']
 if isinstance(x,bool):return ['boolean',x]
 if isinstance(x,int):return ['integer',x]
 if isinstance(x,str):return ['text',x]
 if isinstance(x,list):return ['array',[encode(y)for y in x]]
 return ['object',[[k,encode(v)]for k,v in x.items()]]
p=w/'xray1163_empirical_input.json';data=json.loads(p.read_text());base='experiments/external_sources/chemistry/snapshots/anal-012-022-whole-subfield-v1/'
for name,rel in [('analysis','complete-postseal-analysis-v1.json'),('ocr','nist-srm-674-xray-intensity-set-apple-vision-ocr.json')]:
 raw=(stage/base/rel).read_text();data[name+'_document']=encode(json.loads(raw,parse_float=Decimal));data.pop(name,None)
p.write_text(json.dumps(data,ensure_ascii=False))
p=w/'XrayDiffractionValidationProgram1163.lean';s=p.read_text();a=s.index('set_option maxRecDepth');decoder='''def decodeDocument : Nat → Lean.Json → Except String XrayDiffractionJSON.Document
 | 0,_ => .error "document nesting exceeds input byte count"
 | n+1,j => do
  let a ← j.getArr?
  let tag ← a[0]!.getStr?
  if tag=="null" then return .scalar .null
  else if tag=="text" then return .scalar (.text (← a[1]!.getStr?))
  else if tag=="integer" then return .scalar (.integer (← a[1]!.getInt?))
  else if tag=="boolean" then return .scalar (.boolean (← a[1]!.getBool?))
  else if tag=="decimal" then return .decimal (← a[1]!.getStr?)
  else if tag=="array" then
   let xs ← a[1]!.getArr?
   return .array (← xs.toList.mapM (decodeDocument n))
  else if tag=="object" then
   let fs ← a[1]!.getArr?
   return .object (← fs.toList.mapM fun field => do
    let pair ← field.getArr?
    return (← pair[0]!.getStr?,← decodeDocument n pair[1]!))
  else throw "unknown external document node"

''';s=s[:a]+decoder+s[a:];s=s.replace('field input "analysis" >>= convert','field input "analysis_document" >>= decodeDocument').replace('let ocr ← IO.ofExcept (field input "ocr" >>= convert','let ocrDocument ← IO.ofExcept (field input "ocr_document" >>= decodeDocument');s=s.replace(' let files ←',' let ocr := XrayDiffractionJSON.view ocrDocument\n let files ←');p.write_text(s)

from pathlib import Path
import sys,json,itertools,dataclasses
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_defect1488/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.defect_nonstoichiometry_law_v1 import defect_state
from sft.engine.exact import PositiveCount
from sft.claim_evidence.fold_language import EmptyOne,EMPTY_ONE
q=lambda x:json.dumps(x,ensure_ascii=False)
def encode(x):
 if isinstance(x,PositiveCount):return x.value
 if isinstance(x,EmptyOne):return {'emptyOne':x.identity}
 if dataclasses.is_dataclass(x):return {f.name:encode(getattr(x,f.name))for f in dataclasses.fields(x)}
 if isinstance(x,(tuple,list)):return [encode(z)for z in x]
 return x
cases=[]
for obs in itertools.product(['A','B','C',EMPTY_ONE],repeat=3):
 for extra in [(),('A',),('Z',)]:cases.append(('M',('A','A','B'),obs,extra))
for sp in ['', ' ', 'α', 'A#1','A##B','0']:
 cases.append(('M',(sp,),(sp,),()))
for obj in [0,False,None,3.5,(),['A']]:cases.append(('M',('A',),(obj,),()))
cases += [('M',(),(),()),('',('A',),('A',),()),('M',('A',),(),()),('M',('A',),(EmptyOne('custom'),),('A',)),('M',('A',),('A',),('',))]
expected=[];expr=[]
for motif,ref,obs,extra in cases:
 try:expected.append({'ok':encode(defect_state(motif,ref,obs,extra))})
 except Exception as e:expected.append({'error':str(e)})
 ls=lambda xs:'['+','.join(q(x)for x in xs)+']'
 obslean='['+','.join('.emptyOne '+q(x.identity)if isinstance(x,EmptyOne)else '.text '+q(str(x))for x in obs)+']'
 expr.append('result (defectState '+q(motif)+' '+ls(ref)+' '+obslean+' '+ls(extra)+')')
header='''import SFT.Chemistry.DefectChemistry
import SFT.Host.Canonical
open SFT.Chemistry.DefectChemistry SFT.Physics.CapabilityValues SFT.Host
abbrev J := Canonical.Value
def labelJ (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def emptyJ (x : String) : J := .object [("emptyOne",.text x)]
def countJ : CountOrEmpty → J
 | .emptyOne s => emptyJ s | .count n => .nat n.value
def valueJ : Value → J
 | .emptyOne s => emptyJ s | .label x => labelJ x
 | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .text "unsupported"
def refJ (r : ReferenceSite) : J := .object [("site",labelJ r.site),("expected_species",labelJ r.expected)]
def formJ (f : FormulaEntry) : J := .object [("species",labelJ f.species),("count",.nat f.primitiveCount.value)]
def rowJ (r : Reconciliation) : J := .object [("species",labelJ r.species),("reference_count",countJ r.referenceCount),("observed_count",countJ r.observedCount),("missing_support",countJ r.missing),("added_support",countJ r.added)]
def stateJ (s : Defect) : J := .object [
 ("motif",labelJ s.motif),("reference_sites",.array (s.references.map refJ)),
 ("site_occupancies",.array (s.occupancies.map (fun r => .object [("reference",refJ r.reference),("occupant",valueJ r.occupant)]))),
 ("interstitials",.array (s.interstitials.map (fun r => .object [("site",labelJ r.site),("occurrence",labelJ r.occurrence)]))),
 ("reference_formula",.array (s.referenceFormula.map formJ)),("observed_formula",.array (s.observedFormula.map formJ)),
 ("reconciliation",.array (s.reconciliation.map rowJ)),
 ("defect_classes",match s.classes with | .emptyOne x => emptyJ x | .support xs => .array (xs.map labelJ)),
 ("origin_class",valueJ s.origin)]
def result : Except String Defect → J
 | .error e => .object [("error",.text e)] | .ok s => .object [("ok",stateJ s)]
'''
# Canonical numeric constructor matches the established encoding.
header=header.replace('.nat n.value','.integer (.ofNat n.value)').replace('.nat f.primitiveCount.value','.integer (.ofNat f.primitiveCount.value)')
(w/'DefectCasesProgram1488.lean').write_text(header+'\ndef main : IO Unit := IO.println (Canonical.render (.array ['+','.join(expr)+']))\n')
(w/'defect1488_cases_expected.json').write_text(json.dumps(expected,ensure_ascii=False))
s=(w/'check_solidlocal1487_generator.py').read_text().replace('solidlocal1487_generator','defect1488_cases').replace('SolidLocalGeneratorProgram1487','DefectCasesProgram1488').replace("['SolidLocal','SolidLocalGenerator']","['DefectChemistry']")
(w/'check_defect1488_cases.py').write_text(s)
print(len(cases))

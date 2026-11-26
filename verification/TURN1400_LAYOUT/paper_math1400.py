from pathlib import Path
import fcntl,json,hashlib
w=Path('work');r=w/'turn1064_recovery';p=r/'ZENODO_PAPER_DRAFT.txt'
changes={
'G=∏ᵢ₌₁⁸{rᵢ,aᵢ}, with |G|=256':r'\(G=\prod_{i=1}^{8}\{r_i,a_i\}\), with \(|G|=256\)',
'  preserves(c) ⇔ |c|=8 ∧ ∀i∈{1,…,8}, qᵢ∈properties(cᵢ).':r'''\[
\operatorname{preserves}(c)\iff |c|=8\ \land\
\forall i\in\{1,\ldots,8\},\ q_i\in\operatorname{properties}(c_i).
\]''',
'  preserves(c) ⇔ c=(a₁,…,a₈),\n  |{c∈G:preserves(c)}|=1.':r'''\[
\operatorname{preserves}(c)\iff c=(a_1,\ldots,a_8),
\qquad \bigl|\{c\in G:\operatorname{preserves}(c)\}\bigr|=1.
\]''',
'The staged propertyDecisionMatchesCriteria and sourcePropertyDecisionMatches connect':'The theorems propertyDecisionMatchesCriteria and sourcePropertyDecisionMatches connect',
'If A_i={a_i^−,a_i^+} is':r'If \(A_i=\{a_i^-,a_i^+\}\) is',
'The source\'s decision rule compares every candidate with c_*.':r"The source's decision rule compares every candidate with \(c_*\)."
}
with(w/'entry_registration.lock').open('a')as lock:
 fcntl.flock(lock,fcntl.LOCK_EX);old=p.read_text();s=old
 for a,b in changes.items():assert a in s,a;s=s.replace(a,b)
 p.write_text(s)
(w/'paper_math1400_receipt.json').write_text(json.dumps({'before_sha256':hashlib.sha256(old.encode()).hexdigest(),'after_sha256':hashlib.sha256(s.encode()).hexdigest(),'edits':changes,'scope':'Typeset unchanged existing grammar formulas in sections1308/1389; no scientific formula or proof changes'},indent=2)+'\n')
# Refresh only the locked render snapshot; no final-publication metadata is generated.
(w/'pdf_layout1400/MANUSCRIPT_SNAPSHOT.txt').write_text(s)
a=json.loads((w/'pdf_layout1400/source_receipt.json').read_text());a['manuscript_sha256']=hashlib.sha256(s.encode()).hexdigest();(w/'pdf_layout1400/source_receipt.json').write_text(json.dumps(a,indent=2))
print('Typeset existing grammar equations without changing their content')

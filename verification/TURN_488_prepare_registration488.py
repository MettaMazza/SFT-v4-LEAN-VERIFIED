from pathlib import Path
import json
entries=json.load(open('work/field488_entries.json'))
scopes={
'Magnetic':'Original relational transverse role bound to complete electric charge and source-motion records, both held reversal laws, invariant positive charge magnitude and unchanged propagation, full response-ledger transport retention. Transverse is the source-defined response role; no imported metric or cross-product law is asserted.',
'Induction':'Complete linked magnetic before/after records, original closed boundary recurrence and every observed full work transfer; exact boundary recovery, no omitted or additional path record, retained source-change provenance, induced electric charge from the linked source and exact work-normalized potential.',
'Electromagnetic':'Joint source-bound electric/magnetic carrier with exact common charge and linked magnetic observation, full common propagation, two retained response legs per source row, complete projection recovery, source preservation through induction and electric-source transport to the transverse held role.',
'GaugeEquivalence':'Canonical equivalence of complete source, ordered observation and transfer records under changes confined to unobserved description labels; constructive equivalence relation, necessary and sufficient record equality, preservation under arbitrary relabeling and exclusion of changed observable or transfer traces.',
'Locality':'Generated adjacent source-bound propagation with complete event/action trace; every recorded transition satisfies the generated adjacency relation, each noninitial destination retains a predecessor, concatenation preserves the full trace, and completed-accessibility enumeration has neither omitted nor added destinations.'}
s=Path('work/register_field487.py').read_text().replace('487','488')
a=s.index('key=');b=s.index(';low=stem.lower()',a);s=s[:a]+'key='+repr({x[0]:x[1] for x in entries})+'[stem];component='+repr({x[0]:x[2] for x in entries})+'[stem]'+s[b:]
s=s.replace("else 'verification/TURN_486_REGISTERED_DECLARATIONS_AUDIT.log'","else 'verification/TURN_487_REGISTERED_DECLARATIONS_AUDIT.log'")
a=s.index('scopes=');b=s.index('\nfor rel in modules:',a);s=s[:a]+'scopes='+repr(scopes)+s[b:]
s=s.replace('if m==component else','if m==component or m=="FieldMagneticOrientation" else')
s=s.replace('oldrows=73830+(oldtotal-210)*256;rows=oldrows+256',"oldrows=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''));rows=oldrows+256")
a=s.index(" if name=='ZENODO_PAPER_DRAFT.txt':");b=s.index('\n else:',a)
s=s[:a]+''' if name=='ZENODO_PAPER_DRAFT.txt':
  for a,b in [(f'{oldtotal} completed entries',f'{total} completed entries'),(f'{oldtheorems:,} audited theorems',f'{len(oldths)+len(newths):,} audited theorems'),(f'{olddefcount:,} audited definitions',f'{len(olddefs)+len(newdefs):,} audited definitions'),(f'{oldrows:,} records',f'{rows:,} records')]:s=s.replace(a,b)
'''.rstrip()+s[b:]
s=s.replace("if name=='README.md':s=re.sub", "if name=='README.md':\n   s=re.sub(r'\\d+ entr(?:y is|ies are) in progress and [0-9,]+ remain pending',str(cov['summary']['in_progress'])+' entries are in progress and '+format(cov['summary']['pending'],',')+' remain pending',s)\n   s=re.sub")
# Magnetic was already represented; subsequent previously pending rows increase representation.
s=s.replace("(f'{oldtotal+1} represented',f'{total+1} represented'),(f'across {oldtotal+1} source entries',f'across {total+1} source entries'),", "(f'{oldtotal+oldprogress} represented',f\"{total+cov['summary']['in_progress']} represented\"),(f'across {oldtotal+oldprogress} source entries',f\"across {total+cov['summary']['in_progress']} source entries\"),")
s=s.replace("s=head+s[split:]", "s=head+s[split:]")
Path('work/register_field488.py').write_text(s);compile(s,'register_field488','exec')

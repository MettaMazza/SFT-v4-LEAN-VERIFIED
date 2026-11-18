from pathlib import Path
import subprocess,json,datetime
w=Path('work')
commands=['check_evolution1183_program.py', 'prepare_heritability1184_reuse.py', 'build_heritability1184.py', 'build_heritability1184_interfaces.py', 'check_heritability1184_resolved.py', 'check_heritability1184_program.py', 'prepare_differential1185_reuse.py', 'build_differential1185.py', 'build_differential1185_interfaces.py', 'check_differential1185_resolved.py', 'check_differential1185_program.py', 'prepare_selection1186_reuse.py', 'build_selection1186.py', 'build_selection1186_interfaces.py', 'check_selection1186_resolved.py', 'check_selection1186_program.py', 'prepare_fixation1187_reuse.py', 'build_fixation1187.py', 'build_fixation1187_interfaces.py', 'check_fixation1187_resolved.py', 'check_fixation1187_program.py', 'prepare_drift1188_reuse.py', 'build_drift1188.py', 'build_drift1188_interfaces.py', 'check_drift1188_resolved.py', 'check_drift1188_program.py']
for name in commands:
 print('START '+name,flush=True)
 (w/'resume1179_evolution_cursor.json').write_text(json.dumps(dict(command=name,started=datetime.datetime.now(datetime.timezone.utc).isoformat())))
 subprocess.run(['python3','work/'+name],check=True)
 print('PASS '+name,flush=True)

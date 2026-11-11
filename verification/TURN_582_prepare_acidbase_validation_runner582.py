from pathlib import Path
p=Path('work/check_acidbase_validation582.py');s=p.read_text()
s=s.replace("s+='def main : IO Unit", "documents=json.loads(registry)['observations'][0]['support_documents'];snapshots=[]\nfor d in documents:\n text=raw(d['snapshot_path']);snapshots.append('⟨⟨'+q(d['snapshot_path'])+',('+q(text)+').toUTF8,'+cv(json.loads(text))+'⟩,\"\"⟩')\ns+='def main : IO Unit")
s=s.replace("'[⟨'", "'[⟨'") if False else s
old="[⟨'+q(ref.snapshot_path)+',('+q(source)+').toUTF8,document⟩]"
s=s.replace(old,"['+','.join(snapshots)+']")
p.write_text(s)

## (ro) versus (rw)
Das ist eigentlich genau der Standardfall bei GitHub:
	•	Wenn du ein öffentliches Repo anlegst, kann jeder den Code ansehen und klonen (downloaden).
	•	Schreiben (commits, pushen) kann aber nur, wer Schreibrechte im Repo hat – also du selbst (und evtl. Leute, die du als Collaborator einlädst).

Das heißt:
	•	Ohne Einladung kann niemand fremd direkt Änderungen pushen.
	•	Wenn du Pull Requests erlaubst, können andere Vorschläge machen – du entscheidest, ob die übernommen werden.
	•	Wenn du gar keine Pull Requests willst: einfach in den Repo-Einstellungen unter Settings → General → Pull Requests die Option „Allow forking and pull requests“ anpassen bzw. forks deaktivieren (geht nur bei Organisationen, bei privaten Repos). Bei normalen Public Repos können Leute zwar forken, aber das ändert nichts an deinem Repo – ihr Fork ist eine eigene Kopie.

👉 Fazit:
Du musst nichts Spezielles einstellen. Ein Public Repo ist automatisch read-only für alle außer dir (und deinen Kollaboratoren).

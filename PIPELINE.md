# Actual implemented scope

Public UI + Cloudflare Worker + R2 shared result storage.
OPENAI_API_KEY is a runtime secret, never included in source.
Official PE PDF for 2026-11-13 was downloaded with curl from the URL observed in the official portal. pdfinfo confirmed 18 pages; pdftotext -raw extracted all physical pages. Script scripts/extract-pdf.sh reproduces extraction from the downloaded PDF. Original full PDF is served to allow verification.

/api/analyze processes a fixed verified edition, three pages per job (plus continuation context), using gpt-4.1 on extracted text. JSON includes page references and separates summaries/editorial analysis. Six conditional R2 locks limit chargeable calls; successful results are reused. Source mismatch, incomplete response and coverage failures are visible. Complete status is model-declared coverage, NOT an independent proof that every act was found. Exact quote matching flags unlocated evidence.

No daily scheduler or universal scraper implemented. No private uploads accepted. Other sources were examined in the cloud browser and the latest listing did not contain today's edition. Source statuses are timestamped snapshots, not live verification.

First PDF multimodal mini model test produced incorrect document associations. Those results were withdrawn into an inaccessible previous cache namespace. Text-based gpt-4.1 pipeline replaces it. Do not expose the old namespace through a route.

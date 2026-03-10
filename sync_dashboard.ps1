$ErrorActionPreference = 'Stop'
$srcHtml = 'C:\Users\1\.openclaw\workspace\stock_study\dashboard.html'
$srcJson = 'C:\Users\1\.openclaw\workspace\stock_study\dashboard-data.json'
$repo = 'C:\Users\1\.openclaw\workspace\publish\stock-study-dashboard'
$dstHtml = Join-Path $repo 'index.html'
$dstJson = Join-Path $repo 'dashboard-data.json'

Copy-Item $srcHtml $dstHtml -Force
Copy-Item $srcJson $dstJson -Force

$changes = git -C $repo status --porcelain
if (-not $changes) {
  Write-Output 'NO_CHANGES'
  exit 0
}

git -C $repo add index.html dashboard-data.json
$ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
git -C $repo commit -m "Sync dashboard $ts"
git -C $repo push origin main
Write-Output 'SYNCED'

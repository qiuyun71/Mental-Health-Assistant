# 清理误同步到 C:\Users\wxh36\.qoder\extensions 的 34 个 Trae 插件，恢复到同步前状态
$ErrorActionPreference = 'Stop'
$dst = 'C:\Users\wxh36\.qoder\extensions'
$src = 'C:\Users\wxh36\.trae-cn\extensions'

# 同步前该目录原有的插件（保留清单，绝不删除）
$keep = @(
    'detachhead.basedpyright-1.31.6',
    'ms-python.autopep8-2025.2.0',
    'ms-python.debugpy-2025.14.0-win32-x64',
    'ms-python.python-2025.16.0-win32-x64',
    'ms-python.vscode-python-envs-1.8.0-win32-x64'
)

# 待删除：非隐藏 + 不在保留清单 + 在 Trae 目录中存在同名文件夹（双重校验，防误删）
$del = Get-ChildItem $dst -Directory | Where-Object {
    $_.Name -notlike '.*' -and $keep -notcontains $_.Name -and (Test-Path (Join-Path $src $_.Name))
}

Write-Host "将删除 $($del.Count) 个误同步的插件文件夹:"
$del.Name | ForEach-Object { Write-Host "  x $_" }

if ($del.Count -ne 34) {
    Write-Host "`n[警告] 预期 34 个，实际匹配 $($del.Count) 个，请检查后手动确认是否继续。" -ForegroundColor Yellow
    $ans = Read-Host "继续删除? (y/N)"
    if ($ans -ne 'y') { Write-Host '已取消'; exit 0 }
}

$del | ForEach-Object { Remove-Item $_.FullName -Recurse -Force }

# 还原注册表
Copy-Item "$dst\extensions.json.bak" "$dst\extensions.json" -Force
Write-Host "`nextensions.json 已从备份还原"

# 验证
$json = Get-Content "$dst\extensions.json" -Raw | ConvertFrom-Json
$dirs = (Get-ChildItem $dst -Directory | Where-Object { $_.Name -notlike '.*' }).Name
Write-Host "`n===== 验证 ====="
Write-Host "注册条目数: $($json.Count) (应为 5)"
Write-Host "插件目录数: $($dirs.Count) (应为 5)"
Write-Host "剩余目录:"; $dirs | ForEach-Object { Write-Host "  $_" }
Write-Host "`n清理完成。" -ForegroundColor Green

Add-Type -assembly System.Windows.Forms

Set-Variable cmdArgsFile -Option Constant -Value cmd_args.txt
Set-Variable cmdArgs -Option Constant -Value @(
	@{param = "-3dfx"; desc = "Видео режим Glide"}
	@{param = "-ns"; desc = "Без звука"}
	@{param = "-skiptobnet"; desc = "Сразу войти на сервер"}
	@{param = "-w"; desc = "Оконный режим"}
)

if (Test-Path $cmdArgsFile) {
	$currentArgs = -split (Get-Content $cmdArgsFile)
}

$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.CheckOnClick = $true
$checkedListBox.ThreeDCheckBoxes = $true
$checkedListBox.Dock = [System.Windows.Forms.DockStyle]::Fill
$cmdArgs | % { [void]$checkedListBox.Items.Add("$($_.desc) ($($_.param))", $currentArgs -contains $_.param) }

$buttonSave = New-Object System.Windows.Forms.Button
$buttonSave.Text = "Сохранить"
$buttonSave.DialogResult = [System.Windows.Forms.DialogResult]::OK
$buttonSave.Dock = [System.Windows.Forms.DockStyle]::Bottom

$buttonClose = New-Object System.Windows.Forms.Button
$buttonClose.Text = "Закрыть"
$buttonClose.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$buttonClose.Dock = [System.Windows.Forms.DockStyle]::Bottom

$form = New-Object System.Windows.Forms.Form
$form.Text = "Настройки Diablo II"
$form.AcceptButton = $buttonSave
$form.CancelButton = $buttonClose
$form.Controls.add($checkedListBox)
$form.Controls.add($buttonSave)
$form.Controls.add($buttonClose)
if ($form.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
	Exit
}

($checkedListBox.CheckedIndices | % { $cmdArgs[$_].param }) -join " " `
	| Out-File -FilePath $cmdArgsFile -Encoding ascii -NoNewline

$servers = Get-Content C:\users\amkmatte\desktop\servers.txt
$tbl = @()
$cred = Get-Credential

$servers | %{
    $sesh = New-PSSession -ComputerName $_ -Credential $cred
    If (!$sesh){
        $i = [pscustomobject] @{"Server"=$_;"Service"="Could not connect"}
        $tbl += $i}
    Else {
        $srv = Invoke-Command -Session $sesh -ScriptBlock {Get-Service ccmexec -ErrorAction SilentlyContinue}
        If (!$srv){
            $i = [pscustomobject] @{"Server"=$_;"Service"="Service Not Found"}
            $tbl += $i}
        Else {
            $i = [pscustomobject] @{"Server"=$_;"Service"="Installed"}
            $tbl += $i}}
        }
$tbl | Out-GridView
    
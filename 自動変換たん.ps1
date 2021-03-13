function Convert-ts2mp4 {
  foreach($item in $Global:item_list) {
    if($Global:item_mp4 -contains $item) {
      Write-Host 'もう'$item'.mp4は変換済みかも？';
      continue;
    }
    ffmpeg -hwaccel cuda -threads 4 -c:v mpeg2_cuvid -dual_mono_mode main -i $Global:location$item'.ts' -c:v hevc_nvenc -preset:v llhq -profile:v main -level:v 4.1 -rc:v vbr -f mp4 $Global:location$item'.mp4'
  }
}


if($args.Length -eq 0) {
  # 録画ファイルの場所↓適宜変更して使ってください。パスの後ろに\を入れるのを忘れずに。
  $Global:location = 'C:\Users\hoge\Videos\TV\';
  $Global:item_list = (Get-ChildItem $Global:location'*.ts').BaseName;
  $Global:item_mp4  = (Get-ChildItem $Global:location'*.mp4').BaseName;

  Convert-ts2mp4 -loc $Global:location -list $Global:item_list -mp4 $Global:item_mp4;
} else {
  foreach($arg in $args) {
    $Global:location = '';
    if(Test-Path $arg -PathType Container) {
      $Global:location = $arg+'\';
      $Global:item_list = (Get-ChildItem $Global:location'*.ts').BaseName;
      $Global:item_mp4  = (Get-ChildItem $Global:location'*.mp4').BaseName;
      Convert-ts2mp4 $Global:location $Global:item_list $Global:item_mp4;
    } elseif(Test-Path $arg -PathType Leaf) {
      $extension = [System.IO.Path]::GetExtension($arg);
      if($extension -ne '.ts') {
        Write-Host $arg'はtsファイルじゃないよ';
        continue;
      }
      $Global:location = [System.IO.Path]::GetDirectoryName($arg)+'\';
      $Global:item_list = (Get-ChildItem $arg).BaseName;
      $Global:item_mp4 = (Get-ChildItem $Global:location'*.mp4').BaseName;
      Convert-ts2mp4 $Global:location $Global:item_list $Global:item_mp4;
    }
  }
}


# 完了通知
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

$app = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'

$template = @"
<toast duration="long">
    <visual>
        <binding template="ToastText02">
            <text id="1">自動変換たん</text>
            <text id="2">変換が終わりました！</text>
        </binding>
    </visual>
</toast>
"@

$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($template)
$toast = New-Object Windows.UI.Notifications.ToastNotification $xml
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app).Show($toast);


Read-Host 'Enterを押すと終了します';
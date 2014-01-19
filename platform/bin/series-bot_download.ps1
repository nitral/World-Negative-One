param(
	[String]$url,
	[String]$sink
)

(new-object System.Net.WebClient).DownloadFile("$url", "$sink")
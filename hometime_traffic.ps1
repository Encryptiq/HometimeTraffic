param (
    [string]$Domain
)

$banner = @"

    ██╗  ██╗ ██████╗ ███╗   ███╗███████╗████████╗██╗███╗   ███╗███████╗
    ██║  ██║██╔═══██╗████╗ ████║██╔════╝╚══██╔══╝██║████╗ ████║██╔════╝
    ███████║██║   ██║██╔████╔██║█████╗     ██║   ██║██╔████╔██║█████╗  
    ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝     ██║   ██║██║╚██╔╝██║██╔══╝  
    ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗   ██║   ██║██║ ╚═╝ ██║███████╗
    ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝
                                                                    
        ████████╗██████╗  █████╗ ███████╗███████╗██╗ ██████╗           
        ╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔════╝██║██╔════╝           
           ██║   ██████╔╝███████║█████╗  █████╗  ██║██║                
           ██║   ██╔══██╗██╔══██║██╔══╝  ██╔══╝  ██║██║                
           ██║   ██║  ██║██║  ██║██║     ██║     ██║╚██████╗           
           ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═╝ ╚═════╝           
    [ Traffic generator for when pentesting and trying to blend in ]
        [ The roads tend to be busy during hometime traffic ]
                [ https://github.com/encryptiq ]
                
"@

if (-not $Domain) {
    Write-Output "Specify domain with -Domain https://example.com"
    return
}

$config = @{
    user_agents = @(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
        "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36",
        "Mozilla/5.0 (Linux; Android 13; SM-S901B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Mobile Safari/537.36",
        "Mozilla/5.0 (Linux; Android 13; Pixel 6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Mobile Safari/537.36",
        "Mozilla/5.0 (Linux; Android 12; moto g pure) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Mobile Safari/537.36",
        "Mozilla/5.0 (iPhone14,3; U; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Version/10.0 Mobile/19A346 Safari/602.1",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246",
        "Mozilla/5.0 (X11; CrOS x86_64 8172.45.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.64 Safari/537.36",
        "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)",
        "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)",
        "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
    )
    domain = $Domain
}

$website_link_array = New-Object System.Collections.ArrayList

function extract_wordlist {
    param (
        [PSCustomObject]$config
    )

    $extracted_links = (Invoke-WebRequest -Uri $config.domain).Links.Href | Where-Object { $_ -match $config.domain }

    $website_link_array.Clear()

    foreach ($link in $extracted_links) {
        $website_link_array.Add($link) | Out-Null
    }
}

function send_random_request {
    param (
        [PSCustomObject]$config,
        [string]$user_agent,
        [int]$repeat_count
    )
    
    extract_wordlist -config $config

    $user_agent = $config.user_agents | Get-Random

    $request_url = $website_link_array | Get-Random

    $Green = "`e[32m"
    $White = "`e[97m"
    $Reset = "`e[0m" 
    
    Write-Output "${Green}[${White}+${Green}] Visiting URL${Reset}: ${White}$request_url${Reset}`n`t${Green}User Agent${Reset}: $user_agent"
    
    Invoke-WebRequest -Uri $request_url -UserAgent $user_agent | Out-Null
    
    $user_agent = $null
}

Write-Output $banner

while ($true) {
    send_random_request -config $config -repeat_count 1
}
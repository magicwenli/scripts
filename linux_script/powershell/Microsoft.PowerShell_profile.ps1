set-alias cat        get-content    -Option AllScope
set-alias cd         set-location    -Option AllScope
set-alias clear      clear-host    -Option AllScope
set-alias cp         copy-item    -Option AllScope
set-alias h          get-history    -Option AllScope
set-alias history    get-history    -Option AllScope
set-alias kill       stop-process    -Option AllScope
set-alias lp         out-printer    -Option AllScope
set-alias ls         get-childitem    -Option AllScope
set-alias mount      new-mshdrive    -Option AllScope
set-alias mv         move-item    -Option AllScope
set-alias popd       pop-location    -Option AllScope
set-alias ps         get-process    -Option AllScope
set-alias pushd      push-location    -Option AllScope
set-alias pwd        get-location    -Option AllScope
set-alias r          invoke-history    -Option AllScope
set-alias rm         remove-item    -Option AllScope
set-alias rmdir      remove-item    -Option AllScope
set-alias echo       write-output    -Option AllScope

set-alias cls        clear-host    -Option AllScope
set-alias chdir      set-location    -Option AllScope
set-alias copy       copy-item    -Option AllScope
set-alias del        remove-item    -Option AllScope
set-alias dir        get-childitem    -Option AllScope
set-alias erase      remove-item    -Option AllScope
set-alias move       move-item    -Option AllScope
set-alias rd         remove-item    -Option AllScope
set-alias ren        rename-item    -Option AllScope
set-alias set        set-variable    -Option AllScope
set-alias type       get-content    -Option AllScope

function set_proxy_variable {
	Set-Item Env:http_proxy "http://127.0.0.1:10809"  
	Set-Item Env:https_proxy "http://127.0.0.1:10809" 
}

function unset_proxy_variable {
    Remove-Item Env:http_proxy
    Remove-Item Env:https_proxy
}

New-Alias -Name spp -Value set_proxy_variable
New-Alias -Name upp -Value unset_proxy_variable

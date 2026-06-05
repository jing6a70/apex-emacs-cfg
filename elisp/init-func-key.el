;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key (kbd "<f5>") 'open-e2macs-man)

(global-set-key (kbd "<f6>") 'my/cmake-update-compile-commands)  ; 一键更新 compile_commands.json


(provide 'init-func-key)

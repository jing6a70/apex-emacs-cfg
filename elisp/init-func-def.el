;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun open-e2macs-man()
  (interactive)
  (find-file "~/.emacs.d/README.md"))


;; 一键更新 compile_commands.json（同步运行 cmake + 自动软链）
(defun my/cmake-update-compile-commands ()
  "在项目 build 目录运行 cmake，更新软链，clangd 即刻生效。"
  (interactive)
  (let* ((root (or (locate-dominating-file default-directory "CMakeLists.txt")
                   (user-error "未找到 CMakeLists.txt，不在 CMake 项目中")))
         (build-dir (expand-file-name "build" root))
         (compile-json (expand-file-name "compile_commands.json" build-dir))
         (link-target (expand-file-name "compile_commands.json" root)))
    (unless (file-exists-p build-dir)
      (make-directory build-dir))
    (message "正在运行 cmake ...")
    (let ((default-directory build-dir))
      (let ((ret (call-process (executable-find "cmake") nil "*cmake-output*" nil "..")))
        (if (zerop ret)
            (if (file-exists-p compile-json)
                (progn
                  (delete-file link-target)
                  (make-symbolic-link compile-json link-target)
                  (message "compile_commands.json 已更新 -> clangd 自动生效"))
              (message "cmake 完成，但未生成 compile_commands.json"))
          (message "cmake 失败（exit %d），查看 *cmake-output*" ret))))))

(provide 'init-func-def)

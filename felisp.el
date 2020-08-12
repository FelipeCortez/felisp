;; -*- lexical-binding: t -*-

(defvar felisp-mode-map
  (let ((map (make-sparse-keymap))
        (clj-open '(?\( ?\[ ?\{)))
    (define-key map (kbd "[") (lambda ()
                                (interactive)
                                (sp-backward-up-sexp)))
    (define-key map (kbd "j") (lambda ()
                                (interactive)
                                (if (member (char-after) clj-open)
                                    (progn
                                      (sp-forward-sexp)
                                      (sp-forward-sexp)
                                      (sp-backward-sexp))
                                  (insert "j"))))
    (define-key map (kbd "k") (lambda ()
                                (interactive)
                                (if (member (char-after) clj-open)
                                    (sp-backward-sexp)
                                  (insert "k"))))
    (define-key map (kbd "f") (lambda ()
                                (interactive)
                                (if (member (char-after) clj-open)
                                    (let ((k (read-char "(l) [v] {m}:")))
                                      (cond ((eq k ?l) (avy-goto-char ?\())
                                            ((eq k ?v) (avy-goto-char ?\[))
                                            ((eq k ?m) (avy-goto-char ?\{))
                                            ((eq k ?o) (avy-goto-char (read-char "char:" t)))))
                                  (insert "f"))))
    map))

(define-minor-mode felisp-mode
  :global nil
  :lighter " felisp"
  :keymap felisp-mode-map)

(global-set-key (kbd "C-z") 'felisp-mode)

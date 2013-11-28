;;;; logic.lisp

(in-package #:poem)

(defun ask (formula &rest args &key &allow-other-keys)
  (apply #'snark::new-prove formula args))

(defun tell (formula &rest args &key &allow-other-keys)
  (apply #'snark-user::assert formula args))

;;;; package.lisp

(in-package #:poem-bootstrap)

(defpackage #:poem
  (:use #:common-lisp #:alexandria #:screamer #:snark #:snark-lisp)
  (:shadowing-import-from #:alexandria . #.#. (package-exports-name '#:alexandria))
  (:shadowing-import-from #:snark . #.#. (package-exports-name '#:snark))
  (:export . #.#. (package-exports-name '#:common-lisp))
  (:export . #.#. (package-exports-name '#:alexandria))
  (:export . #.#. (package-exports-name '#:screamer))
  (:export . #.#. (package-exports-name '#:snark))
  (:export . #.#. (package-exports-name '#:snark-lisp)))

(defpackage #:poem-user
  (:use #:common-lisp-user #:poem))

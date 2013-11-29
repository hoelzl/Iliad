;;; -*- Mode: Lisp; common-lisp-style: poem -*-

;;; Copyright (c) 2013 Matthias Hölzl
;;;
;;; This file is licensed under the MIT license; see the file LICENSE in the root directory for
;;; further information.

(in-package #:poem-bootstrap)

(defpackage #:poem
  (:use #:common-lisp #:alexandria #:c2mop #:screamer #:snark #:snark-lisp)
  (:shadowing-import-from #:alexandria . #.#. (package-exports-name '#:alexandria))
  (:shadowing-import-from #:c2mop . #.#. (package-exports-name '#:c2mop))
  (:shadowing-import-from #:iterate . #.#. (package-exports-name '#:iterate))
  (:shadowing-import-from #:snark . #.#. (package-exports-name '#:snark))
  (:export . #.#. (package-exports-name '#:common-lisp))
  (:export . #.#. (package-exports-name '#:alexandria))
  (:export . #.#. (package-exports-name '#:iterate))
  (:export . #.#. (package-exports-name '#:screamer))
  (:export . #.#. (package-exports-name '#:snark))
  (:export . #.#. (package-exports-name '#:snark-lisp)))

(defpackage #:poem-user
  (:use #:common-lisp-user #:poem))

;;; -*- Mode: Lisp; common-lisp-style: poem -*-

;;; Copyright (c) 2013 Matthias Hölzl
;;;
;;; This file is licensed under the MIT license; see the file LICENSE in the root directory for
;;; further information.

(asdf:defsystem #:iliad
  :serial t
  :description "The Implementation of Logical Inference for Adaptive Devices"
  :version "0.0.1"
  :author "Matthias Hoelzl <tc@xantira.com>"
  :license "MIT, see file LICENSE"
  :depends-on (;; GBBOpen is broken on current SBCL (or vice versa).
               ;; #:gbbopen
               ;; #:module-manager
               ;; #:gbbopen-tools
               ;; #:gbbopen-core

               #:alexandria
               #:closer-mop
               #:iterate
               #:screamer
               #:snark
               #:hrl)
  :components ((:module "Core"
                :components ((:file "bootstrap-package")
                             (:file "package-utils")
                             (:file "package-bootstrap")
                             (:file "packages")
                             (:file "utilities")
                             (:file "macros")
                             (:file "compilation-context")
                             (:file "terms")
                             (:file "compilation-unit")
                             (:file "situation")
                             (:file "term-operations")
                             (:file "parser")
                             (:file "snark")
                             (:file "logic")))))


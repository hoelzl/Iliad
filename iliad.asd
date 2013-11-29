;;;; iliad.asd

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
               #:screamer
               #:snark
               #:hrl)
  :components ((:module "Core"
                :components ((:file "bootstrap-package")
                             (:file "package-utils")
                             (:file "package-bootstrap")
                             (:file "packages")
                             (:file "logic")))))


(in-package #:poem-bootstrap)

(locally
  (define-package-exports #:common-lisp)
  (define-package-exports #:alexandria)
  (define-package-exports #:screamer)
  (define-package-exports #:snark
    #:positive-number #:negative-number
    #:positive-real #:negative-real
    #:positive-rational #:negative-rational
    #:positive-integer #:negative-integer)
  (define-package-exports #:snark-lisp))


#lang typed/racket/base

;; TODO (Queueof t) → (Queueof t t)
(struct (w r) Queueof ([_ : (Parameter w r)]))
#;(struct (a ...) _ ([_ : (Parameter a ...)]) #:type-name Queueof) ; not work well
(define-type (Queue w r) (Queueof w r)) ; avoid printing #(struct:Queueof ...)
(provide Queue (rename-out [Queue Queueof]))

(define-type QueueTop (Queue Nothing Any))
(define-type QueueBot (Queue Any Nothing))
(provide QueueTop QueueBot)

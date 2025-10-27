#lang typed/racket/base

;; TODO (Queueof t) → (Queueof t t)
(struct (-t +t) Queueof ([_ : (Parameter -t +t)]))
#;(struct (a ...) _ ([_ : (Parameter a ...)]) #:type-name Queueof) ; not work well
(define-type (Queue -t +t) (Queueof -t +t)) ; avoid printing #(struct:Queueof ...)
(provide Queue (rename-out [Queue Queueof]))

(define-type QueueTop (Queue Nothing Any))
(define-type QueueBot (Queue Any Nothing))
(provide QueueTop QueueBot)

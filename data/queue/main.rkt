#lang typed/racket/base

(require typed/racket/unsafe)

;; TODO (Queueof t) → (Queueof t t)
(struct (w r) Queueof ([_ : (Parameter w r)]))
#;(struct (a ...) _ ([_ : (Parameter a ...)]) #:type-name Queueof) ; not work well
(define-type (Queue w r) (Queueof w r)) ; avoid printing #(struct:Queueof ...)
(provide Queue (rename-out [Queue Queueof]))

(define-type QueueTop (Queue Nothing Any))
(define-type QueueBot (Queue Any Nothing))
(provide QueueTop QueueBot)

(unsafe-require/typed/provide data/queue
  [make-queue (∀ (w r) (→ (Queue w r)))]

  [enqueue! (∀ (w) (→ (Queue w Any) w Void))]
  [enqueue-front! (∀ (w) (→ (Queue w Any) w Void))]
  [dequeue! (∀ (r) (→ (Queue Nothing r) r))]

  [queue->list (∀ (r) (→ (Queue Nothing r) (Listof r)))]
  [queue-length (→ QueueTop Index)]

  [queue? (pred QueueTop)]
  [queue-empty? (→ QueueTop Boolean)]
  [non-empty-queue? (∀ (w r)
                       (case→
                        (→ (Queue w r) Boolean)
                        (→ Any Boolean : #:+ QueueTop)))]

  [in-queue (∀ (r) (→ (Queue Nothing r) (Sequenceof r)))])

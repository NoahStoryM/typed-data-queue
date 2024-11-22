#lang typed/racket/base

(require typed/racket/unsafe)

;; TODO (Queue t) → (Queue t t)
(struct (s t) Queueof ([_ : (Parameter s t)]))
#;(struct (a ...) _ ([_ : (Parameter a ...)]) #:type-name Queue) ; not work well
(define-type (Queue s t) (Queueof s t)) ; avoid printing #(struct:Queueof ...)
(provide Queue (rename-out [Queue Queueof]))

(define-type QueueTop (Queue Nothing Any))
(define-type QueueBot (Queue Any Nothing))
(provide QueueTop QueueBot)

(unsafe-require/typed/provide data/queue
  [make-queue (∀ (s t) (→ (Queue s t)))]

  [enqueue! (∀ (s) (→ (Queue s Any) s Void))]
  [enqueue-front! (∀ (s) (→ (Queue s Any) s Void))]
  [dequeue! (∀ (t) (→ (Queue Nothing t) t))]

  [queue->list (∀ (t) (→ (Queue Nothing t) (Listof t)))]
  [queue-length (→ QueueTop Index)]

  [queue? (pred QueueTop)]
  [queue-empty? (→ QueueTop Boolean)]
  [non-empty-queue? (∀ (s t)
                       (case→
                        (→ (Queue s t) Boolean)
                        (→ Any Boolean : #:+ QueueTop)))]

  [in-queue (∀ (t) (→ (Queue Nothing t) (Sequenceof t)))])

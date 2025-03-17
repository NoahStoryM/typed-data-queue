#lang typed/racket/base

(require typed/racket/unsafe
         "private/types.rkt")

(provide (all-from-out "private/types.rkt"))

(unsafe-require/typed/provide data/queue
  [make-queue (∀ (t) (→ (Queue t t)))]

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

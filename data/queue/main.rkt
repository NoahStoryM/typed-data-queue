#lang typed/racket/base/optional

(require "private/types.rkt")

(provide (all-from-out "private/types.rkt"))

(require/typed/provide data/queue
  [make-queue (∀ (t) (→ (Queue t t)))]

  [enqueue! (∀ (w) (→ (Queue w Any) w Void))]
  [enqueue-front! (∀ (w) (→ (Queue w Any) w Void))]
  [dequeue! (∀ (r) (→ (Queue Nothing r) r))]

  [queue->list (∀ (r) (→ (Queue Nothing r) (Listof r)))]
  [queue-length (→ QueueTop Index)]

  [queue? (pred QueueTop)]
  [queue-empty? (→ QueueTop Boolean)]
  [non-empty-queue? (case→
                     (→ QueueTop Boolean)
                     (→ Any Boolean : #:+ QueueTop))]

  [in-queue (∀ (r) (→ (Queue Nothing r) (Sequenceof r)))])

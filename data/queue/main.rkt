#lang typed/racket/base/optional

(require "private/types.rkt")

(provide (all-from-out "private/types.rkt"))

(require/typed/provide data/queue
  [make-queue (∀ (t) (→ (Queue t t)))]

  [enqueue! (∀ (-t) (→ (Queue -t Any) -t Void))]
  [enqueue-front! (∀ (-t) (→ (Queue -t Any) -t Void))]
  [dequeue! (∀ (+t) (→ (Queue Nothing +t) +t))]

  [queue->list (∀ (+t) (→ (Queue Nothing +t) (Listof +t)))]
  [queue-length (→ QueueTop Index)]

  [queue? (pred QueueTop)]
  [queue-empty? (→ QueueTop Boolean)]
  [non-empty-queue? (case→
                     (→ QueueTop Boolean)
                     (→ Any Boolean : #:+ QueueTop))]

  [in-queue (∀ (+t) (→ (Queue Nothing +t) (Sequenceof +t)))])

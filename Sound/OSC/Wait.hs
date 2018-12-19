-- | Waiting (for replies).
module Sound.OSC.Wait where

import System.Timeout {- base -}

-- * Timeout

-- | Variant of 'timeout' where time is given in fractional seconds.
timeout_r :: Double -> IO a -> IO (Maybe a)
timeout_r = timeout . floor . (* 1000000)

-- * Wait

-- | Repeat action until predicate /f/ is 'True' when applied to result.
untilPredicate :: Monad m => (a -> Bool) -> m a -> m a
untilPredicate f act =
    let g p = if f p then recur else return p
        recur = act >>= g
    in recur

-- | Repeat action until /f/ does not give 'Nothing' when applied to result.
untilMaybe :: Monad m => (a -> Maybe b) -> m a -> m b
untilMaybe f act =
    let g p = maybe recur return (f p)
        recur = act >>= g
    in recur

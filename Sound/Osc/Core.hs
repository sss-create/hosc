{- | Composite of non-transport related modules.

Provides the 'Datum', 'Message', 'Time', 'Bundle' and 'Packet' types
and the coding functions 'encodePacket' and 'decodePacket'.

> import Sound.Osc.Core {- hosc -}
>
> let o = bundle immediately [message "/g_free" [Int32 0]]
> let e = encodeBundle o
> decodePacket e == Packet_Bundle o

-}
module Sound.Osc.Core (module M) where

import Sound.Osc.Coding.Decode.Binary as M
import Sound.Osc.Coding.Encode.Builder as M
import Sound.Osc.Datum as M
import Sound.Osc.Datum.Parse as M
import Sound.Osc.Datum.Pp as M
import Sound.Osc.Packet as M
import Sound.Osc.Packet.Pp as M
import Sound.Osc.Time as M
import Sound.Osc.Time.Pp as M
import Sound.Osc.Time.System as M
import Sound.Osc.Time.Thread as M
import Sound.Osc.Time.Thread.MonadIO as M
import Sound.Osc.Wait as M

-- | Osc over Udp/Tcp implementation.
module Sound.Osc.Transport.Fd.Socket where

import qualified Sound.Osc.Transport.Fd as Fd {- hosc -}
import qualified Sound.Osc.Transport.Fd.Tcp as Fd.Tcp {- hosc -}
import qualified Sound.Osc.Transport.Fd.Udp as Fd.Udp {- hosc -}

-- | Protocol, either Udp or Tcp
data OscProtocol = Udp | Tcp
  deriving (Eq, Read, Show)

-- | Hostname
type OscHostname = String

-- | Port number
type OscPort = Int

-- | Socket address
type OscSocketAddress = (OscProtocol, OscHostname, OscPort)

-- | Socket
data OscSocket = OscUdpSocket Fd.Udp.Udp | OscTcpSocket Fd.Tcp.Tcp

-- | Open socket at address
openOscSocket :: OscSocketAddress -> IO OscSocket
openOscSocket address =
  case address of
    (Tcp, hostname, port) -> fmap OscTcpSocket (Fd.Tcp.openTcp hostname port)
    (Udp, hostname, port) -> fmap OscUdpSocket (Fd.Udp.openUdp hostname port)

-- | 'OscSocket' is an instance of 'Fd.Transport'.
instance Fd.Transport OscSocket where
  sendPacket (OscTcpSocket fd) = Fd.Tcp.tcp_send_packet fd
  sendPacket (OscUdpSocket fd) = Fd.Udp.udp_send_packet fd
  recvPacket (OscTcpSocket fd) = Fd.Tcp.tcp_recv_packet fd
  recvPacket (OscUdpSocket fd) = Fd.Udp.udp_recv_packet fd
  recvPacketOrFail (OscTcpSocket fd) = Fd.Tcp.tcp_recv_packet_or_fail fd
  recvPacketOrFail (OscUdpSocket fd) = Fd.Udp.udp_recv_packet_or_fail fd
  close (OscTcpSocket fd) = Fd.Tcp.tcp_close fd
  close (OscUdpSocket fd) = Fd.Udp.udp_close fd

sealed class GlobalEvents{}

final class ConnectedEvent extends GlobalEvents{}

final class DisconnectedEvent extends GlobalEvents{}

enum ConnectionStatus{
  connected, disconnected
}
//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: game.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `SpeedTacToeClient`, then call methods of this protocol to make API calls.
internal protocol SpeedTacToeClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: SpeedTacToeClientInterceptorFactoryProtocol? { get }

  func findGame(
    _ request: GameSearchHandshake,
    callOptions: CallOptions?
  ) -> UnaryCall<GameSearchHandshake, GameFoundHandshake>

  func connect(
    callOptions: CallOptions?,
    handler: @escaping (GameState) -> Void
  ) -> BidirectionalStreamingCall<Move, GameState>
}

extension SpeedTacToeClientProtocol {
  internal var serviceName: String {
    return "SpeedTacToe"
  }

  /// Unary call to FindGame
  ///
  /// - Parameters:
  ///   - request: Request to send to FindGame.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func findGame(
    _ request: GameSearchHandshake,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<GameSearchHandshake, GameFoundHandshake> {
    return self.makeUnaryCall(
      path: "/SpeedTacToe/FindGame",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeFindGameInterceptors() ?? []
    )
  }

  /// Bidirectional streaming call to Connect
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
  internal func connect(
    callOptions: CallOptions? = nil,
    handler: @escaping (GameState) -> Void
  ) -> BidirectionalStreamingCall<Move, GameState> {
    return self.makeBidirectionalStreamingCall(
      path: "/SpeedTacToe/Connect",
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectInterceptors() ?? [],
      handler: handler
    )
  }
}

internal protocol SpeedTacToeClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'findGame'.
  func makeFindGameInterceptors() -> [ClientInterceptor<GameSearchHandshake, GameFoundHandshake>]

  /// - Returns: Interceptors to use when invoking 'connect'.
  func makeConnectInterceptors() -> [ClientInterceptor<Move, GameState>]
}

internal final class SpeedTacToeClient: SpeedTacToeClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: SpeedTacToeClientInterceptorFactoryProtocol?

  /// Creates a client for the SpeedTacToe service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: SpeedTacToeClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}


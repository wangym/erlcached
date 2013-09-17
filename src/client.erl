%% Author: yumin
%% Created: 2010-2-1
%% Description: TODO: Add description to client
-module(client).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([send/1]).

%%
%% API Functions
%%



%%
%% Local Functions
%%
send(Str) ->
	{ok, Socket} = gen_tcp:connect("localhost", 1983, [binary, {packet, 0}]),
	gen_tcp:send(Socket, Str),
	receive
		{tcp, Socket, Bin} ->
			io:format("bin: ~p~n", [Bin]),
			List = binary_to_list(Bin),
			io:format("list: ~p~n", [List]);
		{tcp_closed, Socket} ->
			io:format("tcp_closed client ~n")
	end.
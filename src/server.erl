%% Author: yumin
%% Created: 2010-2-1
%% Description: TODO: Add description to entry
-module(server).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([start/0]).

%%
%% API Functions
%%



%%
%% Local Functions
%%
start() ->
	case gen_tcp:listen(1983, [binary,
							   {packet, 0},
							   {reuseaddr, true},
							   {active, once}]) of
		{ok, Listen} ->
			spawn(fun() -> start_accept(Listen) end);
		{error, Reason} ->
			io:format("gen_tcp:listen error ~p~n", [Reason])
	end.

%%
%% 
%%
start_accept(Listen) ->
	case gen_tcp:accept(Listen) of
		{ok, Socket} ->
			spawn(fun() -> start_accept(Listen) end),
			receive_loop(Socket);
		_ ->
			io:format("gen_tcp:accept exit ~n"),
			exit(oops)
	end.

%%
%% 
%%
receive_loop(Socket) ->
	receive
		{tcp, Socket, Bin} ->
			Str = binary_to_list(Bin),
			Result = ets_operate(Str),
			gen_tcp:send(Socket, Result),
			inet:setopts(Socket, [{active, once}]),
			receive_loop(Socket);
		{tcp_closed, Socket} ->
			io:format("tcp_closed server ~n")
	end.

%%
%% 
%%
ets_operate(Str) ->
	List = string:tokens(Str, " "),
	S_action = lists:nth(1, List),
	case S_action of
		"set" ->
			db:init(),
			S_key = lists:nth(2, List),
			S_val = lists:nth(3, List),
			db:insert(S_key, S_val);
		"get" ->
			S_key = lists:nth(2, List),
			db:select(S_key);
		_ ->
			io:format("unkown action ~n")
	end,
	Result = string:concat(S_action, " ok\r\n"),
	Result.

%% Author: yumin
%% Created: 2010-2-1
%% Description: TODO: Add description to db
-module(db).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([init/0, insert/2, select/1]).

%%
%% API Functions
%%



%%
%% Local Functions
%%
init() ->
	io:format("init ~p~n", [ets:new(?MODULE, [set, named_table])]).

%%
%% 
%%
insert(S_key, S_val) ->
	io:format("insert key ~p~n", [S_key]),
	io:format("insert val ~p~n", [S_val]),
	io:format("insert ~p~n", [ets:insert(?MODULE, {S_key, S_val})]).

%%
%% 
%%
select(S_key) ->
	io:format("insert key ~p~n", [S_key]),
	io:format("lookup ~p~n", [ets:lookup(?MODULE, S_key)]).

%% Author: yumin
%% Created: 2010-2-1
%% Description: TODO: Add description to util
-module(util).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([string2value/1]).

%%
%% API Functions
%%



%%
%% Local Functions
%%
string2value(Str) ->
	{ok, Tokens, _} = erl_scan:string(Str ++ "."),
	{ok, Exprs} = erl_parse:parse_exprs(Tokens),
	Bindings = erl_eval:new_bindings(),
	{value, Value, _} = erl_eval:exprs(Exprs, Bindings),
	Value.

%%% Public API %%%
-module(wrkr).

-export([create/2]).
-define(FACTORY, wrkr_sup).

create(Type, Payload) ->
	io:format("Created task ~p ~p ~n", [Type, Payload]),
	?FACTORY:start_child(Type, Payload).

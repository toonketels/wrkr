-module(wrkr_sup).
-behaviour(supervisor).

-export([start_link/0, start_child/1]).
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_child(Name) ->
	supervisor:start_child(?SERVER, [Name]).

init([]) ->
	ChildSpecs = [{wrkr_queue_sup, {wrkr_queue_sup, start_link, []},
	               permanent, 2000, supervisor, [wrkr_queue_sup]}],
	RestartStrategy = {simple_one_for_one, 1, 5},
	{ok, {RestartStrategy, ChildSpecs}}.


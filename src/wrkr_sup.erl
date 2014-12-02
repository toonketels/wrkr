-module(wrkr_sup).
-behaviour(supervisor).

-export([start_link/0, start_child/2]).
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
	supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_child(Type, Payload) ->
	supervisor:start_child(?SERVER, [{Type, Payload}]).

init([]) ->
	ChildSpecs = [{wrkr_job, {wrkr_job, start_link, []},
	               permanent, 2000, worker, [wrkr_job]}],
	RestartStrategy = {simple_one_for_one, 1, 5},
	{ok, {RestartStrategy, ChildSpecs}}.


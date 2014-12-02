%%% Supervises a given queue %%%
-module(wrkr_queue_sup).
-behaviour(supervisor).

-export([start_link/1]).
-export([init/1]).

start_link(Name) ->
	io:format("sup ~p", [Name]),
	% @todo: change because we use Names to be registered in atom table
	supervisor:start_link({local, Name}, ?MODULE, [Name]).

init([Name]) ->
	ChildSpecs = [{wrkr_queue, {wrkr_queue, start_link, [Name]},
	               permanent, 2000, worker, [wrkr_queue]},
	              {wrkr_job_sup, {wrkr_job_sup, start_link, [Name]},
	               permanent, 2000, supervisor, [wrkr_job_sup]}],
	RestartStrategy = {one_for_one, 1, 5},
	{ok, {RestartStrategy, ChildSpecs}}.
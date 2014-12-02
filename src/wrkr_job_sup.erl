%%% Supervises a given queue %%%
-module(wrkr_job_sup).
-behaviour(supervisor).

-export([start_link/1, start_child/3]).
-export([init/1]).

start_link(Name) ->
	io:format("job supervisor ~p ~n", [Name]),
	% @todo: change because we use Names to be registered in atom table
	Name1 = list_to_atom(atom_to_list(Name) ++ "_job_sup"),
	supervisor:start_link({local, Name1}, ?MODULE, [Name1]).


init([Name]) ->
	io:format("JOB SUP ~p~n", [Name]),
	ChildSpecs = [{wrkr_job, {wrkr_job, start_link, []},
	               permanent, 2000, worker, [wrkr_job]}],
	RestartStrategy = {simple_one_for_one, 1, 5},	
	{ok, {RestartStrategy, ChildSpecs}}.

start_child(QueueName, Type, Payload) ->
	supervisor:start_child(QueueName, [{Type, Payload}]).
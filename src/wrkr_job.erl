%%% A job to be performed
-module(wrkr_job).
-behaviour(gen_fsm).

%% Public API
-export([start_link/1]).

%% gen_fsm callbacks
-export([init/1, terminate/3, code_change/4, handle_event/3, handle_info/3, handle_sync_event/4]).

%% States
-export([wait/2, wait/3]).

-record(state, {name,payload}).



%Public api

start_link(Args) ->
	io:format("start link ~p ~n", [Args]),
	gen_fsm:start_link(?MODULE, [Args], []).



wait(Event, State) ->
	io:format("Wait ~p ~p~n", [Event, State]),
	{next_state, wait, State}.

wait(Event, From, State) ->
	io:format("Wait ~p ~p ~p~n", [Event, From, State]),
	Reply = ok,
	{reply, Reply, wait, State}.



% Gen_fsm callbacks and states
init([{Name, Payload}]) ->
	{ok, wait, #state{name=Name, payload=Payload}}.

handle_event(Event, StateName, State) ->
	io:format("Handle event ~p ~p ~p ~n", [Event, StateName, State]),
	{next_state, StateName, State}.

handle_sync_event(Event, From, StateName, State) ->
	io:format("Handle sync event ~p ~p ~p ~p ~n", [Event, From, StateName, State]),
	Reply = ok,
	{reply, Reply, StateName, State}.

handle_info(Info, StateName, State) ->
	io:format("Handle info ~p ~p ~p ~n", [Info, StateName, State]),
	{next_state, StateName, State}.

terminate(Reason, StateName, State) ->
	io:format("Terminate ~p ~p ~p", [Reason, StateName, State]),
	ok.

code_change(OldVsn, StateName, State, Extra) ->
	io:format("Code change ~p ~p ~p ~p ~n", [OldVsn, StateName, State, Extra]),
	{ok, StateName, State}.


% Private functions





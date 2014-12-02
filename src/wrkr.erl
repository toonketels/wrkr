%%% Public API %%%
-module(wrkr).

-export([create_queue/1, create_job/3]).

create_queue(Name) ->
	io:format("Created queue ~p ~n", [Name]),
	wrkr_sup:start_child(Name).

% @TODO: better to register the queue worker as a global and
%        send it messages so it will ask it sup to create 
%        the jobs , getting the pid to be able to add it
%        to its priority queue data structure
create_job(Queue, Type, Payload) ->
	io:format("Created task ~p ~p ~p ~n", [Queue, Type, Payload]),
	QueueName = list_to_atom(atom_to_list(Queue) ++ "_job_sup"),
	wrkr_job_sup:start_child(QueueName, Type, Payload).

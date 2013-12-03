-module(prop_substr).

-include_lib("proper/include/proper.hrl").

% faulty property
generator_function() -> 
	?LET(S, non_empty(list(integer(10,255))),
		?LET(Start, range(0,length(S)-1), 
			 ?LET(Stop, range(Start, length(S)-1), 
				 {S, Start+1, Stop+1}))).

prop_com_ref() ->
	?FORALL({S, Start, Stop}, generator_function(),
				 nifty:cstr_to_list(
					 strstr:strstr(
						 nifty:list_to_cstr(S),
						 nifty:list_to_cstr(string:sub_string(S, Start, Stop)))) =:= string:sub_string(S, Start)
				 ).
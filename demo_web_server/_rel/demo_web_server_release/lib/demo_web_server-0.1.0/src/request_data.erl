-module(request_data).
-behavior(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
	Req = cowboy_req:reply(200,
		#{<<"content-type">> => <<"application/json">>},
		construct_response(Req0),
		Req0),
	{ok, Req, State}.

construct_response(Req) ->
   RespBody = "
{\"version\":\"~s\",
 \"scheme\":\"~s\",
 \"host\":\"~s\",
 \"port\":\"~w\",
 \"path\":\"~s\",
 \"method\":\"~s\",
 \"query_params\":\"~s\",
 \"headers\":{~s},
 \"body\":\"~s\"}
",
   Version = cowboy_req:version(Req),
   Scheme = cowboy_req:scheme(Req),
   Host = cowboy_req:host(Req),
   Port = cowboy_req:port(Req),
   Path = cowboy_req:path(Req),
   Method = cowboy_req:method(Req),
   Qs = cowboy_req:qs(Req),
   Headers = parse_headers(cowboy_req:headers(Req)),
   {ok, BodyData, _} = cowboy_req:read_body(Req,
   		#{length => 1000000, period => 1000}),
   RespBody1 = io_lib:format(RespBody,[Version, Scheme, Host, Port, Path, Method, Qs, Headers, BodyData]),
   list_to_binary(RespBody1).

% construct query params as recursive function 
%parse_query_params(QueryParams) ->
%	ParsedParams = string:tokens(QueryParams,"&"),
%	[string:tokens(X,"=") || X <- ParsedParams].

parse_headers(Headers) ->
	maps:fold(fun(K,V,Acc) ->
		        Val = io_lib:format("\"~s\":\"~s\"",[K, V]),
				[Acc|Val]
			  end, [], Headers).

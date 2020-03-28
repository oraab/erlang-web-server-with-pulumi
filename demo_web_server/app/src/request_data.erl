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
 \"query_params\":\"~tp\",
 \"headers\":{~s},
 \"body\":~s~n}
",
   Version = cowboy_req:version(Req),
   Scheme = cowboy_req:scheme(Req),
   Host = cowboy_req:host(Req),
   Port = cowboy_req:port(Req),
   Path = cowboy_req:path(Req),
   Method = cowboy_req:method(Req),
   Qs = parse_query_params(cowboy_req:qs(Req)),
   Headers = parse_headers(cowboy_req:headers(Req)),
   BodyData = retrieve_request_body(Req),
   RespBody1 = io_lib:format(RespBody,[Version, Scheme, Host, Port, Path, Method, Qs, Headers, BodyData]),
   list_to_binary(RespBody1).

parse_headers(Headers) ->
	maps:fold(fun(K,V,Acc) ->
              case K of
                <<"cookie">> ->
                  Val = <<"[redacted]">>,
                  [Acc|Val];
                _Else ->
                  Val = io_lib:format("\"~s\":\"~s\",",[K, V]),
				      [Acc|Val]
              end
			  end, [], Headers).

parse_query_params(QueryParams) -> 
  uri_string:dissect_query(QueryParams).

retrieve_request_body(Req) ->
   {ok, BodyData, _} = cowboy_req:read_body(Req,
      #{length => 1000000, period => 1000}),
      BodyData.
     

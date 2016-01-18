%%%-------------------------------------------------------------------
%%% @copyright (C) 2012-2013, 2600Hz
%%% @doc
%%%
%%% @end
%%% @contributors
%%%-------------------------------------------------------------------
-module(pivot_app).

-behaviour(application).

-include_lib("whistle/include/wh_types.hrl").

-export([start/2, stop/1]).

%%--------------------------------------------------------------------
%% @public
%% @doc Implement the application start behaviour
%%--------------------------------------------------------------------
-spec start(application:start_type(), any()) -> startapp_ret().
start(_Type, _Args) ->
    _ = declare_exchanges(),
    pivot_sup:start_link().

%%--------------------------------------------------------------------
%% @public
%% @doc Implement the application stop behaviour
%%--------------------------------------------------------------------
-spec stop(any()) -> 'ok'.
stop(_State) ->
    exit(whereis('pivot_sup'), 'shutdown'),
    'ok'.


-spec declare_exchanges() -> 'ok'.
declare_exchanges() ->
    _ = wapi_pivot:declare_exchanges(),
    _ = wapi_route:declare_exchanges(),
    _ = wapi_call:declare_exchanges(),
    _ = wapi_dialplan:declare_exchanges(),
    _ = wapi_notifications:declare_exchanges(),
    wapi_self:declare_exchanges().

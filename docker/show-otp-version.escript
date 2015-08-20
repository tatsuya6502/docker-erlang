#!/usr/bin/env escript
%% -*- mode:erlang -*-
%%! -smp enable -sname show_otp_release

%% ----------------------------------------------------------------------
%%  Copyright (c) 2015 Tatsuya Kawano.  All rights reserved.
%%
%%  Licensed under the Apache License, Version 2.0 (the "License");
%%  you may not use this file except in compliance with the License.
%%  You may obtain a copy of the License at
%%
%%      http://www.apache.org/licenses/LICENSE-2.0
%%
%%  Unless required by applicable law or agreed to in writing, software
%%  distributed under the License is distributed on an "AS IS" BASIS,
%%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%  See the License for the specific language governing permissions and
%%  limitations under the License.
%% ----------------------------------------------------------------------

main([]) ->
    OTPRelease = erlang:system_info(otp_release),
    case re:run(OTPRelease, "^R1\\d") of
        {match, _} ->
            %% In R16 or earlier, otp_release has both the major and minor versions.
            io:format("Erlang/OTP ~s has been successfully installed.~n", [OTPRelease]);
        nomatch ->
            %% In 17 or newer, otp_release only has the major version. So get the full
            %% version string from OTP_VERSION file. For further details, see
            %% http://www.erlang.org/doc/system_principles/versions.html
            Path = filename:join([code:root_dir(), "releases", OTPRelease, "OTP_VERSION"]),
            case file:open(Path, [read]) of
                {ok, IODevice} ->
                    case file:read_line(IODevice) of
                        {ok, Line} ->
                            io:format("Erlang/OTP ~s has been successfully installed.~n",
                                      [string:strip(Line, right, $\n)]);
                        Err ->  %% including 'eof'
                            print_error(Path, Err)
                    end,
                    _ = file:close(IODevice);
                Err ->
                    print_error(Path, Err)
            end
    end.

print_error(Path, Err) ->
    io:format("Can't read OTP_VERSION file.~n  path: ~p~n  reason: ~p~n", [Path, Err]).

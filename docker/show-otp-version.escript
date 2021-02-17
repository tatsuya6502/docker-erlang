#!/usr/bin/env escript
%% -*- mode:erlang -*-
%%! -smp enable -sname show_otp_release

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
